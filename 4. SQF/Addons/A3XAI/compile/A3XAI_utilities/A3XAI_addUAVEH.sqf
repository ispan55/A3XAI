if (isNull _this) exitWith {};

_this addEventHandler ["Killed","_this call A3XAI_UAV_destroyed"];

if (A3XAI_UAVDetectOnly) then {
	_this addEventHandler ["Hit","_this call A3XAI_defensiveAggression"];
};

true