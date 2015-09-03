private ["_objectMonitor","_object","_index"];
_object = _this;

_object setVehicleLock "LOCKEDPLAYER";
_object enableCopilot false;

_index = A3XAI_monitoredObjects pushBack _object;

_index