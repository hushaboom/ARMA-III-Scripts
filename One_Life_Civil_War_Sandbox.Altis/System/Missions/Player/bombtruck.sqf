_truck = _this select 0;
_guy = _this select 1;

waitUntil {bombTruck == 1};

_toobs = ["B_Mortar_01_weapon_F", "I_E_Mortar_01_Weapon_F", "I_Mortar_01_weapon_F", "O_Mortar_01_weapon_F"];
_aa = ["I_AA_01_weapon_F", "O_AA_01_weapon_F", "B_AA_01_weapon_F"];
_at = ["I_AT_01_weapon_F","I_AT_01_weapon_F", "I_E_AT_01_weapon_F", "O_AT_01_weapon_F", "B_AT_01_weapon_F"];

_allLaunchers = [[_toobs], [ _aa], [_at]];

if ((typeOf (unitBackpack _guy)) in _allLaunchers)
	
	then {
		
		_toob = (unitBackpack _guy);
		
		_truck addAction

			[
				"Install",	// title
				{
					params ["_target", "_caller", "_actionId", "_arguments"];
					_arguments params ["_toob", "_allLaunchers"];
					_allLaunchers params ["_toobs", "_aa", "_at"];
					
					if (_toob in _toobs)
						
						then {
						
							_gun = "B_G_Mortar_01_F" createVehicle [0,0,1500];
							
							};
					
					if (_toob in _aa)
						
						then {
						
							_gun = "I_static_AA_F" createVehicle [0,0,1500];
							
							};
					
					if (_toob in _at)
						
						then {
						
							_gun = "I_static_AT_F" createVehicle [0,0,1500];
							
							};
					
					_gun attachTo [_target, [0, -2.2, 0.2]];
					removeAllActions _target;
					removeBackpack _caller;
					deleteVehicle _arguments;
					
					removeAllActions _target;
					
					// script
				},
				[_toob, _allLaunchers],		// arguments
				5,		// priority
				true,		// showWindow
				true,		// hideOnUse
				"",			// shortcut
				"true", 	// condition
				3,			// radius
				false,		// unconscious
				"",			// selection
				""			// memoryPoint
				
				];
		
		};