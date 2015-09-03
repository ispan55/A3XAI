private ["_kryptoDevice","_kryptoPos","_kryptoPickup","_arrowObject"];

_kryptoDevice = _this select 0;
_kryptoPos = _this select 1;

if (isNull _kryptoDevice) exitWith {};

_arrowObject = createVehicle ["Sign_Arrow_F",_kryptoPos,[],0,"CAN_COLLIDE"];
_arrowObject attachTo [_kryptoDevice,[0,0,2]];

_kryptoPickup = createTrigger ["A3XAI_EmptyDetector",_kryptoPos,false];
_kryptoPickup setTriggerArea [1, 1, 0, false];
_kryptoPickup setTriggerActivation ["ANY", "PRESENT", true];
_kryptoPickup setTriggerTimeout [5, 5, 5, true];
_kryptoPickup setTriggerStatements ["{if (isPlayer _x) exitWith {1}} count thisList > 0;","[thisList,thisTrigger] call A3XAI_activateKryptoPickup;",""];

_kryptoPickup attachTo [_kryptoDevice,[0,0,0]];

_kryptoPickup setVariable ["A3XAI_kryptoGenTime",diag_tickTime];
_kryptoPickup setVariable ["A3XAI_kryptoObject",_kryptoDevice];
_kryptoPickup setVariable ["A3XAI_arrowObject",_arrowObject];
_kryptoDevice setVariable ["A3XAI_kryptoArea",_kryptoPickup];

A3XAI_kryptoAreas pushBack _kryptoPickup;

if (A3XAI_debugLevel > 1) then {diag_log format ["A3XAI Debug: Generated krypto pickup assist area at %1.",_kryptoPos];};

_kryptoPickup