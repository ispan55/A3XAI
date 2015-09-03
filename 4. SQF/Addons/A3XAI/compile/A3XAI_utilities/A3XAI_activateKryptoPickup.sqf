private ["_playerList","_player", "_kryptoTrigger", "_cIndex", "_kryptoStored", "_kryptoObject", "_vars", "_kryptoToSend","_arrowObject"];

_playerList = _this select 0;
_kryptoTrigger = _this select 1;

if (A3XAI_debugLevel > 1) then {diag_log format ["A3XAI Debug: Krypto pickup assist activated at %1.",(getPosATL _kryptoTrigger)];};

_player = objNull;
{
	if (isPlayer _x) exitWith {
		_player = _x;
	}
} forEach _playerList;

if (isPlayer _player) then {
	if !(isNull _kryptoTrigger) then {
		_cIndex = EPOCH_customVars find "Crypto";
		_kryptoObject = _kryptoTrigger getVariable ["A3XAI_kryptoObject",objNull];
		_arrowObject = _kryptoTrigger getVariable ["A3XAI_arrowObject",objNull];
		_kryptoStored = _kryptoObject getVariable ["Crypto",0];

		if (_kryptoStored > 0) then {
			_vars = _player getVariable ["VARS", [] + EPOCH_defaultVars_SEPXVar];
			_kryptoToSend = (((_vars select _cIndex) + _kryptoStored) min 25000) max 0;
			[["effectCrypto", _kryptoToSend], (owner _player)] call EPOCH_sendPublicVariableClient;
			_vars set [_cIndex, _kryptoToSend];
			_player setVariable ["VARS", _vars];
			if (A3XAI_debugLevel > 0) then {diag_log format ["A3XAI Debug: Krypto pickup assist generated %1 krypto for player %2.",_kryptoStored,_player];};
		};
		
		deleteVehicle _kryptoObject;
		deleteVehicle _arrowObject;
	};
};
deleteVehicle _kryptoTrigger;

true