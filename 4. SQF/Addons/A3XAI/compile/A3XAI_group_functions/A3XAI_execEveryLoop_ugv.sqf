private ["_unitGroup", "_vehicle", "_lastAggro", "_lastRepaired", "_vehicleType", "_hitArray", "_hitName", "_hitPoint","_inNoAggroArea","_inArea","_result"];

_unitGroup = _this select 0;
_vehicle = _this select 1;

if (A3XAI_UGVDetectOnly) then {
	_lastAggro = _vehicle getVariable "AggroTime";
	if (isNil "AggroTime") then {
		_lastAggro = diag_tickTime - 180;
		_vehicle setVariable ["AggroTime",0];
	};

	if ((diag_tickTime - _lastAggro) > 180) then {
		if ((combatMode _unitGroup) isEqualTo "YELLOW") then {
			[_unitGroup,"IgnoreEnemies"] call A3XAI_forceBehavior;
			if (A3XAI_debugLevel > 1) then {diag_log format ["A3XAI Debug: Reset Group %1 %2 UGV to non-hostile mode.",_unitGroup,(typeOf _vehicle)]};
		};
	};
} else {
	_inArea = _vehicle call A3XAI_checkInNoAggroArea;
	_result = [_unitGroup,_inArea] call A3XAI_noAggroAreaToggle;
};

_lastRepaired = _vehicle getVariable "LastRepaired";
if (isNil "_lastRepaired") then {
	_lastRepaired = diag_tickTime;
	_vehicle setVariable ["LastRepaired",0];
};

if ((diag_tickTime - _lastRepaired) > 600) then {
	_vehicleType = (typeOf _vehicle);
	_hitArray = [configFile >> "CfgVehicles" >> _vehicleType,"HitPoints",[]] call BIS_fnc_returnConfigEntry;

	{
		_hitName = configfile >> "CfgVehicles" >> _vehicleType >> "HitPoints" >> _x >> "name";
		_hitPoint = _vehicle getHit _hitName;
		if (_hitPoint < 0.8) then {
			_vehicle setHit [_hitName,_hitPoint + 0.2];
			if (A3XAI_debugLevel > 1) then {diag_log format ["A3XAI Debug: Repaired %1 UGV %2 part %3",_unitGroup,(typeOf _vehicle),_hitName]};
		};
	} forEach _hitArray;

	_vehicle setVariable ["LastRepaired",diag_tickTime];
};

true