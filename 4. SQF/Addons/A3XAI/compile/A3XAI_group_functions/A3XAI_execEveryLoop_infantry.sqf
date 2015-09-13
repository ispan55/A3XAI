private ["_unitGroup", "_vehicle", "_lastRegroupCheck","_inNoAggroArea"];

_unitGroup = _this select 0;
_vehicle = _this select 1;

_this call A3XAI_checkInNoAggroArea;
