private ["_unitGroup", "_currentWaypoint"];

_unitGroup = _this;

_currentWaypoint = (currentWaypoint _unitGroup);
_pos = (waypointPosition _currentWaypoint);
deleteWaypoint [_unitGroup,_currentWaypoint]; 
[_unitGroup,"Behavior_Reset"] call A3XAI_forceBehavior;
0 = [_unitGroup,_pos,75] spawn A3XAI_BIN_taskPatrol;

true