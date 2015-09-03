private ["_startTime", "_uniformTypes", "_items", "_itemClassInfo", "_itemClassBias", "_itemClassType", "_itemClass", "_itemClasses", "_itemInfo", "_itemBias", "_itemType", "_item", "_itemSubClass", "_itemList", "_itemSubInfo", "_itemSubBias", "_itemSubType"];

_startTime = diag_tickTime;

_items = [missionConfigFile >> "CfgTraderCategories" >> "Uniforms","items",[]] call BIS_fnc_returnConfigEntry;

if !(_items isEqualTo []) then {
	if (0 in A3XAI_dynamicUniformLevels) then {A3XAI_uniformTypes0 = _items;};
	if (1 in A3XAI_dynamicUniformLevels) then {A3XAI_uniformTypes1 = _items;};
	if (2 in A3XAI_dynamicUniformLevels) then {A3XAI_uniformTypes2 = _items;};
	if (3 in A3XAI_dynamicUniformLevels) then {A3XAI_uniformTypes3 = _items;};
	if (A3XAI_debugLevel > 0) then {
		diag_log format ["A3XAI Debug: Generated %1 uniform classnames in %2 seconds.",(count _items),diag_tickTime - _startTime];
		if (A3XAI_debugLevel > 1) then {
			diag_log format ["A3XAI Debug: Contents of A3XAI_uniformTypes0: %1",A3XAI_uniformTypes0];
			diag_log format ["A3XAI Debug: Contents of A3XAI_uniformTypes1: %1",A3XAI_uniformTypes1];
			diag_log format ["A3XAI Debug: Contents of A3XAI_uniformTypes2: %1",A3XAI_uniformTypes2];
			diag_log format ["A3XAI Debug: Contents of A3XAI_uniformTypes3: %1",A3XAI_uniformTypes3];
		};
	};
} else {
	diag_log "A3XAI Error: Could not dynamically generate uniform classname list. Classnames from A3XAI_config.sqf used instead.";
};
