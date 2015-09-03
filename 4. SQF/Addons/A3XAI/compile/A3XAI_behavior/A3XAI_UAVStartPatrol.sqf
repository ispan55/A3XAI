private ["_unitGroup","_tooClose","_detectionWaypoint","_exitWaypoint","_vehicle","_dirPosToVehicle","_locationSelected"];
_unitGroup = _this select 0;

_vehicle = _unitGroup getVariable ["assignedVehicle",objNull];

_tooClose = true;
_locationSelected = [0,0,0];

while {_tooClose} do {
	_locationSelected = (A3XAI_locationsAir call A3XAI_selectRandom) select 1;
	if (((waypointPosition [_unitGroup,0]) distance _locationSelected) > 300) then {
		_tooClose = false;
	} else {
		uiSleep 0.1;
	};
};

_dirPosToVehicle = [_locationSelected,_vehicle] call BIS_fnc_dirTo;
_detectionWaypoint = [_locationSelected,100+(random 350),_dirPosToVehicle,1] call SHK_pos;
[_unitGroup,0] setWaypointPosition [_detectionWaypoint,0]; 

_dirPosToVehicle = [_vehicle,_locationSelected] call BIS_fnc_dirTo;
_exitWaypoint = [_detectionWaypoint,300+(random 100),_dirPosToVehicle,1] call SHK_pos;
[_unitGroup,2] setWaypointPosition [_detectionWaypoint,0];

_unitGroup setVariable ["SearchLength",(_detectionWaypoint distance _exitWaypoint)];

if (A3XAI_debugLevel > 1) then {diag_log format ["A3XAI Debug: Group %1 search length %2, waypoint position %3.",_unitGroup,_unitGroup getVariable "SearchLength",_locationSelected];};
