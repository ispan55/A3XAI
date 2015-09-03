private ["_UAVGroup", "_unitType", "_unitGroup"];

_UAVGroup = _this select 0;
_unitType = _this select 1;

_unitGroup = grpNull;
if !((side _UAVGroup) isEqualTo east) then {
	_unitGroup = [_unitType] call A3XAI_createGroup;
	(units _UAVGroup) joinSilent _unitGroup;
	deleteGroup _UAVGroup;
	//diag_log format ["Debug: Created UV Group %1.",_unitGroup];
} else {
	_unitGroup = _UAVGroup;
	_unitGroup setVariable ["unitType",_unitType];
	[_unitGroup,true] call A3XAI_updGroupCount;
	//diag_log format ["Debug: Retained UV Group %1.",_unitGroup];
};

{
	_x call A3XAI_addUVUnitEH;
} forEach (units _unitGroup);

_unitGroup;
