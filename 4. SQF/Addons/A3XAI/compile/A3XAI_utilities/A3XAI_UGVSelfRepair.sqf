private ["_hitArray", "_hitName", "_hitPoint", "_lastRepaired","_vehicle","_unitGroup","_leader"];

_unitGroup = _this select 0;
_vehicle = _this select 1;

_lastRepaired = _vehicle getVariable "LastRepaired";
if (isNil "_lastRepaired") then {
	_lastRepaired = diag_tickTime;
	_vehicle setVariable ["LastRepaired",_lastRepaired];
};

_leader = (leader _unitGroup);
if (((diag_tickTime - _lastRepaired) < 600) or {((_leader distance (_leader findNearestEnemy _leader)) < 500)}) exitWith {false};

_vehicleType = (typeOf _vehicle);
_hitArray = [configFile >> "CfgVehicles" >> _vehicleType,"HitPoints",[]] call BIS_fnc_returnConfigEntry;

{
	_hitName = configfile >> "CfgVehicles" >> _vehicleType >> "HitPoints" >> _x >> "name";
	_hitPoint = _vehicle getHit _hitName;
	if (_hitPoint < 0.75) then {
		_vehicle setHit [_hitName,_hitPoint + 0.25];
		if (A3XAI_debugLevel > 1) then {diag_log format ["A3XAI Debug: Repaired UGV %1 part %2",(typeOf _vehicle),_hitName]};
	};
} forEach _hitArray;

_vehicle setVariable ["LastRepaired",diag_tickTime];

true