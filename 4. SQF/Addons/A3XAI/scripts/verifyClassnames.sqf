private["_verified","_errorFound","_startTime"];

_startTime = diag_tickTime;

_verified = [];

{
	_array = missionNamespace getVariable [_x,[]];
	_errorFound = false;
	{
		if !(_x in _verified) then {
			call {
				if ((isNil {_x}) or {!((typeName _x) isEqualTo "STRING")}) exitWith {
					diag_log format ["A3XAI] Removing non-string item %1 from classname table.",_x];
					_array set [_forEachIndex,""];
					if (!_errorFound) then {_errorFound = true};
				};
				if (isClass (configFile >> "CfgWeapons" >> _x)) exitWith {
					if (((configName (inheritsFrom (configFile >> "CfgWeapons" >> _x))) isEqualTo "FakeWeapon") or {(getNumber (configFile >> "CfgWeapons" >> _x >> "scope")) isEqualTo 0}) then {
						diag_log format ["[A3XAI] Removing invalid classname: %1.",_x];
						_array set [_forEachIndex,""];
						if (!_errorFound) then {_errorFound = true};
					} else {
						_verified pushBack _x;
					};
				};
				if (isClass (configFile >> "CfgMagazines" >> _x)) exitWith {
					if (((configName (inheritsFrom (configFile >> "CfgMagazines" >> _x))) isEqualTo "FakeMagazine") or {(getNumber (configFile >> "CfgMagazines" >> _x >> "scope")) isEqualTo 0}) then {
						diag_log format ["[A3XAI] Removing invalid classname: %1.",_x];
						_array set [_forEachIndex,""];
						if (!_errorFound) then {_errorFound = true};
					} else {
						_verified pushBack _x;
					};
				};
				if (isClass (configFile >> "CfgVehicles" >> _x)) exitWith {
					if (((configName (inheritsFrom (configFile >> "CfgVehicles" >> _x))) isEqualTo "Banned") or {(getNumber (configFile >> "CfgVehicles" >> _x >> "scope")) isEqualTo 0}) then {
						diag_log format ["[A3XAI] Removing invalid classname: %1.",_x];
						_array set [_forEachIndex,""];
						if (!_errorFound) then {_errorFound = true};
					} else {
						_verified pushBack _x;
					};
				};
				diag_log format ["[A3XAI] Removing invalid classname: %1.",_x];	//Default case - if classname doesn't exist at all
				_array set [_forEachIndex,""];
				if (!_errorFound) then {_errorFound = true};
			};
		};
	} forEach _array;
	if (_errorFound) then {
		_array = _array - [""];
		missionNamespace setVariable [_x,_array];
		diag_log format ["[A3XAI] Contents of %1 failed verification. Invalid entries removed.",_x];
		//diag_log format ["DEBUG :: Corrected contents of %1: %2.",_x,_array];
		//diag_log format ["DEBUG :: Comparison check of %1: %2.",_x,missionNamespace getVariable [_x,[]]];
	};
} forEach A3XAI_tableChecklist;

if (A3XAI_maxHeliPatrols > 0) then {
	{
		call {
			if (!((_x select 0) isKindOf "Air")) exitWith {
				diag_log format ["[A3XAI] Removing non-Air type vehicle from A3XAI_heliList array: %1.",(_x select 0)];
				A3XAI_heliList set [_forEachIndex,""];
			};
		};
	} forEach A3XAI_heliList;
	if ("" in A3XAI_heliList) then {A3XAI_heliList = A3XAI_heliList - [""];};
};

if (A3XAI_maxLandPatrols > 0) then {
	{
		call {
			if (!((_x select 0) isKindOf "LandVehicle")) exitWith {
				diag_log format ["[A3XAI] Removing non-LandVehicle type vehicle from A3XAI_vehList array: %1.",(_x select 0)];
				A3XAI_vehList set [_forEachIndex,""];
			};
			if (((_x select 0) isKindOf "StaticWeapon")) exitWith {
				diag_log format ["[A3XAI] Removing StaticWeapon type vehicle from A3XAI_vehList array: %1.",(_x select 0)];
				A3XAI_vehList set [_forEachIndex,""];
			};
		};
	} forEach A3XAI_vehList;
	if ("" in A3XAI_vehList) then {A3XAI_vehList = A3XAI_vehList - [""];};
};

if (A3XAI_maxAirReinforcements > 0) then {
	{
		call {
			if (!(_x isKindOf "Air")) exitWith {
				diag_log format ["[A3XAI] Removing non-Air type vehicle from A3XAI_airReinforcementVehicles array: %1.",_x];
				A3XAI_airReinforcementVehicles set [_forEachIndex,""];
			};
		};
	} forEach A3XAI_airReinforcementVehicles;
	if ("" in A3XAI_airReinforcementVehicles) then {A3XAI_airReinforcementVehicles = A3XAI_airReinforcementVehicles - [""];};
};

if (A3XAI_maxUAVPatrols > 0) then {
	{
		call {
			if (!((_x select 0) isKindOf "Air")) exitWith {
				diag_log format ["[A3XAI] Removing non-Air type vehicle from A3XAI_UAVList array: %1.",(_x select 0)];
				A3XAI_UAVList set [_forEachIndex,""];
			};
		};
	} forEach A3XAI_UAVList;
	if ("" in A3XAI_UAVList) then {A3XAI_UAVList = A3XAI_UAVList - [""];};
};

if (A3XAI_maxUGVPatrols > 0) then {
	{
		call {
			if (!((_x select 0) isKindOf "LandVehicle")) exitWith {
				diag_log format ["[A3XAI] Removing non-LandVehicle type vehicle from A3XAI_UGVList array: %1.",(_x select 0)];
				A3XAI_UGVList set [_forEachIndex,""];
			};
			if (((_x select 0) isKindOf "StaticWeapon")) exitWith {
				diag_log format ["[A3XAI] Removing StaticWeapon type vehicle from A3XAI_UGVList array: %1.",(_x select 0)];
				A3XAI_UGVList set [_forEachIndex,""];
			};
		};
	} forEach A3XAI_UGVList;
	if ("" in A3XAI_UGVList) then {A3XAI_UGVList = A3XAI_UGVList - [""];};
};

{
	if (([configFile >> "CfgWeapons" >> _x >> "ItemInfo","uniformClass",""] call BIS_fnc_returnConfigEntry) isEqualTo "") then {
		diag_log format ["[A3XAI] Removing invalid uniform classname from A3XAI_uniformTypes0 array: %1.",_x];
		A3XAI_uniformTypes0 set [_forEachIndex,""];
	};
} forEach A3XAI_uniformTypes0;
if ("" in A3XAI_uniformTypes0) then {A3XAI_uniformTypes0 = A3XAI_uniformTypes0 - [""];};

{
	if (([configFile >> "CfgWeapons" >> _x >> "ItemInfo","uniformClass",""] call BIS_fnc_returnConfigEntry) isEqualTo "") then {
		diag_log format ["[A3XAI] Removing invalid uniform classname from A3XAI_uniformTypes1 array: %1.",_x];
		A3XAI_uniformTypes1 set [_forEachIndex,""];
	};
} forEach A3XAI_uniformTypes1;
if ("" in A3XAI_uniformTypes1) then {A3XAI_uniformTypes1 = A3XAI_uniformTypes1 - [""];};

{
	if (([configFile >> "CfgWeapons" >> _x >> "ItemInfo","uniformClass",""] call BIS_fnc_returnConfigEntry) isEqualTo "") then {
		diag_log format ["[A3XAI] Removing invalid uniform classname from A3XAI_uniformTypes2 array: %1.",_x];
		A3XAI_uniformTypes2 set [_forEachIndex,""];
	};
} forEach A3XAI_uniformTypes2;
if ("" in A3XAI_uniformTypes2) then {A3XAI_uniformTypes2 = A3XAI_uniformTypes2 - [""];};

{
	if (([configFile >> "CfgWeapons" >> _x >> "ItemInfo","uniformClass",""] call BIS_fnc_returnConfigEntry) isEqualTo "") then {
		diag_log format ["[A3XAI] Removing invalid uniform classname from A3XAI_uniformTypes3 array: %1.",_x];
		A3XAI_uniformTypes3 set [_forEachIndex,""];
	};
} forEach A3XAI_uniformTypes3;
if ("" in A3XAI_uniformTypes3) then {A3XAI_uniformTypes3 = A3XAI_uniformTypes3 - [""];};

{
	if !(([configFile >> "CfgWeapons" >> _x,"type",-1] call BIS_fnc_returnConfigEntry) isEqualTo 2) then {
		diag_log format ["[A3XAI] Removing invalid pistol classname from A3XAI_pistolList array: %1.",_x];
		A3XAI_pistolList set [_forEachIndex,""];
	};
} forEach A3XAI_pistolList;
if ("" in A3XAI_pistolList) then {A3XAI_pistolList = A3XAI_pistolList - [""];};

{
	if !(([configFile >> "CfgWeapons" >> _x,"type",-1] call BIS_fnc_returnConfigEntry) isEqualTo 1) then {
		diag_log format ["[A3XAI] Removing invalid rifle classname from A3XAI_rifleList array: %1.",_x];
		A3XAI_rifleList set [_forEachIndex,""];
	};
} forEach A3XAI_rifleList;
if ("" in A3XAI_rifleList) then {A3XAI_rifleList = A3XAI_rifleList - [""];};

{
	if !(([configFile >> "CfgWeapons" >> _x,"type",-1] call BIS_fnc_returnConfigEntry) isEqualTo 1) then {
		diag_log format ["[A3XAI] Removing invalid machine gun classname from A3XAI_machinegunList array: %1.",_x];
		A3XAI_machinegunList set [_forEachIndex,""];
	};
} forEach A3XAI_machinegunList;
if ("" in A3XAI_machinegunList) then {A3XAI_machinegunList = A3XAI_machinegunList - [""];};

{
	if !(([configFile >> "CfgWeapons" >> _x,"type",-1] call BIS_fnc_returnConfigEntry) isEqualTo 1) then {
		diag_log format ["[A3XAI] Removing invalid sniper classname from A3XAI_sniperList array: %1.",_x];
		A3XAI_sniperList set [_forEachIndex,""];
	};
} forEach A3XAI_sniperList;
if ("" in A3XAI_sniperList) then {A3XAI_sniperList = A3XAI_sniperList - [""];};

{
	if !(([configFile >> "CfgWeapons" >> _x,"type",-1] call BIS_fnc_returnConfigEntry) isEqualTo 4) then {
		diag_log format ["[A3XAI] Removing invalid launcher classname from A3XAI_launcherTypes array: %1.",_x];
		A3XAI_launcherTypes set [_forEachIndex,""];
	};
} forEach A3XAI_launcherTypes;
if ("" in A3XAI_launcherTypes) then {A3XAI_launcherTypes = A3XAI_launcherTypes - [""];};

{
	if !(([configFile >> "CfgWeapons" >> _x >> "ItemInfo","mountAction",""] call BIS_fnc_returnConfigEntry) isEqualTo "MountOptic") then {
		diag_log format ["[A3XAI] Removing invalid optics classname from A3XAI_weaponOpticsList array: %1.",_x];
		A3XAI_weaponOpticsList set [_forEachIndex,""];
	};
} forEach A3XAI_weaponOpticsList;
if ("" in A3XAI_weaponOpticsList) then {A3XAI_weaponOpticsList = A3XAI_weaponOpticsList - [""];};

{
	if !(([configFile >> "CfgVehicles" >> _x,"vehicleClass",""] call BIS_fnc_returnConfigEntry) isEqualTo "Backpacks") then {
		diag_log format ["[A3XAI] Removing invalid backpack classname from A3XAI_backpackTypes0 array: %1.",_x];
		A3XAI_backpackTypes0 set [_forEachIndex,""];
	};
} forEach A3XAI_backpackTypes0;
if ("" in A3XAI_backpackTypes0) then {A3XAI_backpackTypes0 = A3XAI_backpackTypes0 - [""];};

{
	if !(([configFile >> "CfgVehicles" >> _x,"vehicleClass",""] call BIS_fnc_returnConfigEntry) isEqualTo "Backpacks") then {
		diag_log format ["[A3XAI] Removing invalid backpack classname from A3XAI_backpackTypes1 array: %1.",_x];
		A3XAI_backpackTypes1 set [_forEachIndex,""];
	};
} forEach A3XAI_backpackTypes1;
if ("" in A3XAI_backpackTypes1) then {A3XAI_backpackTypes1 = A3XAI_backpackTypes1 - [""];};

{
	if !(([configFile >> "CfgVehicles" >> _x,"vehicleClass",""] call BIS_fnc_returnConfigEntry) isEqualTo "Backpacks") then {
		diag_log format ["[A3XAI] Removing invalid backpack classname from A3XAI_backpackTypes2 array: %1.",_x];
		A3XAI_backpackTypes2 set [_forEachIndex,""];
	};
} forEach A3XAI_backpackTypes2;
if ("" in A3XAI_backpackTypes2) then {A3XAI_backpackTypes2 = A3XAI_backpackTypes2 - [""];};

{
	if !(([configFile >> "CfgVehicles" >> _x,"vehicleClass",""] call BIS_fnc_returnConfigEntry) isEqualTo "Backpacks") then {
		diag_log format ["[A3XAI] Removing invalid backpack classname from A3XAI_backpackTypes3 array: %1.",_x];
		A3XAI_backpackTypes3 set [_forEachIndex,""];
	};
} forEach A3XAI_backpackTypes3;
if ("" in A3XAI_backpackTypes3) then {A3XAI_backpackTypes3 = A3XAI_backpackTypes3 - [""];};

{
	if !(([configFile >> "CfgWeapons" >> _x >> "ItemInfo","hitpointName",""] call BIS_fnc_returnConfigEntry) isEqualTo "HitBody") then {
		diag_log format ["[A3XAI] Removing invalid vest classname from A3XAI_vestTypes0 array: %1.",_x];
		A3XAI_vestTypes0 set [_forEachIndex,""];
	};
} forEach A3XAI_vestTypes0;
if ("" in A3XAI_vestTypes0) then {A3XAI_vestTypes0 = A3XAI_vestTypes0 - [""];};

{
	if !(([configFile >> "CfgWeapons" >> _x >> "ItemInfo","hitpointName",""] call BIS_fnc_returnConfigEntry) isEqualTo "HitBody") then {
		diag_log format ["[A3XAI] Removing invalid vest classname from A3XAI_vestTypes1 array: %1.",_x];
		A3XAI_vestTypes1 set [_forEachIndex,""];
	};
} forEach A3XAI_vestTypes1;
if ("" in A3XAI_vestTypes1) then {A3XAI_vestTypes1 = A3XAI_vestTypes1 - [""];};

{
	if !(([configFile >> "CfgWeapons" >> _x >> "ItemInfo","hitpointName",""] call BIS_fnc_returnConfigEntry) isEqualTo "HitBody") then {
		diag_log format ["[A3XAI] Removing invalid vest classname from A3XAI_vestTypes2 array: %1.",_x];
		A3XAI_vestTypes2 set [_forEachIndex,""];
	};
} forEach A3XAI_vestTypes2;
if ("" in A3XAI_vestTypes2) then {A3XAI_vestTypes2 = A3XAI_vestTypes2 - [""];};

{
	if !(([configFile >> "CfgWeapons" >> _x >> "ItemInfo","hitpointName",""] call BIS_fnc_returnConfigEntry) isEqualTo "HitBody") then {
		diag_log format ["[A3XAI] Removing invalid vest classname from A3XAI_vestTypes3 array: %1.",_x];
		A3XAI_vestTypes3 set [_forEachIndex,""];
	};
} forEach A3XAI_vestTypes3;
if ("" in A3XAI_vestTypes3) then {A3XAI_vestTypes3 = A3XAI_vestTypes3 - [""];};

{
	if !(([configFile >> "CfgWeapons" >> _x >> "ItemInfo","hitpointName",""] call BIS_fnc_returnConfigEntry) isEqualTo "HitHead") then {
		diag_log format ["[A3XAI] Removing invalid headgear classname from A3XAI_headgearTypes0 array: %1.",_x];
		A3XAI_headgearTypes0 set [_forEachIndex,""];
	};
} forEach A3XAI_headgearTypes0;
if ("" in A3XAI_headgearTypes0) then {A3XAI_headgearTypes0 = A3XAI_headgearTypes0 - [""];};

{
	if !(([configFile >> "CfgWeapons" >> _x >> "ItemInfo","hitpointName",""] call BIS_fnc_returnConfigEntry) isEqualTo "HitHead") then {
		diag_log format ["[A3XAI] Removing invalid headgear classname from A3XAI_headgearTypes1 array: %1.",_x];
		A3XAI_headgearTypes1 set [_forEachIndex,""];
	};
} forEach A3XAI_headgearTypes1;
if ("" in A3XAI_headgearTypes1) then {A3XAI_headgearTypes1 = A3XAI_headgearTypes1 - [""];};

{
	if !(([configFile >> "CfgWeapons" >> _x >> "ItemInfo","hitpointName",""] call BIS_fnc_returnConfigEntry) isEqualTo "HitHead") then {
		diag_log format ["[CfgWeapons] Removing invalid headgear classname from A3XAI_headgearTypes2 array: %1.",_x];
		A3XAI_headgearTypes2 set [_forEachIndex,""];
	};
} forEach A3XAI_headgearTypes2;
if ("" in A3XAI_headgearTypes2) then {A3XAI_headgearTypes2 = A3XAI_headgearTypes2 - [""];};

{
	if !(([configFile >> "CfgWeapons" >> _x >> "ItemInfo","hitpointName",""] call BIS_fnc_returnConfigEntry) isEqualTo "HitHead") then {
		diag_log format ["[A3XAI] Removing invalid headgear classname from A3XAI_headgearTypes3 array: %1.",_x];
		A3XAI_headgearTypes3 set [_forEachIndex,""];
	};
} forEach A3XAI_headgearTypes3;
if ("" in A3XAI_headgearTypes3) then {A3XAI_headgearTypes3 = A3XAI_headgearTypes3 - [""];};

//Anticipate cases where all elements of an array are invalid
if (A3XAI_pistolList isEqualTo []) then {A3XAI_pistolList = ["hgun_ACPC2_F","hgun_P07_F","hgun_Pistol_heavy_01_F","hgun_Pistol_heavy_02_F","hgun_Rook40_F"]};
if (A3XAI_rifleList isEqualTo []) then {A3XAI_rifleList = ["arifle_Katiba_C_F","arifle_Katiba_F","arifle_Katiba_GL_F","arifle_Mk20_F","arifle_Mk20_GL_F","arifle_Mk20_GL_plain_F","arifle_Mk20_plain_F","arifle_Mk20C_F","arifle_Mk20C_plain_F","arifle_MX_Black_F","arifle_MX_F","arifle_MX_GL_Black_F","arifle_MX_GL_F","arifle_MXC_Black_F","arifle_MXC_F","arifle_SDAR_F","arifle_TRG20_F","arifle_TRG21_F","arifle_TRG21_GL_F"]};
if (A3XAI_machinegunList isEqualTo []) then {A3XAI_machinegunList = ["arifle_MX_SW_Black_F","arifle_MX_SW_F","LMG_Mk200_F","LMG_Zafir_F","MMG_01_hex_F","MMG_01_tan_F","MMG_02_black_F","MMG_02_camo_F","MMG_02_sand_F"]};
if (A3XAI_sniperList isEqualTo []) then {A3XAI_sniperList = ["arifle_MXM_Black_F","arifle_MXM_F","srifle_DMR_01_F","srifle_DMR_02_camo_F","srifle_DMR_02_F","srifle_DMR_02_sniper_F","srifle_DMR_03_F","srifle_DMR_03_khaki_F","srifle_DMR_03_multicam_F","srifle_DMR_03_tan_F","srifle_DMR_03_woodland_F","srifle_DMR_04_F","srifle_DMR_04_Tan_F","srifle_DMR_05_blk_F","srifle_DMR_05_hex_F","srifle_DMR_05_tan_f","srifle_DMR_06_camo_F","srifle_DMR_06_olive_F","srifle_EBR_F","srifle_GM6_camo_F","srifle_GM6_F","srifle_LRR_camo_F","srifle_LRR_F"]};
if (A3XAI_foodLoot isEqualTo []) then {A3XAI_foodLootCount = 0};
if (A3XAI_MiscLoot isEqualTo []) then {A3XAI_miscLootCount = 0};
if (A3XAI_airReinforcementVehicles isEqualTo []) then {A3XAI_maxAirReinforcements = 0; A3XAI_airReinforcementSpawnChance1 = 0; A3XAI_airReinforcementSpawnChance2 = 0; A3XAI_airReinforcementSpawnChance3 = 0;};

diag_log format ["[A3XAI] Verified %1 unique classnames in %2 seconds.",(count _verified),(diag_tickTime - _startTime)];
