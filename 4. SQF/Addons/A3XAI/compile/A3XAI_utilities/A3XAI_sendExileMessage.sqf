private["_messageName","_messageParameters","_player"];
_player = _this select 0;
_messageName = _this select 1;
_messageParameters = _this select 2;

PublicMessage = [_messageName, _messageParameters];

(owner _player) publicVariableClient "PublicMessage";

PublicMessage = nil;

true
