A3XAI_setGroupTriggerVars = compileFinal preprocessFileLineNumbers format ["%1\compile\A3XAI_headlessclient\A3XAI_setGroupTriggerVars.sqf",A3XAI_directory]; 
A3XAI_handlestatic = compileFinal preprocessFileLineNumbers format ["%1\compile\A3XAI_headlessclient\A3XAI_handlestatic.sqf",A3XAI_directory]; 
A3XAI_handlestaticcustom = compileFinal preprocessFileLineNumbers format ["%1\compile\A3XAI_headlessclient\A3XAI_handlestaticcustom.sqf",A3XAI_directory]; 
A3XAI_handleland = compileFinal preprocessFileLineNumbers format ["%1\compile\A3XAI_headlessclient\A3XAI_handleland.sqf",A3XAI_directory]; 
A3XAI_handleair = compileFinal preprocessFileLineNumbers format ["%1\compile\A3XAI_headlessclient\A3XAI_handleair.sqf",A3XAI_directory]; 
A3XAI_handleaircustom = compileFinal preprocessFileLineNumbers format ["%1\compile\A3XAI_headlessclient\A3XAI_handleaircustom.sqf",A3XAI_directory]; 
A3XAI_handleair_reinforce = compileFinal preprocessFileLineNumbers format ["%1\compile\A3XAI_headlessclient\A3XAI_handleair_reinforce.sqf",A3XAI_directory];
A3XAI_handlelandcustom = compileFinal preprocessFileLineNumbers format ["%1\compile\A3XAI_headlessclient\A3XAI_handlelandcustom.sqf",A3XAI_directory]; 
A3XAI_handledynamic = compileFinal preprocessFileLineNumbers format ["%1\compile\A3XAI_headlessclient\A3XAI_handledynamic.sqf",A3XAI_directory]; 
A3XAI_handlerandom = compileFinal preprocessFileLineNumbers format ["%1\compile\A3XAI_headlessclient\A3XAI_handlerandom.sqf",A3XAI_directory]; 
A3XAI_handleuav = compileFinal preprocessFileLineNumbers format ["%1\compile\A3XAI_headlessclient\A3XAI_handleuav.sqf",A3XAI_directory]; 
A3XAI_handleugv = compileFinal preprocessFileLineNumbers format ["%1\compile\A3XAI_headlessclient\A3XAI_handleugv.sqf",A3XAI_directory]; 
A3XAI_handlevehiclecrew = compileFinal preprocessFileLineNumbers format ["%1\compile\A3XAI_headlessclient\A3XAI_handlevehiclecrew.sqf",A3XAI_directory]; 
A3XAI_addNewGroup = compileFinal preprocessFileLineNumbers format ["%1\compile\A3XAI_headlessclient\A3XAI_addNewGroup.sqf",A3XAI_directory]; 
A3XAI_addHunterGroup = compileFinal preprocessFileLineNumbers format ["%1\compile\A3XAI_headlessclient\A3XAI_addHunterGroup.sqf",A3XAI_directory]; 
A3XAI_updateGroupSizeHC = compileFinal preprocessFileLineNumbers format ["%1\compile\A3XAI_headlessclient\A3XAI_updateGroupSizeHC.sqf",A3XAI_directory];
A3XAI_airReinforcementDetection = compileFinal preprocessFileLineNumbers format ["%1\compile\A3XAI_headlessclient\A3XAI_airReinforcementDetection.sqf",A3XAI_directory]; 
A3XAI_cleanupReinforcementHC = compileFinal preprocessFileLineNumbers format ["%1\compile\A3XAI_headlessclient\A3XAI_cleanupReinforcementHC.sqf",A3XAI_directory]; 
A3XAI_setLoadoutVariables_HC = compileFinal preprocessFileLineNumbers format ["%1\compile\A3XAI_headlessclient\A3XAI_setLoadoutVariables_HC.sqf",A3XAI_directory];
A3XAI_createGroupTriggerObject = compileFinal preprocessFileLineNumbers format ["%1\compile\A3XAI_headlessclient\A3XAI_createGroupTriggerObject.sqf",A3XAI_directory];

A3XAI_requestGroupVars = compileFinal '
	A3XAI_getGroupTriggerVars_PVS = _this;
	publicVariableServer "A3XAI_getGroupTriggerVars_PVS";
	true
';

A3XAI_updateServerLoot = compileFinal '
	A3XAI_updateGroupLoot_PVS = _this;
	publicVariableServer "A3XAI_updateGroupLoot_PVS";
	true
';

A3XAI_updateGroupLootPoolHC = compileFinal '
	private ["_unitGroup","_lootPool"];
	_unitGroup = _this select 0;
	_lootPool = _this select 1;
	
	_unitGroup setVariable ["LootPool",_lootPool];
	
	if (A3XAI_debugLevel > 1) then {diag_log format ["A3XAI Debug: Updated group %1 loot pool to %2.",_unitGroup,_lootPool];};
	
	true
';

A3XAI_setCurrentWaypointHC = compileFinal '
	private ["_unitGroup","_waypointIndex"];
	_unitGroup = _this select 0;
	_waypointIndex = _this select 1;
	_unitGroup setCurrentWaypoint [_unitGroup,_waypointIndex];
	true
';

A3XAI_setBehaviorHC = compileFinal '
	private ["_unitGroup","_mode"];
	_unitGroup = _this select 0;
	_mode = _this select 1;
	
	call {
		if (_mode isEqualTo 0) exitWith {
			_unitGroup setBehaviour "CARELESS";
			{_x doWatch objNull} forEach (units _unitGroup);
			_unitGroup setVariable ["EnemiesIgnored",true];
			true
		};
		if (_mode isEqualTo 1) exitWith {
			_unitGroup setBehaviour "AWARE";
			_unitGroup setVariable ["EnemiesIgnored",false];
			true
		};
		false
	};
';

diag_log "[A3XAI] A3XAI HC functions loaded.";
