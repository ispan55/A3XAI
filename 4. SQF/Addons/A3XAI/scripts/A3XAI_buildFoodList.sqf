private ["_food", "_drink", "_startTime", "_foodList", "_items", "_itemClassInfo", "_itemClassBias", "_itemClassType", "_itemList", "_itemInfo", "_itemBias", "_itemType", "_item","_itemClass"];

_startTime = diag_tickTime;

_items = [];

_food = [missionConfigFile >> "CfgTraderCategories" >> "Food","items",[]] call BIS_fnc_returnConfigEntry;
_drink = [missionConfigFile >> "CfgTraderCategories" >> "Drinks","items",[]] call BIS_fnc_returnConfigEntry;

_items = _food + _drink;

if !(_items isEqualTo []) then {
	A3XAI_foodLoot = _items;
	if (A3XAI_debugLevel > 0) then {
		diag_log format ["A3XAI Debug: Generated %1 food classnames in %2 seconds.",(count _items),diag_tickTime - _startTime];
		if (A3XAI_debugLevel > 1) then {
			diag_log format ["A3XAI Debug: Contents of A3XAI_foodLoot: %1",A3XAI_foodLoot];
		};
	};
} else {
	diag_log "A3XAI Error: Could not dynamically generate food classname list. Classnames from A3XAI_config.sqf used instead.";
};
