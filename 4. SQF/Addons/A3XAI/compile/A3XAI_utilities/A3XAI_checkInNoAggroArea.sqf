private ["_inNoAggroArea", "_objectPos"];

_inNoAggroArea = false;
_objectPos = if ((typeName _this) isEqualTo "OBJECT") then {getPosATL _this} else {_this};
{
	if (_objectPos in _x) exitWith {
		_inNoAggroArea = true;
	};
} forEach A3XAI_noAggroAreas;

_inNoAggroArea
