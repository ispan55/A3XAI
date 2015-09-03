private ["_init","_vehicleType"];

if !(_this isKindOf "AllVehicles") exitWith {false};

_vehicleType = (typeOf _this);
if ((_vehicleType find "_EPOCH") isEqualTo -1) exitWith {false}; //Execute only on _EPOCH vehicles

_init = [configFile >> "CfgVehicles" >> _vehicleType >> "Eventhandlers","init",""] call BIS_fnc_returnConfigEntry;
if !((_init find "bis_fnc_initVehicle") isEqualTo -1) exitWith {false};

_this setVariable ["BIS_enableRandomization",true];
[_this, "", [], false] call BIS_fnc_initVehicle;

if (A3XAI_debugLevel > 1) then {diag_log format ["A3XAI Debug: %1 executed on AI %2.",__FILE__,_vehicleType]};

true
