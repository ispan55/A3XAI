private["_victim","_killer","_unitGroup","_unitType","_unitsAlive"];

_victim = _this select 0;
_killer = _this select 1;
_unitGroup = _this select 2;
_unitType = _this select 3;
_unitsAlive = if ((count _this) > 4) then {_this select 4} else {0};

if (isPlayer _killer) then {
	if !(_victim getVariable ["CollisionKilled",false]) then {
		_unitLevel = _unitGroup getVariable ["unitLevel",1];
		if (isDedicated) then {
			0 = [_victim,_unitLevel] spawn A3XAI_generateLoot;
		} else {
			A3XAI_generateLoot_PVS = [_victim,_unitLevel];
			publicVariableServer "A3XAI_generateLoot_PVS";
		};
	} else {
		_victim call A3XAI_purgeUnitGear;
		if (A3XAI_debugLevel > 0) then {diag_log format ["A3XAI Debug: %1 AI unit %2 was killed by collision damage caused by %3. Unit gear cleared.",_unitType,_victim,_killer]};
	};
} else {
	if (_killer isEqualTo _victim) then {
		_victim call A3XAI_purgeUnitGear;
		if (A3XAI_debugLevel > 0) then {diag_log format ["A3XAI Debug: %1 AI unit %2 was killed by self. Unit gear cleared.",_unitType,_victim]};
	};
};

true
