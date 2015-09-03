private ["_startTime", "_itemList", "_items", "_itemClassInfo", "_itemClassBias", "_itemClassType", "_itemInfo", "_itemBias", "_itemType", "_item","_itemClass", "_headgearList"];

_startTime = diag_tickTime;

_items = [missionConfigFile >> "CfgTraderCategories" >> "Headgear","items",[]] call BIS_fnc_returnConfigEntry;

if !(_items isEqualTo []) then {
	if (0 in A3XAI_dynamicHeadgearLevels) then {A3XAI_headgearTypes0 = _items;};
	if (1 in A3XAI_dynamicHeadgearLevels) then {A3XAI_headgearTypes1 = _items;};
	if (2 in A3XAI_dynamicHeadgearLevels) then {A3XAI_headgearTypes2 = _items;};
	if (3 in A3XAI_dynamicHeadgearLevels) then {A3XAI_headgearTypes3 = _items;};
	if (A3XAI_debugLevel > 0) then {
		diag_log format ["A3XAI Debug: Generated %1 headgear classnames in %2 seconds.",(count _items),diag_tickTime - _startTime];
		if (A3XAI_debugLevel > 1) then {
			diag_log format ["A3XAI Debug: Contents of A3XAI_headgearTypes0: %1",A3XAI_headgearTypes0];
			diag_log format ["A3XAI Debug: Contents of A3XAI_headgearTypes1: %1",A3XAI_headgearTypes1];
			diag_log format ["A3XAI Debug: Contents of A3XAI_headgearTypes2: %1",A3XAI_headgearTypes2];
			diag_log format ["A3XAI Debug: Contents of A3XAI_headgearTypes3: %1",A3XAI_headgearTypes3];
		};
	};
} else {
	diag_log "A3XAI Error: Could not dynamically generate headgear classname list. Classnames from A3XAI_config.sqf used instead.";
};
