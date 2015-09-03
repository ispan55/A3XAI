//Respawn handler stage 2
#define PROCESSING_WAIT_TIME 5 //Minimum time delay between respawns.

waitUntil {uiSleep 3; diag_tickTime > A3XAI_nextRespawnTime};

A3XAI_respawnActive = true;							//First respawn is now being processed, so deny subsequent attempts to modify the initial wait time.
A3XAI_queueActive = nil;
A3XAI_nextRespawnTime = nil;

while {(count A3XAI_respawnQueue) > 0} do {
	private ["_minDelay","_delay"];

	_minDelay = -1;
	//diag_log format ["DEBUG: Contents of respawn queue before cleanup stage 1: %1.",A3XAI_respawnQueue];
	//Remove expired entries before proceeding.
	{
		if (((typeName (_x select 3)) isEqualTo "GROUP") && {(isNull (_x select 3))}) then {
			A3XAI_respawnQueue set [_forEachIndex,objNull];
		};
	} forEach A3XAI_respawnQueue;
	//diag_log format ["DEBUG: Contents of respawn queue before cleanup stage 2: %1.",A3XAI_respawnQueue];
	if (objNull in A3XAI_respawnQueue) then {
		A3XAI_respawnQueue = A3XAI_respawnQueue - [objNull];
		//diag_log "DEBUG :: Cleaned despawned groups from respawn queue.";
	};
	//diag_log format ["DEBUG: Contents of respawn queue after cleanup: %1.",A3XAI_respawnQueue];
	
	//Begin examining queue entries.
	for "_i" from 0 to ((count A3XAI_respawnQueue) - 1) do {
		_timeToRespawn = (A3XAI_respawnQueue select _i) select 0;
		//If enough time has passed to respawn the group.
		if (diag_tickTime > _timeToRespawn) then {
			_mode = (A3XAI_respawnQueue select _i) select 1;
			call {
				if (_mode isEqualTo 0) exitWith {
					//Infantry AI respawn
					_trigger = (A3XAI_respawnQueue select _i) select 2;
					_unitGroup = (A3XAI_respawnQueue select _i) select 3;
					_grpArray = _trigger getVariable ["GroupArray",[]];
					if ((_unitGroup in _grpArray) && {((_unitGroup getVariable ["GroupSize",0]) isEqualTo 0)}) then {
						if ((triggerStatements _trigger select 1) isEqualTo "") then {
							//Trigger is active, so respawn the group
							_maxUnits = _trigger getVariable ["maxUnits",[1,0]];
							_respawned = [_unitGroup,_trigger,_maxUnits] call A3XAI_respawnGroup;
							if ((A3XAI_debugLevel > 0) && {!_respawned}) then {diag_log format ["A3XAI Debug: No units were respawned for group %1 at %2. Group %1 reinserted into respawn queue.",_unitGroup,(triggerText _trigger)];};
						} else {
							//Trigger is inactive (despawned or deleted) so clean up group instead
							if (A3XAI_debugLevel > 0) then {diag_log format ["A3XAI Debug: Spawn area %1 has already been despawned. Cleaning up group %2.",triggerText _trigger,_unitGroup]};
							_unitGroup call A3XAI_deleteGroup;
							if (!isNull _trigger) then {
								_trigger setVariable ["GroupArray",_grpArray - [grpNull]];
							};
						};
					};
				};
				if (_mode isEqualTo 1) exitWith {
					//Custom vehicle AI respawn
					_respawnParams = (A3XAI_respawnQueue select _i) select 2;
					_nul = _respawnParams spawn A3XAI_spawnVehicleCustom;
					if (A3XAI_debugLevel > 0) then {diag_log format ["A3XAI Debug: Respawning custom AI vehicle patrol with params %1",((A3XAI_respawnQueue select _i) select 2)]};
				};
				if (_mode isEqualTo 2) exitWith {
					//Vehicle AI patrol respawn
					_vehicleTypeOld = (A3XAI_respawnQueue select _i) select 2;
					if (_vehicleTypeOld isKindOf "Air") then { //Air-type vehicle AI patrol respawn
						A3XAI_heliTypesUsable pushBack _vehicleTypeOld;
						_index = floor (random (count A3XAI_heliTypesUsable));
						_vehicleTypeNew = A3XAI_heliTypesUsable select _index;
						_nul = _vehicleTypeNew spawn A3XAI_spawnVehiclePatrol;
						A3XAI_heliTypesUsable set [_index,objNull];
						A3XAI_heliTypesUsable = A3XAI_heliTypesUsable - [objNull];
						if (A3XAI_debugLevel > 0) then {diag_log format ["A3XAI Debug: Respawning AI air vehicle type patrol %1.",_vehicleTypeNew]};
					} else {
						if (_vehicleTypeOld isKindOf "LandVehicle") then { //Land-type vehicle AI patrol respawn
							A3XAI_vehTypesUsable pushBack _vehicleTypeOld;
							_index = floor (random (count A3XAI_vehTypesUsable));
							_vehicleTypeNew = A3XAI_vehTypesUsable select _index;	
							_nul = _vehicleTypeNew spawn A3XAI_spawnVehiclePatrol;
							A3XAI_vehTypesUsable set [_index,objNull];
							A3XAI_vehTypesUsable = A3XAI_vehTypesUsable - [objNull];
							if (A3XAI_debugLevel > 0) then {diag_log format ["A3XAI Debug: Respawning AI land vehicle patrol type %1.",_vehicleTypeNew]};
						};
					};
				};
				if (_mode isEqualTo 3) exitWith {
					//UAV/UGV respawn
					_vehicleTypeOld = (A3XAI_respawnQueue select _i) select 2;
					if (_vehicleTypeOld isKindOf "Air") then {
						A3XAI_UAVTypesUsable pushBack _vehicleTypeOld;
						_index = floor (random (count A3XAI_UAVTypesUsable));
						_vehicleTypeNew = A3XAI_UAVTypesUsable select _index;
						_nul = _vehicleTypeNew spawn A3XAI_spawn_UV_patrol;
						A3XAI_UAVTypesUsable set [_index,objNull];
						A3XAI_UAVTypesUsable = A3XAI_UAVTypesUsable - [objNull];
						if (A3XAI_debugLevel > 0) then {diag_log format ["A3XAI Debug: Respawning UAV patrol %1.",_vehicleTypeNew]};
					} else {
						if (_vehicleTypeOld isKindOf "LandVehicle") then {
							A3XAI_UGVTypesUsable pushBack _vehicleTypeOld;
							_index = floor (random (count A3XAI_UGVTypesUsable));
							_vehicleTypeNew = A3XAI_UGVTypesUsable select _index;	
							_nul = _vehicleTypeNew spawn A3XAI_spawn_UV_patrol;
							A3XAI_UGVTypesUsable set [_index,objNull];
							A3XAI_UGVTypesUsable = A3XAI_UGVTypesUsable - [objNull];
							if (A3XAI_debugLevel > 0) then {diag_log format ["A3XAI Debug: Respawning UGV patrol type %1.",_vehicleTypeNew]};
						};
					};
				};
			};
			A3XAI_respawnQueue set [_i,objNull];
			uiSleep PROCESSING_WAIT_TIME;
		} else {
			//Find shortest delay to next group respawn.
			_delay = ((_timeToRespawn - diag_tickTime) max PROCESSING_WAIT_TIME);
			//diag_log format ["DEBUG :: Comparing new respawn time %1 with previous %2.",_delay,_minDelay];
			if (_minDelay > 0) then {
				//If next delay time is smaller than the current minimum delay, use it instead.
				if (_delay < _minDelay) then {
					_minDelay = _delay;
					//diag_log format ["DEBUG :: Found shorter respawn interval: %1 seconds.",_minDelay];
				};
			} else {
				//Initialize minimum delay to first found delay.
				_minDelay = _delay;
				//diag_log format ["DEBUG :: Set respawn interval to %1 seconds.",_minDelay];
			};
		};
	};
	//Remove processed entries
	if (objNull in A3XAI_respawnQueue) then {
		A3XAI_respawnQueue = A3XAI_respawnQueue - [objNull];
		//diag_log "DEBUG :: Cleaned respawned groups from respawn queue.";
	};
	if (_minDelay > -1) then {
		if (A3XAI_debugLevel > 0) then {diag_log format ["A3XAI Debug: %1 groups left in respawn queue. Next group is scheduled to respawn in %2 seconds.",(count A3XAI_respawnQueue),_minDelay];};
		uiSleep _minDelay;
	};
};

A3XAI_respawnActive = nil;
if (A3XAI_debugLevel > 0) then {diag_log "A3XAI Debug: Respawn queue is empty. Exiting respawn handler. (respawnHandler)";};
