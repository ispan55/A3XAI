private["_vehicle","_hit","_damage","_source","_ammo","_partdamage","_durability","_unitGroup"];

_vehicle = 		_this select 0;				//Object the event handler is assigned to. (the unit taking damage)
_hit = 			_this select 1;				//Name of the selection where the unit was damaged. "" for over-all structural damage, "?" for unknown selections. 
_damage = 		_this select 2;				//Resulting level of damage for the selection. (Received damage)
_source = 		_this select 3;				//The source unit that caused the damage. 
_ammo = 		_this select 4;				//Classname of the projectile that caused inflicted the damage. ("" for unknown, such as falling damage.) 

if !(simulationEnabled _vehicle) exitWith {};

_durability = _vehicle getVariable "durability";
if (isNil "_durability") then {
	_vehicle setVariable ["durability",[0,0,0]];
	_durability = _vehicle getVariable "durability";
};

if (_ammo != "") then {
	call {
		if (_hit isEqualTo "hull_hit") exitWith {
			//Structural damage
			_partdamage = (_durability select 0) + _damage;
			_durability set [0,_partdamage];
			if (((_partdamage >= 0.9) or {((_durability select 1) >= 0.9)}) && {alive _vehicle}) then {
				0 = [_vehicle] call A3XAI_heliEvacuated; 
				_nul = _vehicle spawn {
					uiSleep 3;
					_this setVehicleAmmo 0;
					_this setFuel 0;
					_this setDamage 1;
				};
				{_vehicle removeAllEventHandlers _x} forEach ["HandleDamage","GetOut","Killed"];
			};
		};
		if (_hit isEqualTo "engine_hit") exitWith {
			_partdamage = (_durability select 1) + _damage;
			_durability set [1,_partdamage];
			if ((_partdamage > 0.88) && {alive _vehicle}) then {
				_damage = 0.88;	//Intercept fatal damage to helicopter engine - next hit will destroy the helicopter.
			};
		};
		if (_hit isEqualTo "tail_rotor_hit") exitWith {
			_partdamage = (_durability select 2) + _damage;
			_durability set [2,_partdamage];
			if ((_partdamage >= 0.9) && {_vehicle getVariable ["tailRotorFunctional",true]} && {alive _vehicle}) then {
				_vehicle setHitPointDamage ["tail_rotor_hit",1];	//Knock out helicopter tail rotor when sufficiently damaged
				_vehicle setVariable ["tailRotorFunctional",false];
				0 = [_vehicle] call A3XAI_heliEvacuated; 
				if (A3XAI_debugLevel > 0) then {diag_log format ["A3XAI Debug: Tail rotor disabled for AI air vehicle %1 (%2) at %3.",(typeOf _vehicle),(group _vehicle),(mapGridPosition _vehicle)];};
			};
		};
		if (_hit isEqualTo "fuel_hit") exitWith {_damage = 0};
	};
};

_damage
