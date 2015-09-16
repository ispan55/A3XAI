private ["_pos","_size","_location"];

_pos = _this select 0;
_size = _this select 1;

_location = createLocation ["A3XAI_NoAggroArea",_pos,_size,_size];
A3XAI_noAggroAreas pushBack _location;

_location
