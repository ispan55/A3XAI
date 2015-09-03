private ["_unitGroup", "_vehicle", "_lastRegroupCheck","_inNoAggroArea"];

_unitGroup = _this select 0;
_vehicle = _this select 1;

_inNoAggroArea = _this call A3XAI_checkInNoAggroArea;

if (_inNoAggroArea) then {
	if ((combatMode _unitGroup) isEqualTo "YELLOW") then {
		[_unitGroup,"IgnoreEnemies"] call A3XAI_forceBehavior;
		if (A3XAI_debugLevel > 1) then {diag_log format ["A3XAI Debug: Group %1 in no-aggro zone.",_unitGroup];};
	};
} else {
	if ((combatMode _unitGroup) isEqualTo "BLUE") then {
		[_unitGroup,"Behavior_Reset"] call A3XAI_forceBehavior;
		if (A3XAI_debugLevel > 1) then {diag_log format ["A3XAI Debug: Group %1 exited no-aggro zone.",_unitGroup];};
	};
};

_lastRegroupCheck = _vehicle getVariable "LastRegroupCheck";
if (isNil "_lastRegroupCheck") then {
	_lastRegroupCheck = diag_tickTime;
	_vehicle setVariable ["LastRegroupCheck",0];
};

if ((diag_tickTime - _lastRegroupCheck) > 30) then {
	if ((alive _vehicle) && {_unitGroup getVariable ["regrouped",true]} && {({if ((_x distance _vehicle) > 175) exitWith {1}} count (assignedCargo _vehicle)) > 0}) then {
		_unitGroup setVariable ["regrouped",false];
		[_unitGroup,_vehicle] call A3XAI_vehCrewRegroup;
	};

	_vehicle setVariable ["LastRegroupCheck",diag_tickTime];
};

true