private ["_unitGroup","_unitLevel","_vehicle","_maxGunners","_fnc_addGunner","_gunnersAdded"];

_unitGroup = _this select 0;
_unitLevel = _this select 1;
_vehicle = _this select 2;
_maxGunners = _this select 3;

_vehicleTurrets = allTurrets [_vehicle,false];
_gunnersAdded = 0;

_fnc_addGunner = {
	private ["_gunner","_vehicle","_unitGroup","_turretPosition","_unitLevel"];
	_vehicle = _this select 0;
	_turretPosition = _this select 1;
	_unitGroup = _this select 2;
	_unitLevel = _this select 3;
	
	_gunner = [_unitGroup,_unitLevel,[0,0,0]] call A3XAI_createUnit;
	_nvg = _gunner call A3XAI_addTempNVG;
	_gunner assignAsTurret [_vehicle,_turretPosition];
	_gunner moveInTurret [_vehicle,_turretPosition];
	
	_gunner
};

{
	private ["_turretWeapons","_turretMagazines"];
	_turretWeapons = _vehicle weaponsTurret _x;
	if !(_turretWeapons isEqualTo []) then {
		_turretMagazines = _vehicle magazinesTurret _x;
		if !(_turretMagazines isEqualTo []) then {
			[_vehicle,_x,_unitGroup,_unitLevel] call _fnc_addGunner;
			_gunnersAdded = _gunnersAdded + 1;
			if (A3XAI_debugLevel > 1) then {diag_log format ["A3XAI Debug: Added gunner unit %1 to %2 %3 with weapon %4.",_gunnersAdded,_unitGroup,(typeOf _vehicle),(_turretWeapons select 0)];};
		};
	};
	if (_gunnersAdded isEqualTo _maxGunners) exitWith {};
} forEach _vehicleTurrets;

_gunnersAdded