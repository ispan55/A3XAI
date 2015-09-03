private ["_killer", "_victim", "_killerRespectPoints", "_fragAttributes", "_killerPlayerUID", "_lastKillAt", "_vehicleKiller", "_killStack", "_distance", "_distanceBonus", "_overallRespectChange", "_newKillerScore", "_killMessage", "_newKillerFrags"];

_killer = _this select 0;
_victim = _this select 1;

_fragAttributes = [];

if (A3XAI_enableRespectRewards) then {
	_killerRespectPoints = [];
	_killerPlayerUID = getPlayerUID _killer;

	_vehicleKiller = (vehicle _killer);
	if (_vehicleKiller isEqualTo _killer) then {
		if (currentWeapon _killer isEqualTo "Exile_Melee_Axe") then {
			if (A3XAI_respect_humiliationBonus > 0) then {
				_fragAttributes pushBack "Humiliation";
				_killerRespectPoints pushBack ["HUMILIATION", A3XAI_respect_humiliationBonus];
			};
		} else {
			if (A3XAI_respect_fraggedBonus > 0) then {
				//_fragAttributes pushBack "ENEMY FRAGGED";
				_fragAttributes pushBack "ENEMY AI FRAGGED";
				//_killerRespectPoints pushBack ["ENEMY FRAGGED", A3XAI_respect_fraggedBonus];
				_killerRespectPoints pushBack ["ENEMY AI FRAGGED", A3XAI_respect_fraggedBonus];
			};
		};
	} else {
		if ((driver _vehicleKiller) isEqualTo _killer) then {
			if (A3XAI_respect_roadkillBonus > 0) then {
				_fragAttributes pushBack "Road Kill";
				_killerRespectPoints pushBack ["Road Kill", A3XAI_respect_roadkillBonus];
			};
		} else {	
			if (A3XAI_respect_madpassengerBonus > 0) then {
				_fragAttributes pushBack "Passenger";
				_killerRespectPoints pushBack ["MAD PASSENGER", A3XAI_respect_madpassengerBonus];
			};
		};
	};
	
	_lastKillAt = _killer getVariable ["A3XAI_LastKillAt", 0];
	_killStack = _killer getVariable ["A3XAI_KillStack", 0];
	if ((diag_tickTime - _lastKillAt) < (getNumber (configFile >> "CfgSettings" >> "Respect" >> "Bonus" >> "killStreakTimeout"))) then {
		if (A3XAI_respect_killstreakBonus > 0) then {
			_killStack = _killStack + 1;
			_fragAttributes pushBack (format ["%1x Kill Streak", _killStack]);
			_killerRespectPoints pushBack [(format ["%1x KILL STREAK", _killStack]), _killStack * A3XAI_respect_killstreakBonus];
		};
		
	} else {
		_killStack = 1;
	};
	_killer setVariable ["A3XAI_KillStack", _killStack];
	_killer setVariable ["A3XAI_LastKillAt", diag_tickTime];
	
	_distance = floor (_victim distance _killer);
	_fragAttributes pushBack (format ["%1m Distance", _distance]);
	_distanceBonus = ((floor (_distance / 100)) * A3XAI_respect_per100mBonus);
	if (_distanceBonus > 0) then {
		_killerRespectPoints pushBack [(format ["%1m RANGE BONUS", _distance]), _distanceBonus];
	};

	_overallRespectChange = 0;
	{
		_overallRespectChange = _overallRespectChange + (_x select 1);
	} forEach _killerRespectPoints;

	if (_overallRespectChange > 0) then {
		_newKillerScore = _killer getVariable ["ExileScore", 0];
		_newKillerScore = _newKillerScore + _overallRespectChange;
		_killer setVariable ["ExileScore", _newKillerScore];
		format["setAccountScore:%1:%2", _newKillerScore,_killerPlayerUID] call ExileServer_system_database_query_fireAndForget;
		[_killer, "showFragRequest", [_killerRespectPoints]] call A3XAI_sendExileMessage;
	};
	
	//["systemChatRequest", [_killMessage]] call ExileServer_system_network_send_broadcast; //To-do: Non-global version
	_newKillerFrags = _killer getVariable ["ExileKills", 0];
	_killer setVariable ["ExileKills", _newKillerFrags + 1];
	format["addAccountKill:%1", _killerPlayerUID] call ExileServer_system_database_query_fireAndForget;

	_killer call ExileServer_object_player_sendStatsUpdate;
};

if (A3XAI_deathMessages) then {
	_killMessage = format ["%1 was killed by %2", _victim getVariable ["bodyName","Bandit"], (name _killer)];

	if !(_fragAttributes isEqualTo []) then {
		_killMessage = _killMessage + " (";
		{
			if (_forEachIndex > 0) then {
				_killMessage = _killMessage + ", ";
			};
			_killMessage = _killMessage + _x;
		} forEach _fragAttributes;
		_killMessage = _killMessage + ")";
	};
	
	{
		if (isPlayer _x) then {
			A3XAI_killMSG = _killMessage; //Non-global version
			(owner _x) publicVariableClient "A3XAI_killMSG";
		};
	} count (crew _killer);
};

true
