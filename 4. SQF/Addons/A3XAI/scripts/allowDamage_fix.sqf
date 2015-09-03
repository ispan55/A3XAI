if (!isNil "A3XAI_allowDamageFix_active") exitWith {};
A3XAI_allowDamageFix_active = true;

uiSleep 5;

while {true} do {
	private ["_playersModified"];
	_playersModified = {
		if ((_x getVariable ["noDamageAllowed",true]) && {!(_x isKindOf "VirtualMan_EPOCH")}) then {
			if (isPlayer _x) then {
				_x allowDamage true;
				_x setVariable ["noDamageAllowed",false];
				true
			};
		};
	} count playableUnits;
	if (_playersModified > 0) then {diag_log format ["DEBUG :: Applied allowDamage:true to %1 players.",_playersModified]};
	uiSleep 10;
};
