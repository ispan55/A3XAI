_action = (_this select 1);

if (_action isEqualTo "IgnoreEnemies") exitWith {
	_unitGroup = _this select 0;
	_unitGroup setBehaviour "CARELESS";
	_unitGroup setCombatMode "BLUE";
	{_x doWatch objNull} forEach (units _unitGroup);

	true
};

if (_action isEqualTo "Behavior_Reset") exitWith {
	_unitGroup setBehaviour "AWARE";
	_unitGroup setCombatMode "YELLOW";

	true
};

false