private ["_unitGroup", "_vehicle", "_unitsAlive", "_unitLevel", "_trigger", "_rearm" ,"_pos"];
	
_unitGroup = _this select 0;
_vehicle = _this select 1;

_pos = getPosATL _vehicle;
_pos set [2,0];
_unitsAlive = {alive _x} count (units _unitGroup);

if (_unitsAlive isEqualTo 0) exitWith {diag_log format ["A3XAI Error: %1 cannot create trigger area for empty group %2.",__FILE__,_unitGroup];};

/*_nearNoAggroAreas = nearestLocations [_pos,["A3XAI_NoAggroArea"],1500];
if (({if (_pos in _x) exitWith {1}} count _nearNoAggroAreas) isEqualTo 0) then {
} 
} else {
	_unitGroup setVariable ["GroupSize",-1];
	if !(local _unitGroup) then {
		A3XAI_updateGroupSize_PVC = [_unitGroup,-1];
		A3XAI_HCObjectOwnerID publicVariableClient "A3XAI_updateGroupSize_PVC";
	};
	if (A3XAI_debugLevel > 0) then {
		diag_log format ["A3XAI Debug: Vehicle group %1 inside no-aggro area. Deleting group.",_unitGroup];
	};
};*/
{
	if (alive _x) then {
		if !(canMove _x) then {_x setHit ["legs",0]};
		unassignVehicle _x;
	};
} count (units _unitGroup);

for "_i" from ((count (waypoints _unitGroup)) - 1) to 0 step -1 do {
	deleteWaypoint [_unitGroup,_i];
};

_unitGroup setCombatMode "YELLOW";
_unitGroup setBehaviour "AWARE";
[_unitGroup,_pos] call A3XAI_setFirstWPPos;
0 = [_unitGroup,_pos,75] spawn A3XAI_BIN_taskPatrol;
	
_unitLevel = _unitGroup getVariable ["unitLevel",1];

_trigger = createTrigger ["A3XAI_EmptyDetector",_pos,false];
_trigger setTriggerArea [600, 600, 0, false];
_trigger setTriggerActivation ["ANY", "PRESENT", true];
_trigger setTriggerTimeout [5, 5, 5, true];
_trigger setTriggerText (format ["AI Vehicle Group %1",mapGridPosition _vehicle]);
_trigger setTriggerStatements ["{if (isPlayer _x) exitWith {1}} count thisList != 0;","","0 = [thisTrigger] spawn A3XAI_despawn_static;"];
_trigger setVariable ["isCleaning",false];
_trigger setVariable ["GroupArray",[_unitGroup]];
_trigger setVariable ["unitLevel",_unitLevel];
_trigger setVariable ["maxUnits",[_unitsAlive,0]];
_trigger setVariable ["respawn",false]; 					//landed AI units should never respawn
_trigger setVariable ["permadelete",true]; 	//units should be permanently despawned
_trigger setVariable ["spawnType","vehiclecrew"];

_unitGroup setVariable ["GroupSize",_unitsAlive];
_unitGroup setVariable ["unitType","vehiclecrew"];
_unitGroup setVariable ["trigger",_trigger];

[_trigger,"A3XAI_staticTriggerArray"] call A3XAI_updateSpawnCount;
0 = [_trigger] spawn A3XAI_despawn_static;

if !(local _unitGroup) then {
	A3XAI_sendGroupTriggerVars_PVC = [_unitGroup,[_unitGroup],75,1,1,[_unitsAlive,0],0,"vehiclecrew",false,true];
	A3XAI_HCObjectOwnerID publicVariableClient "A3XAI_sendGroupTriggerVars_PVC";
};



true