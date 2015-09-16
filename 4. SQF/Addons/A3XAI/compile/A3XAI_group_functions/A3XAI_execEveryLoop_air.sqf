private ["_unitGroup", "_vehicle","_inNoAggroArea","_inArea","_result"];

_unitGroup = _this select 0;
_vehicle = _this select 1;

_inArea = _vehicle call A3XAI_checkInNoAggroArea;
_result = [_unitGroup,_inArea] call A3XAI_noAggroAreaToggle;

true
