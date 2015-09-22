#define PLOTPOLE_OBJECT "Exile_Construction_Flag_Static"
#define PLOTPOLE_RADIUS 300
#define SERVER_STARTED_INDICATOR "PublicHiveIsLoaded"

private ["_expireTime", "_spawnsCreated", "_startTime", "_cfgWorldName"];

_expireTime = diag_tickTime + 300;
waitUntil {uiSleep 3; !isNil "A3XAI_locations_ready" && {(!isNil SERVER_STARTED_INDICATOR) or {diag_tickTime > _expireTime}}};

if (A3XAI_debugLevel > 0) then {diag_log format ["A3XAI Debug: A3XAI is generating static spawns."];};

_spawnsCreated = 0;
_startTime = diag_tickTime;
_cfgWorldName = configFile >> "CfgWorlds" >> worldName >> "Names";

{
	private ["_placeName","_placePos","_placeType"];
	_placeName = _x select 0;
	_placePos = _x select 1;
	_placeType = _x select 2;
	
	if !((toLower _placeName) in A3XAI_staticBlacklistLocations) then {
		if !(surfaceIsWater _placePos) then {
			private ["_nearbldgs"];
			if ((_placePos nearObjects [PLOTPOLE_OBJECT,PLOTPOLE_RADIUS]) isEqualTo []) then {
				_nearbldgs = _placePos nearObjects ["HouseBase",250];
				_nearBlacklistedAreas = nearestLocations [_placePos,["A3XAI_BlacklistedArea"],1500];
				_spawnPoints = 0;
				{
					_objType = (typeOf _x);
					_objPos = (getPosATL _x);
					if (!(surfaceIsWater _objPos) && {(sizeOf _objType) > 15} && {({_objPos in _x} count _nearBlacklistedAreas) isEqualTo 0}) then {
						_spawnPoints = _spawnPoints + 1;
					} else {
						_nearbldgs deleteAt _forEachIndex;
					};
				} forEach _nearbldgs;
				//if (objNull in _nearbldgs) then {_nearbldgs = _nearbldgs - [objNull];};
				if (_spawnPoints > 5) then {
					_aiCount = [0,0];
					_unitLevel = 0;
					_radiusA = getNumber (_cfgWorldName >> (_x select 0) >> "radiusA");
					_radiusB = getNumber (_cfgWorldName >> (_x select 0) >> "radiusB");
					_patrolRadius = (((_radiusA min _radiusB) max 125) min 300);
					_spawnChance = 0;
					_respawnLimit = -1;
					call {
						if (_placeType isEqualTo "namecitycapital") exitWith {
							_aiCount = [A3XAI_minAI_capitalCity,A3XAI_addAI_capitalCity];
							_unitLevel = A3XAI_unitLevel_capitalCity;
							_spawnChance = A3XAI_spawnChance_capitalCity;
							_respawnLimit = A3XAI_respawnLimit_capitalCity;
						};
						if (_placeType isEqualTo "namecity") exitWith {
							_aiCount = [A3XAI_minAI_city,A3XAI_addAI_city];
							_unitLevel = A3XAI_unitLevel_city;
							_spawnChance = A3XAI_spawnChance_city;
							_respawnLimit = A3XAI_respawnLimit_city;
						};
						if (_placeType isEqualTo "namevillage") exitWith {
							_aiCount = [A3XAI_minAI_village,A3XAI_addAI_village];
							_unitLevel = A3XAI_unitLevel_village;
							_spawnChance = A3XAI_spawnChance_village;
							_respawnLimit = A3XAI_respawnLimit_village;
						};
						if (_placeType isEqualTo "namelocal") exitWith {
							_aiCount = [A3XAI_minAI_remoteArea,A3XAI_addAI_remoteArea];
							_unitLevel = A3XAI_unitLevel_remoteArea;
							_spawnChance = A3XAI_spawnChance_remoteArea;
							_respawnLimit = A3XAI_respawnLimit_remoteArea;
						};
					};
					if ((_spawnChance > 0) && {!(_aiCount isEqualTo [0,0])}) then {
						_trigger = createTrigger ["A3XAI_EmptyDetector", _placePos,false];
						_trigger setTriggerArea [650, 650, 0, false];
						_trigger setTriggerActivation ["ANY", "PRESENT", true];
						_trigger setTriggerTimeout [5, 5, 5, true];
						_trigger setTriggerText _placeName;
						_statements = format ["0 = [%1,%2,%3,thisTrigger,[],%4] call A3XAI_createInfantryQueue;",_aiCount select 0,_aiCount select 1,_patrolRadius,_unitLevel];
						_trigger setTriggerStatements ["{if (isPlayer _x) exitWith {1}} count thisList > 0;", _statements, "0 = [thisTrigger] spawn A3XAI_despawn_static;"];
						_trigger setVariable ["respawnLimit",_respawnLimit];
						_trigger setVariable ["respawnLimitOriginal",_respawnLimit];
						0 = [0,_trigger,[],_patrolRadius,_unitLevel,_nearbldgs,_aiCount,_spawnChance] call A3XAI_initializeTrigger;
						_spawnsCreated = _spawnsCreated + 1;
					};
				} else {
					if (A3XAI_debugLevel > 1) then {diag_log format ["A3XAI Debug: Static spawn not created at %1. Spawn position count: %2",_placeName,(count _nearbldgs)];};
				};
			} else {
				if (A3XAI_debugLevel > 0) then {diag_log format ["A3XAI Debug: Static spawn not created at %1 due to nearby Frequency Jammer.",_placeName];};
			};
		} else {
			if (A3XAI_debugLevel > 0) then {diag_log format ["A3XAI Debug: Static spawn not created at %1 due to water position.",_placeName];};
		};
	} else {
		if (A3XAI_debugLevel > 0) then {diag_log format ["A3XAI Debug: Static spawn not created for blacklisted location %1.",_placeName];};
	};
	uiSleep 0.25;
} forEach A3XAI_locations;

if (A3XAI_debugLevel > 0) then {diag_log format ["A3XAI Debug: %1 has finished generating %2 static spawns in %3 seconds.",__FILE__,_spawnsCreated,(diag_tickTime - _startTime)];};
