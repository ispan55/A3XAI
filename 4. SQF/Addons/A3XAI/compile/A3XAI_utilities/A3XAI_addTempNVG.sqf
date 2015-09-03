if (_this hasWeapon "NVGoggles") exitWith {false};
_this addWeapon "NVGoggles";

if (A3XAI_debugLevel > 1) then {diag_log format ["A3XAI Debug: Generated temporary NVGs for AI %1.",_this];};

true