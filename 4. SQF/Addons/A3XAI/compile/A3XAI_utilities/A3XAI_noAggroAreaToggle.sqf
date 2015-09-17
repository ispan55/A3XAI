private ["_unitGroup", "_object", "_nearNoAggroAreas", "_inNoAggroArea", "_objectPos"];

_unitGroup = _this select 0;
_inNoAggroArea = _this select 1;

if (_inNoAggroArea) then {
	if ((combatMode _unitGroup) in ["YELLOW","RED"]) then {
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
