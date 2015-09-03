private ["_unitGroup", "_vehicle","_inNoAggroArea"];

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

true