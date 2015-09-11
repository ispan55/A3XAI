private ["_object"];

_object = _this;

_object removeAllEventHandlers "GetIn";
_object lock 1;
_object enableCopilot true;
_object enableRopeAttach true;
_object setFuel (random 1);

_object addEventHandler ["GetIn",{
	if (isPlayer (_this select 2)) then {
		(_this select 0) call A3XAI_releaseVehicleNow;
	};
}];

if (A3XAI_debugLevel > 0) then {diag_log format ["A3XAI Debug: Released AI vehicle %1 at %2 for player access.",(typeOf _object),(getPosATL _object)];};

true
