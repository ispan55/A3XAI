private ["_vehicle"];

_vehicle = (_this select 0);

if !(isServer) exitWith {false};
if (isNull _vehicle) exitWith {};

_vehicle setVariable ["A3XAI_deathTime",diag_tickTime];

true
