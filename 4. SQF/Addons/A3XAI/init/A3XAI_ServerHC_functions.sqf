diag_log "[A3XAI] Compiling A3XAI HC functions.";

A3XAI_transferGroupToHC = compileFinal preprocessFileLineNumbers format ["%1\compile\A3XAI_headlessclient_server\A3XAI_transferGroupToHC.sqf",A3XAI_directory];
A3XAI_HCGroupToServer = compileFinal preprocessFileLineNumbers format ["%1\compile\A3XAI_headlessclient_server\A3XAI_transferGroupToServer.sqf",A3XAI_directory];
A3XAI_getGroupTriggerVars = compileFinal preprocessFileLineNumbers format ["%1\compile\A3XAI_headlessclient_server\A3XAI_getGroupTriggerVars.sqf",A3XAI_directory];
A3XAI_updateGroupLootPool = compileFinal preprocessFileLineNumbers format ["%1\compile\A3XAI_headlessclient_server\A3XAI_updateGroupLootPool.sqf",A3XAI_directory];
A3XAI_HCListener = compileFinal preprocessFileLineNumbers format ["%1\compile\A3XAI_headlessclient_server\A3XAI_HCListener.sqf",A3XAI_directory];
A3XAI_updateGroupSizeServer = compileFinal preprocessFileLineNumbers format ["%1\compile\A3XAI_headlessclient_server\A3XAI_updateGroupSizeServer.sqf",A3XAI_directory];
A3XAI_registerDeath = compileFinal preprocessFileLineNumbers format ["%1\compile\A3XAI_headlessclient_server\A3XAI_registerDeath.sqf",A3XAI_directory];

A3XAI_protectRemoteGroup = compileFinal '
	private ["_unitGroup","_dummy"];
	_unitGroup = _this select 0;
	_dummy = _this select 1;
	_unitGroup setVariable ["dummyUnit",_dummy];
	true
';

A3XAI_setBehavior = compileFinal '
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

diag_log "[A3XAI] A3XAI HC functions compiled.";