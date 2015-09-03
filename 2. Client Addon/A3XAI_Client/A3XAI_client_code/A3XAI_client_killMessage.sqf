
_message = _this;
if ((typeName _message) isEqualTo "STRING") then {
	systemChat _message;
	if (A3XAIC_deathMessageSound) then {
		playsound "AddItemOK";
	};
};

true