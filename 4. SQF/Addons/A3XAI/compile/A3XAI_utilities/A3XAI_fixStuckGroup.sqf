#define PLAYER_UNITS "Exile_Unit_Player"
#define SPACE_FOR_OBJECT "Land_Coil_F"
#define DEFAULT_UNIT_CLASSNAME "i_survivor_F"
#define PLOTPOLE_OBJECT "Exile_Construction_Flag_Static"
#define PLOTPOLE_RADIUS 300
#define NEAREST_ENEMY_RANGE 300
#define PLAYER_DISTANCE_WITH_LOS 300

private ["_unitGroup", "_vehicle", "_isInfantry", "_nearPlayers", "_leaderPos", "_newPosEmpty","_unitType","_vehicleType","_leader"];

_unitGroup = _this select 0;

_vehicle = (_unitGroup getVariable ["assignedVehicle",objNull]);
_isInfantry = (isNull _vehicle);
_unitType = _unitGroup getVariable ["unitType",""];
_leaderPos = getPosATL (leader _unitGroup);

if (_isInfantry) then {
	_newPosEmpty = _leaderPos findEmptyPosition [0.5,30,SPACE_FOR_OBJECT];

	if !(_newPosEmpty isEqualTo []) then {
		_newPosEmpty = _newPosEmpty isFlatEmpty [0,0,0.75,5,0,false,objNull];
	};

	if (_newPosEmpty isEqualTo []) then {
		_newPosEmpty = [_leaderPos,10 + random(25),random(360),0,[0,0],[25,SPACE_FOR_OBJECT]] call SHK_pos;
	};

	if (({isPlayer _x} count (_newPosEmpty nearEntities [[PLAYER_UNITS,"AllVehicles"], PLAYER_DISTANCE_WITH_LOS]) isEqualTo 0) && {((_newPosEmpty nearObjects [PLOTPOLE_OBJECT,PLOTPOLE_RADIUS]) isEqualTo [])}) then {
		_newPosEmpty set [2,0];
		{
			_x setPosATL _newPosEmpty;
			_x setVelocity [0,0,0.25];
		} forEach (units _unitGroup);
		if (A3XAI_debugLevel > 1) then {diag_log format ["A3XAI Debug: Relocated stuck group %1 (%2) to new location %3m away.",_unitGroup,(_unitGroup getVariable ["unitType","unknown"]),(_leaderPos distance _newPosEmpty)];};
	} else {
		if (A3XAI_debugLevel > 1) then {diag_log format ["A3XAI Debug: Unable to relocate stuck group %1 (%2).",_unitGroup,(_unitGroup getVariable ["unitType","unknown"])];};
	};
} else {
	_newPosEmpty = [0,0,0];
	if (_unitType in ["land","ugv"]) then {
		_keepLooking = true;
		_vehicleType = (typeOf _vehicle);
		while {_keepLooking} do {
			_newPosEmpty = [(getMarkerPos "A3XAI_centerMarker"),300 + random((getMarkerSize "A3XAI_centerMarker") select 0),random(360),0,[2,750],[25,_vehicleType]] call SHK_pos;
			if ((count _newPosEmpty) > 1) then {
				if (({isPlayer _x} count (_newPosEmpty nearEntities [[PLAYER_UNITS,"AllVehicles"], PLAYER_DISTANCE_WITH_LOS]) isEqualTo 0) && {((_newPosEmpty nearObjects [PLOTPOLE_OBJECT,PLOTPOLE_RADIUS]) isEqualTo [])}) then {
					_keepLooking = false;
				};
			} else {
				if (A3XAI_debugLevel > 1) then {diag_log format ["A3XAI Debug: Unable to find road position to relocate AI group %1 %2. Retrying in 15 seconds.",_unitGroup,_vehicleType]};
				uiSleep 15;
			};
		};
	} else {
		_newPosEmpty = [_leaderPos,10 + random(25),random(360),0,[1,300],[25,(typeOf _vehicle)]] call SHK_pos;
	};
	_leader = (leader _unitGroup);
	if ((_leader distance (_leader findNearestEnemy _vehicle)) > NEAREST_ENEMY_RANGE) then {
		_vehicle setPosATL _newPosEmpty;
		_vehicle setVelocity [0,0,0.25];
		{
			if (((vehicle _x) isEqualTo _x) && {(_x distance _vehicle) > 100}) then {
				_newUnitPos = [_vehicle,25,random(360),0,[0,0],[25,DEFAULT_UNIT_CLASSNAME]] call SHK_pos;
				_x setPosATL _newUnitPos;
				_x setVelocity [0,0,0.25];
			};
		} forEach (units _unitGroup);
		if (A3XAI_debugLevel > 1) then {diag_log format ["A3XAI Debug: Relocated stuck group %1 (%2) to new location %3m away.",_unitGroup,(_unitGroup getVariable ["unitType","unknown"]),(_leaderPos distance _newPosEmpty)];};
	} else {
		if (A3XAI_debugLevel > 1) then {diag_log format ["A3XAI Debug: Unable to relocate stuck group %1 (%2) due to nearby enemy presence.",_unitGroup,(_unitGroup getVariable ["unitType","unknown"])];};
	};
};

true