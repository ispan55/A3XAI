private ["_unitGroup", "_object", "_nearNoAggroAreas", "_inNoAggroArea", "_leaderPos", "_trigger"];

_unitGroup = _this select 0;
_object = _this select 1;

if (_unitGroup getVariable ["CanCheckArea",true]) then {
	_leaderPos = getPosATL (leader _unitGroup);
	_trigger = _unitGroup getVariable "trigger";
	
	if !(isNil "_trigger") then {
		_nearNoAggroAreas = nearestLocations [_leaderPos,["A3XAI_NoAggroArea"],1500];
		_inNoAggroArea = false;
		{
			if (_leaderPos in _x) exitWith {
				_inNoAggroArea = true;
			};
		} forEach _nearNoAggroAreas;

		if (_inNoAggroArea) then {
			(units _unitGroup) doMove (getPosATL _trigger);
			_unitGroup setVariable ["CanCheckArea",false];
			if (A3XAI_debugLevel > 1) then {diag_log format ["A3XAI Debug: Group %1 in no-aggro zone. Moving units toward trigger position.",_unitGroup];};
		};
	};

	true
} else {
	_unitGroup setVariable ["CanCheckArea",true];
	false
};
