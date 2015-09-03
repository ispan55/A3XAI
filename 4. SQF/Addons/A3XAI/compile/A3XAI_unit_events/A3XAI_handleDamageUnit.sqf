private["_unit","_part","_damage","_source","_ammo"];

_unit = 		_this select 0;				//Object the event handler is assigned to. (the unit taking damage)
_part = 		_this select 1;				//Name of the selection where the unit was damaged. "" for over-all structural damage, "?" for unknown selections. 
_damage = 		_this select 2;				//Resulting level of damage for the selection. (Received damage)
_source = 		_this select 3;				//The source unit that caused the damage. 
_ammo = 		_this select 4;				//Classname of the projectile that caused inflicted the damage. ("" for unknown, such as falling damage.) 



if (isPlayer _source) then {	
	if ((_damage > 0.9) && {_part isEqualTo ""}) then {	//Check fatal damage only by players
		_unit setVariable ["CollisionKilled",A3XAI_roadKillPenalty && {_ammo isEqualTo ""}];
	};
} else {
	_damage = 0; //Non-players cause no damage to unit
};

_damage



