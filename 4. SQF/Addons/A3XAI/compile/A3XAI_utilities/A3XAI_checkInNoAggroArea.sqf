private ["_unitGroup", "_object", "_nearNoAggroAreas", "_inNoAggroArea", "_objectPos"];

_unitGroup = _this select 0;
_object = _this select 1;

_nearNoAggroAreas = nearestLocations [_object,["A3XAI_NoAggroArea"],1500];
_inNoAggroArea = false;
_objectPos = getPosATL _object;
{
	if (_objectPos in _x) exitWith {
		_inNoAggroArea = true;
	};
} forEach _nearNoAggroAreas;

_inNoAggroArea
