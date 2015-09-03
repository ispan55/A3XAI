private ["_startTime", "_backpackList", "_items", "_itemClassInfo", "_itemClassBias", "_itemClassType", "_item", "_itemList", "_itemInfo", "_itemBias", "_itemType","_itemClass"];

_startTime = diag_tickTime;

_items = [missionConfigFile >> "CfgTraderCategories" >> "Backpacks","items",[]] call BIS_fnc_returnConfigEntry;

if !(_items isEqualTo []) then {
	if (0 in A3XAI_dynamicBackpackLevels) then {A3XAI_backpackTypes0 = _items;};
	if (1 in A3XAI_dynamicBackpackLevels) then {A3XAI_backpackTypes1 = _items;};
	if (2 in A3XAI_dynamicBackpackLevels) then {A3XAI_backpackTypes2 = _items;};
	if (3 in A3XAI_dynamicBackpackLevels) then {A3XAI_backpackTypes3 = _items;};
	if (A3XAI_debugLevel > 0) then {
		diag_log format ["A3XAI Debug: Generated %1 backpack classnames in %2 seconds.",(count _items),diag_tickTime - _startTime];
		if (A3XAI_debugLevel > 1) then {
			diag_log format ["A3XAI Debug: Contents of A3XAI_backpackTypes0: %1",A3XAI_backpackTypes0];
			diag_log format ["A3XAI Debug: Contents of A3XAI_backpackTypes1: %1",A3XAI_backpackTypes1];
			diag_log format ["A3XAI Debug: Contents of A3XAI_backpackTypes2: %1",A3XAI_backpackTypes2];
			diag_log format ["A3XAI Debug: Contents of A3XAI_backpackTypes3: %1",A3XAI_backpackTypes3];
		};
	};
} else {
	diag_log "A3XAI Error: Could not dynamically generate backpack classname list. Classnames from A3XAI_config.sqf used instead.";
};
