#define DISTANCE_BUFFER 50

private ["_unitGroup", "_vehicle", "_inArea", "_result", "_trigger", "_maxDistance"];

_unitGroup = _this select 0;
//_vehicle = _this select 1;

_vehicle = (leader _unitGroup);
_inArea = _vehicle call A3XAI_checkInNoAggroArea;
_result = [_unitGroup,_inArea] call A3XAI_noAggroAreaToggle;

if !(_inArea) then {
	_trigger = _unitGroup getVariable "trigger";
	if !(isNil "_trigger") then {
		_maxDistance = _unitGroup getVariable ["patrolDist",250];
		if ((_vehicle distance _trigger) > (_maxDistance + DISTANCE_BUFFER)) then {
			(units _unitGroup) doMove (getPosATL _trigger);
			if (A3XAI_debugLevel > 0) then {diag_log format ["A3XAI Debug: Group %1 moved beyond allowed patrol radius, ordering group towards spawn center.",_unitGroup];};
		};
	};
};

true
