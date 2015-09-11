#define AI_GROUP_SIDE east
#define PLAYER_GROUP_SIDE resistance

/*
	A3XAI Server Initialization File
	
	Description: Handles startup process for A3XAI. Does not contain any values intended for modification.
*/

if (hasInterface || !isDedicated ||!isNil "A3XAI_isActive") exitWith {};

_startTime = diag_tickTime;

A3XAI_isActive = true;

private ["_startTime","_directoryAsArray","_worldname","_allUnits","_functionsCheck"];

_directoryAsArray = toArray __FILE__;
_directoryAsArray resize ((count _directoryAsArray) - 26);
A3XAI_directory = toString _directoryAsArray;

if (isNil "A3XAI_devOptions") then {
	A3XAI_overrideEnabled = nil;
	A3XAI_debugMarkersEnabled = false;
} else {
	if ("readoverridefile" in A3XAI_devOptions) then {A3XAI_overrideEnabled = true} else {A3XAI_overrideEnabled = nil};
	if ("enabledebugmarkers" in A3XAI_devOptions) then {A3XAI_debugMarkersEnabled = true} else {A3XAI_debugMarkersEnabled = false};
	A3XAI_devOptions = nil;
};

if (isNil "A3XAI_ServerDir") then {
	A3XAI_ServerDir = "@exileserver";
};

//Report A3XAI version to RPT log
diag_log format ["[A3XAI] Initializing A3XAI version %1 using base path %2.",[configFile >> "CfgPatches" >> "A3XAI","A3XAIVersion","error - unknown version"] call BIS_fnc_returnConfigEntry,A3XAI_directory];

//Load A3XAI main configuration file
call compile preprocessFileLineNumbers format ["%1\A3XAI_config.sqf",A3XAI_ServerDir];

call compile preprocessFileLineNumbers format ["%1\scripts\verifySettings.sqf",A3XAI_directory];

//Load custom A3XAI settings file.
if ((!isNil "A3XAI_overrideEnabled") && {A3XAI_overrideEnabled}) then {call compile preprocessFileLineNumbers format ["%1\A3XAI_settings_override.sqf",A3XAI_ServerDir]};

//Load A3XAI functions
_functionsCheck = call compile preprocessFileLineNumbers format ["%1\init\A3XAI_functions.sqf",A3XAI_directory];
if (isNil "_functionsCheck") exitWith {diag_log "A3XAI Critical Error: Functions not successfully loaded. Stopping startup procedure.";};

//Create reference marker to act as boundary for spawning AI air/land vehicles.
_worldname = (toLower worldName);
_markerInfo = call {
	{
		if (_worldname isEqualTo (_x select 0)) exitWith {
			[_x select 1,_x select 2]
		};
	} forEach [
		//worldName, center position, landmass radius
		["altis",[15834.2,15787.8,0],12000],
		["australia",[21966.2,22728.5,0],15000],
		["bootcamp_acr",[1938.24,1884.16,0],1800],
		["caribou",[3938.9722, 4195.7417],3500],
		["chernarus",[7652.9634, 7870.8076],5500],
		["chernarus_summer",[6669.88,9251.68,0],6000],
		["desert_e",[1034.26,1022.18,0],1000],
		["esseker",[6206.94,5920.05,0],5700],
		["fallujah",[5139.8008, 4092.6797],4000],
		["fdf_isle1_a",[10771.362, 8389.2568],2750],
		["intro",[2914.44,2771.61,0],900],
		["isladuala",[4945.3438, 4919.6616],4000],
		["lingor",[5166.5581, 5108.8301],4500],
		["mbg_celle2",[6163.52, 6220.3984],6000],
		["mountains_acr",[3223.09,3242.13,0],3100],
		["namalsk",[5880.1313, 8889.1045],3000],
		["napf",[10725.096, 9339.918],8500],
		["oring",[5191.1069, 5409.1938],4750],
		["panthera2",[5343.6953, 4366.2534],3500],
		["porto",[2641.45,2479.77,0],800],
		["sara",[12693.104, 11544.386],6250],
		["saralite",[5357.5,5000.67,0],3000],
		["sara_dbe1",[11995.3,11717.9,0],7000],
		["sauerland",[12270.443, 13632.132],17500],
		["smd_sahrani_a2",[12693.104, 11544.386],6250],
		["stratis",[3937.6,4774.51,0],3000],
		["takistan",[6368.2764, 6624.2744],6000],
		["tavi",[10887.825, 11084.657],8500],
		["trinity",[7183.8403, 7067.4727],5300],
		["utes",[3519.8037, 3703.0649],1000],
		["woodland_acr",[3884.41,3896.44,0],3700],
		["zargabad",[3917.6201, 3800.0376],2000],
		[_worldname,getArray(configFile >> "CfgWorlds" >> worldName >> "centerPosition"),worldSize/2]
	];
};
_centerMarker = createMarkerLocal ["A3XAI_centerMarker",_markerInfo select 0];
_centerMarker setMarkerSizeLocal [_markerInfo select 1,_markerInfo select 1];

//Set side relations only if needed
_allUnits = +allUnits;
if !((PLAYER_GROUP_SIDE getFriend AI_GROUP_SIDE) isEqualTo 0) then {PLAYER_GROUP_SIDE setFriend [AI_GROUP_SIDE, 0]};
if !((AI_GROUP_SIDE getFriend PLAYER_GROUP_SIDE) isEqualTo 0) then {AI_GROUP_SIDE setFriend [PLAYER_GROUP_SIDE, 0]};
if !((AI_GROUP_SIDE getFriend AI_GROUP_SIDE) isEqualTo 1) then {AI_GROUP_SIDE setFriend [AI_GROUP_SIDE, 1]};

//Continue loading required A3XAI script files
[] execVM format ['%1\init\A3XAI_post_init.sqf',A3XAI_directory];

//Report A3XAI startup settings to RPT log
diag_log format ["[A3XAI] A3XAI settings: Debug Level: %1. WorldName: %2. VerifyClassnames: %3. VerifySettings: %4.",A3XAI_debugLevel,_worldname,A3XAI_verifyClassnames,A3XAI_verifySettings];
diag_log format ["[A3XAI] AI spawn settings: Static: %1. Dynamic: %2. Random: %3. Air: %4. Land: %5. UAV: %6. UGV: %7.",A3XAI_enableStaticSpawns,!(A3XAI_dynMaxSpawns isEqualTo 0),!(A3XAI_maxRandomSpawns isEqualTo 0),!(A3XAI_maxHeliPatrols isEqualTo 0),!(A3XAI_maxLandPatrols isEqualTo 0),!(A3XAI_maxUAVPatrols isEqualTo 0),!(A3XAI_maxUGVPatrols isEqualTo 0)];
diag_log format ["[A3XAI] A3XAI loading completed in %1 seconds.",(diag_tickTime - _startTime)];
