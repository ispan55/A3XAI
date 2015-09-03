private ["_unitLevel", "_weaponIndices", "_weaponList", "_weaponsList", "_weaponSelected"];

_unitLevel = _this;

_weaponIndices = missionNamespace getVariable ["A3XAI_weaponTypeIndices"+str(_unitLevel),[0,1,2,3]];
_weaponList = ["A3XAI_pistolList","A3XAI_rifleList","A3XAI_machinegunList","A3XAI_sniperList"] select (_weaponIndices call A3XAI_selectRandom);
_weaponsList = missionNamespace getVariable [_weaponList,"A3XAI_rifleList"];
_weaponSelected = _weaponsList call A3XAI_selectRandom;

_weaponSelected