private ["_victim","_killer","_groupIsEmpty","_trigger","_unitGroup"];

_victim = _this select 0;
_killer = _this select 1;
_unitGroup = _this select 2;
_groupIsEmpty = _this select 3;

if (_groupIsEmpty) then {
	if (isDedicated) then {
		_trigger = _unitGroup getVariable ["trigger",A3XAI_defaultTrigger];
		[_trigger,true] spawn A3XAI_despawn_dynamic;	//force despawning even if players are present in trigger area.
	} else {
		A3XAI_despawnDynamicGroup_PVS = _unitGroup;
		publicVariableServer "A3XAI_despawnDynamicGroup_PVS";
	};
};

true
