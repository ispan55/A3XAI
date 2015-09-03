private ["_unitGroup","_waypoint","_pos"];
_unitGroup = _this select 0;
_pos = _this select 1;

_waypoint = _unitGroup addWaypoint [_pos,0];
_waypoint setWaypointType "MOVE";
_waypoint setWaypointCompletionRadius 30;
_waypoint setWaypointStatements ["true","if !(local this) exitWith {}; _unitGroup = (group this); deleteWaypoint [_unitGroup,(currentWaypoint _unitGroup)]; _unitGroup setCurrentWaypoint ((waypoints _unitGroup) call BIS_fnc_selectRandom);"];

if (A3XAI_debugLevel > 1) then {diag_log format ["A3XAI Debug: Group %1 assigned temporary waypoint at %2.",_unitGroup,_pos];};

_waypoint