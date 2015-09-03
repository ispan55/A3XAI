private ["_startTime", "_checkWeapon", "_magazineTypes", "_cursorAim", "_ammo", "_ammoHit", "_buildWeaponList", "_pistolList", "_rifleList", "_machinegunList", "_sniperList"];

_startTime = diag_tickTime;

if (isNil "A3XAI_dynamicWeaponBlacklist") then {A3XAI_dynamicWeaponBlacklist = [];};

_checkWeapon = 
{
	private ["_magazineTypes","_ammo","_ammoMaxRange","_ammoHit"];
	if ((typeName _this) != "STRING") exitWith {false};
	if (_this in A3XAI_dynamicWeaponBlacklist) exitWith {false};
	_magazineTypes = [configFile >> "CfgWeapons" >> _this,"magazines",[]] call BIS_fnc_returnConfigEntry;
	if (_magazineTypes isEqualTo []) exitWith {false};
	_cursorAim = [configFile >> "CfgWeapons" >> _this,"cursorAim","throw"] call BIS_fnc_returnConfigEntry;
	if (_cursorAim isEqualTo "throw") exitWith {false};
	_ammo = [configFile >> "CfgMagazines" >> (_magazineTypes select 0),"ammo",""] call BIS_fnc_returnConfigEntry;
	if (_ammo isEqualTo "") exitWith {false};
	_ammoHit = [configFile >> "CfgAmmo" >> _ammo,"hit",0] call BIS_fnc_returnConfigEntry;
	if (_ammoHit isEqualTo 0) exitWith {false};
	true
};

_buildWeaponList = {
	private ["_items", "_itemClassInfo", "_itemClassBias", "_itemClassType", "_weapon", "_itemClass", "_itemList"];
	_items = [];
	
	{
		if (_x call _checkWeapon) then {
			_items pushBack _x;
		};
	} forEach _this;
	
	_items
};

_pistolList = [missionConfigFile >> "CfgTraderCategories" >> "Pistols","items",[]] call BIS_fnc_returnConfigEntry;
_rifleList = [missionConfigFile >> "CfgTraderCategories" >> "AssaultRifles","items",[]] call BIS_fnc_returnConfigEntry;
_machinegunList = [missionConfigFile >> "CfgTraderCategories" >> "LightMachineGuns","items",[]] call BIS_fnc_returnConfigEntry;
_sniperList = [missionConfigFile >> "CfgTraderCategories" >> "SniperRifles","items",[]] call BIS_fnc_returnConfigEntry;
_submachinegunList = [missionConfigFile >> "CfgTraderCategories" >> "SubMachineGuns","items",[]] call BIS_fnc_returnConfigEntry;

_rifleList append _submachinegunList;

_pistolList = _pistolList call _buildWeaponList;
_rifleList = _rifleList call _buildWeaponList;
_machinegunList = _machinegunList call _buildWeaponList;
_sniperList = _sniperList call _buildWeaponList;

if !(_pistolList isEqualTo []) then {A3XAI_pistolList = _pistolList} else {diag_log "A3XAI Error: Could not dynamically generate Pistol weapon classname list. Classnames from A3XAI_config.sqf used instead."};
if !(_rifleList isEqualTo []) then {A3XAI_rifleList = _rifleList} else {diag_log "A3XAI Error: Could not dynamically generate Rifle weapon classname list. Classnames from A3XAI_config.sqf used instead."};
if !(_machinegunList isEqualTo []) then {A3XAI_machinegunList = _machinegunList} else {diag_log "A3XAI Error: Could not dynamically Machinegun weapon classname list. Classnames from A3XAI_config.sqf used instead."};
if !(_sniperList isEqualTo []) then {A3XAI_sniperList = _sniperList} else {diag_log "A3XAI Error: Could not dynamically generate Sniper weapon classname list. Classnames from A3XAI_config.sqf used instead."};

if (A3XAI_debugLevel > 0) then {
	if (A3XAI_debugLevel > 1) then {
		//Display finished weapon arrays
		diag_log format ["Contents of A3XAI_pistolList: %1",A3XAI_pistolList];
		diag_log format ["Contents of A3XAI_rifleList: %1",A3XAI_rifleList];
		diag_log format ["Contents of A3XAI_machinegunList: %1",A3XAI_machinegunList];
		diag_log format ["Contents of A3XAI_sniperList: %1",A3XAI_sniperList];
	};
	diag_log format ["A3XAI Debug: Weapon classname tables created in %1 seconds.",(diag_tickTime - _startTime)];
};
