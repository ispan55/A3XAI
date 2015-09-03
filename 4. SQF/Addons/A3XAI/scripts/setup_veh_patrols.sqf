
waitUntil {uiSleep 0.3; (!isNil "A3XAI_locations_ready" && {!isNil "A3XAI_classnamesVerified"})};

if (A3XAI_maxHeliPatrols > 0) then {
	_nul = [] spawn {
		for "_i" from 0 to ((count A3XAI_heliList) - 1) do {
			_heliType = (A3XAI_heliList select _i) select 0;
			_amount = (A3XAI_heliList select _i) select 1;
			
			if ([_heliType,"vehicle"] call A3XAI_checkClassname) then {
				for "_j" from 1 to _amount do {
					A3XAI_heliTypesUsable pushBack _heliType;
				};
			} else {
				if (A3XAI_debugLevel > 0) then {diag_log format ["A3XAI Debug: %1 attempted to spawn invalid vehicle type %2.",__FILE__,_heliType];};
			};
		};
		
		if (A3XAI_debugLevel > 0) then {diag_log format ["A3XAI Debug: Assembled helicopter list: %1",A3XAI_heliTypesUsable];};
		
		_maxHelis = (A3XAI_maxHeliPatrols min (count A3XAI_heliTypesUsable));
		for "_i" from 1 to _maxHelis do {
			_index = floor (random (count A3XAI_heliTypesUsable));
			_heliType = A3XAI_heliTypesUsable select _index;
			_nul = _heliType spawn A3XAI_spawnVehiclePatrol;
			A3XAI_heliTypesUsable set [_index,objNull];
			A3XAI_heliTypesUsable = A3XAI_heliTypesUsable - [objNull];
			if (_i < _maxHelis) then {uiSleep 20};
		};
	};
	uiSleep 5;
};

if (A3XAI_maxLandPatrols > 0) then {
	_nul = [] spawn {
		for "_i" from 0 to ((count A3XAI_vehList) - 1) do {
			_vehType = (A3XAI_vehList select _i) select 0;
			_amount = (A3XAI_vehList select _i) select 1;
			
			if ([_vehType,"vehicle"] call A3XAI_checkClassname) then {
				for "_j" from 1 to _amount do {
					A3XAI_vehTypesUsable pushBack _vehType;
				};
			} else {
				if (A3XAI_debugLevel > 0) then {diag_log format ["A3XAI Debug: %1 attempted to spawn invalid vehicle type %2.",__FILE__,_vehType];};
			};
		};
		
		if (A3XAI_debugLevel > 0) then {diag_log format ["A3XAI Debug: Assembled vehicle list: %1",A3XAI_vehTypesUsable];};
		
		_maxVehicles = (A3XAI_maxLandPatrols min (count A3XAI_vehTypesUsable));
		for "_i" from 1 to _maxVehicles do {
			_index = floor (random (count A3XAI_vehTypesUsable));
			_vehType = A3XAI_vehTypesUsable select _index;
			_nul = _vehType spawn A3XAI_spawnVehiclePatrol;
			A3XAI_vehTypesUsable set [_index,objNull];
			A3XAI_vehTypesUsable = A3XAI_vehTypesUsable - [objNull];
			if (_i < _maxVehicles) then {uiSleep 20};
		};
	};
};

if (A3XAI_maxUAVPatrols > 0) then {
	_nul = [] spawn {
		for "_i" from 0 to ((count A3XAI_UAVList) - 1) do {
			_vehType = (A3XAI_UAVList select _i) select 0;
			_amount = (A3XAI_UAVList select _i) select 1;
			
			if ([_vehType,"vehicle"] call A3XAI_checkClassname) then {
				for "_j" from 1 to _amount do {
					A3XAI_UAVTypesUsable pushBack _vehType;
				};
			} else {
				if (A3XAI_debugLevel > 0) then {diag_log format ["A3XAI Debug: %1 attempted to spawn invalid vehicle type %2.",__FILE__,_vehType];};
			};
		};
		
		if (A3XAI_debugLevel > 0) then {diag_log format ["A3XAI Debug: Assembled UAV list: %1",A3XAI_UAVTypesUsable];};
		
		_maxVehicles = (A3XAI_maxUAVPatrols min (count A3XAI_UAVTypesUsable));
		for "_i" from 1 to _maxVehicles do {
			_index = floor (random (count A3XAI_UAVTypesUsable));
			_vehType = A3XAI_UAVTypesUsable select _index;
			_vehicleClass = [configFile >> "CfgVehicles" >> _vehType,"vehicleClass",""] call BIS_fnc_returnConfigEntry;
			_nul = _vehType spawn A3XAI_spawn_UV_patrol;
			A3XAI_UAVTypesUsable set [_index,objNull];
			A3XAI_UAVTypesUsable = A3XAI_UAVTypesUsable - [objNull];
			if (_i < _maxVehicles) then {uiSleep 20};
		};
	};
};

if (A3XAI_maxUGVPatrols > 0) then {
	_nul = [] spawn {
		for "_i" from 0 to ((count A3XAI_UGVList) - 1) do {
			_vehType = (A3XAI_UGVList select _i) select 0;
			_amount = (A3XAI_UGVList select _i) select 1;
			
			if ([_vehType,"vehicle"] call A3XAI_checkClassname) then {
				for "_j" from 1 to _amount do {
					A3XAI_UGVTypesUsable pushBack _vehType;
				};
			} else {
				if (A3XAI_debugLevel > 0) then {diag_log format ["A3XAI Debug: %1 attempted to spawn invalid vehicle type %2.",__FILE__,_vehType];};
			};
		};
		
		if (A3XAI_debugLevel > 0) then {diag_log format ["A3XAI Debug: Assembled UGV list: %1",A3XAI_UGVTypesUsable];};
		
		_maxVehicles = (A3XAI_maxUGVPatrols min (count A3XAI_UGVTypesUsable));
		for "_i" from 1 to _maxVehicles do {
			_index = floor (random (count A3XAI_UGVTypesUsable));
			_vehType = A3XAI_UGVTypesUsable select _index;
			_nul = _vehType spawn A3XAI_spawn_UV_patrol;
			A3XAI_UGVTypesUsable set [_index,objNull];
			A3XAI_UGVTypesUsable = A3XAI_UGVTypesUsable - [objNull];
			if (_i < _maxVehicles) then {uiSleep 20};
		};
	};
};
