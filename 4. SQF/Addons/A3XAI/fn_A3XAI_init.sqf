if (hasInterface) exitWith {};

A3XAI_ServerDir = "@exileserver";

if (isDedicated) then {
	[] call compile preprocessFileLineNumbers "\A3XAI\init\A3XAI_initserver.sqf";
} else {
	[] call compile preprocessFileLineNumbers "\A3XAI\init\A3XAI_inithc.sqf";
};

