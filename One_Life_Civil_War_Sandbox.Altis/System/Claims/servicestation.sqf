_building = _this select 0;

waitUntil {regOn == 1};

_desk = createVehicle ["Land_CashDesk_F", (_building buildingPos 1)];
_desk setDir ((getDir _building));


_desk addAction

	[
		"Register Car",	// title
		{
			params ["_target", "_caller", "_actionId", "_arguments"];
			
			_car = nearestObject [_target, "LandVehicle"];
			_shop = nearestObject [_target, "House"];
			
			_hoist = (_shop buildingPos 5);
			
			if (_car distance _hoist > 5)
				
				then {hint "Park your vehicle in the shop if you want it inspected!"}
					
					else {
						
						if ((damage _car) > 0.65)
							
							then {hint "This vehicle is unsafe!  You need to repair it before you can register it!"}
								
								else {
								
									if (_car in registeredCars)
										
										then {hint "This vehicle is already registered to your faction."}
											
											else {
												
												hint "Your car is now registered and cannot be stolen or salvaged.";
												registeredCars = registeredCars + [_car];
												carCollection deleteAt (carCollection find _car);
												
												};
												
									};
						};
			
			// script
		},
		nil,		// arguments
		3,		// priority
		false,		// showWindow
		true,		// hideOnUse
		"",			// shortcut
		"True", 	// condition
		3,			// radius
		false,		// unconscious
		"",			// selection
		""			// memoryPoint
		
		];
		
_desk addAction

	[
		"Repair",	// title
		{
			params ["_target", "_caller", "_actionId", "_arguments"];
			
			_car = nearestObject [_target, "LandVehicle"];
			
			_playerMap = playerMap get (name _caller);
			_playerMap params ["_tickets", "_points", "_money", "_roster", "_claims", "_kills", "_shots"];
			
			_shop = nearestObject [_target, "House"];
			
			_hoist = (_shop buildingPos 5);
			
			if (_car distance _hoist > 5)
				
				then {hint "Park your vehicle in the shop if you want it inspected!"}
					
					else {
						
						_damage = (damage _car);
						_cost = (1500 * (damage _car));
						
						if (_money < _cost)
							
							then {hint format ["You cannot afford this!  It will cost $%1 to fix your ride.", (floor _cost)]}
								
								else {
									
									Hint format ["Vehicle repaired for $%1.", (floor _cost)];
									_car setDamage 0;
									
									_money = _money - _cost;
								
									};
						
						_playerMap = [_tickets, _points, _money, _roster, _claims, _kills, _shots];
						playerMap set [(name _caller), _playerMap];
					
						postIt = 1;
						
						};
			
			// script
		},
		nil,		// arguments
		3,		// priority
		false,		// showWindow
		true,		// hideOnUse
		"",			// shortcut
		"True", 	// condition
		3,			// radius
		false,		// unconscious
		"",			// selection
		""			// memoryPoint
		
		];
		
_desk addAction

	[
		"Jobs",	// title
		{
			params ["_target", "_caller", "_actionId", "_arguments"];
			
			null = [_caller, _arguments] execVM "System\Missions\Player\shopwork.sqf";
			
			// script
		},
		_building,		// arguments
		3,		// priority
		false,		// showWindow
		true,		// hideOnUse
		"",			// shortcut
		"workOrder < 4", 	// condition
		3,			// radius
		false,		// unconscious
		"",			// selection
		""			// memoryPoint
		
		];
		
_desk addAction

	[
		"Hire Mechanic",	// title
		{
			params ["_target", "_caller", "_actionId", "_arguments"];
			
			_map = playerMap get (name _caller);
			_map params ["_tickets", "_points", "_money", "_roster", "_claims", "_kills", "_shots"];
			
			if (((count _roster) < ((count registeredLand) * 4)) and ((count (units (group _caller)) < 6)))
			
				then {
					
					_unit = (group _caller) createUnit ["I_G_engineer_F", [(getPos grecop), 25, 50, 1, 0, 3, 0, [], []] call BIS_fnc_findSafePos, [], AISkillNum, "FORM"];
					removeAllItemsWithMagazines _unit;
					removeAllWeapons _unit;
					removeUniform _unit;
					removeVest _unit;
					
					_unit forceAddUniform "Item_U_C_Mechanic_01_F";
					_unit setPos (getPos _target);
					
					onHand = onHand + [_unit];
					
					_playerMap = [_tickets, _points, _money, _roster + [_unit], _claims, _kills, _shots];
					playerMap set [(name _caller), _playerMap];
					
					postIt = 1;
					
					}
					
					else {hint "Your Roster is full!"};
			
			// script
		},
		_building,		// arguments
		3,		// priority
		false,		// showWindow
		true,		// hideOnUse
		"",			// shortcut
		"workOrder == 4", 	// condition
		3,			// radius
		false,		// unconscious
		"",			// selection
		""			// memoryPoint
		
		];
