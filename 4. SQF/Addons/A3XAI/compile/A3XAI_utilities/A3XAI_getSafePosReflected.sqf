private ["_originPos", "_noAggroArea", "_posReflected", "_locationPos", "_locationSize", "_direction"];

_originPos = _this; //origin

if ((typeName _originPos) isEqualTo "OBJECT") then {_originPos = getPosATL _originPos};

_noAggroArea = locationNull;
_posReflected = [];

_noAggroArea = _originPos call A3XAI_returnNoAggroArea;

if !(isNull _noAggroArea) then {
	_locationPos = getPosATL _noAggroArea;
	_locationSize = ((size _noAggroArea) select 0) + 300;
	_direction = [_locationPos,_originPos] call BIS_fnc_dirTo;
	_posReflected = [_locationPos, _locationSize,_direction] call BIS_fnc_relPos;
	if ((surfaceIsWater _posReflected) or {_posReflected call A3XAI_checkInNoAggroArea}) then {_posReflected = []};
};

_posReflected
