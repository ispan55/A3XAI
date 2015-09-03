private ["_startTime", "_items", "_itemInfo", "_itemBias", "_itemType", "_item"];

_startTime = diag_tickTime;

_items = [missionConfigFile >> "CfgTraderCategories" >> "Vests","items",[]] call BIS_fnc_returnConfigEntry;

if !(_items isEqualTo []) then {
	if (0 in A3XAI_dynamicVestLevels) then {A3XAI_vestTypes0 = _items;};
	if (1 in A3XAI_dynamicVestLevels) then {A3XAI_vestTypes1 = _items;};
	if (2 in A3XAI_dynamicVestLevels) then {A3XAI_vestTypes2 = _items;};
	if (3 in A3XAI_dynamicVestLevels) then {A3XAI_vestTypes3 = _items;};
	if (A3XAI_debugLevel > 0) then {
		diag_log format ["A3XAI Debug: Generated %1 vest classnames in %2 seconds.",(count _items),diag_tickTime - _startTime];
		if (A3XAI_debugLevel > 1) then {
			diag_log format ["A3XAI Debug: Contents of A3XAI_vestTypes0: %1",A3XAI_vestTypes0];
			diag_log format ["A3XAI Debug: Contents of A3XAI_vestTypes1: %1",A3XAI_vestTypes1];
			diag_log format ["A3XAI Debug: Contents of A3XAI_vestTypes2: %1",A3XAI_vestTypes2];
			diag_log format ["A3XAI Debug: Contents of A3XAI_vestTypes3: %1",A3XAI_vestTypes3];
		};
	};
} else {
	diag_log "A3XAI Error: Could not dynamically generate vest classname list. Classnames from A3XAI_config.sqf used instead.";
};
