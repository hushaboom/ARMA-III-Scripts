_guy = _this select 0;
_place = _this select 1;

private ["_truck", "_toob", "_workTruck", "_guy"];

If (workOrder == 0)
	
	then {
		
		_work = [_guy,"BombTruck",["Find a Truck.  Not just any truck, but a flatbed cargo carrier, 
			like the ones we use for hauling supplies.  Bring it back here when you're done, and register it.",
			"The Truck","Defend"],nil,3,2,true,"Defend",false] call BIS_fnc_taskCreate;
			
			while {(alive _guy) and (workOrder == 0)}
				
				do {
					
					if (_guy isEqualTo driver objectParent _guy)
						
						then {
							
							if (typeOf (vehicle _guy) in ["C_Van_01_transport_F", "B_G_Van_01_transport_F", "O_G_Van_01_transport_F", "I_G_Van_01_transport_F"])
							
								then {
							
									if ((vehicle _guy) in Trucks)
										
										then {}
											
											else {
												
												hint "Go back to the shop and register this truck.";
												_truck = (vehicle _guy);
												[_work, (_place buildingPos 5)] call BIS_fnc_taskSetDestination;
												waitUntil {_truck distance (_place buildingPos 5) < 5};
												hint "Register the truck.";
												[_work, (_place buildingPos 1)] call BIS_fnc_taskSetDestination;
												waitUntil {_truck in registeredCars};
												[_work,"SUCCEEDED",true] spawn BIS_fnc_taskSetState;
												carCollection deleteAt (carCollection find _truck);
												workOrder = 1;
												
												sleep 3;
												
												};
									};
							};
						
					};

		};
		
		
if (workOrder == 1)
	
	then {
		
		_toobs = ["B_Mortar_01_weapon_F", "I_E_Mortar_01_Weapon_F", "I_Mortar_01_weapon_F", "O_Mortar_01_weapon_F"];
	
		_work = [_guy,"BombTruck 2",["Find a mortar launcher tube.  Bring it back here when you're done, and place it in the truck's cargo.",
			"The Toob","Defend"],nil,3,2,true,"Defend",false] call BIS_fnc_taskCreate;
			
		waitUntil {(typeOf (unitBackpack _guy)) in _toobs};
		_toob = (unitBackpack _guy);
		
		hint "Nice. Install the mortar tube in the bed of the truck.";
		
		[_work, (_place buildingPos 5)] call BIS_fnc_taskSetDestination;
		
		_truck addAction

			[
				"Install",	// title
				{
					params ["_target", "_caller", "_actionId", "_arguments"];
					_gun = "B_G_Mortar_01_F" createVehicle [0,0,1500];
					_gun attachTo [_target, [0, -2.2, 0.2]];
					removeAllActions _target;
					removeBackpack _caller;
					deleteVehicle _arguments;
					workOrder = 1.5;
					
					hint "You can now craft mortar trucks!  Just find a truck and a tube; 
						you can assemble it anywhere, no need for a shop!";
						
					bombTruck = 1;
					
					// script
				},
				_toob,		// arguments
				5,		// priority
				true,		// showWindow
				true,		// hideOnUse
				"",			// shortcut
				"true", 	// condition
				5,			// radius
				false,		// unconscious
				"",			// selection
				""			// memoryPoint
				
				];
		
		sleep 1;
		waitUntil {workOrder == 1.5};
		[_work,"SUCCEEDED",true] spawn BIS_fnc_taskSetState;
		workOrder = 2;
		
		sleep 3;
		
		};
		
if (workOrder == 2)
	
	then {
	
		_Punks = [];
		
		_work = [_guy,"BombTruck 3",["Time to test out your new toy.  There is a Maurader Outpost just south of	Alikampos.
			Park your truck somewhere in range of the Outpost, and flatten it.","New Toys","Defend"],[11442.2,14230.2,0],3,2,true,"Defend",false] call BIS_fnc_taskCreate;
			
		_dood = [[11442.2,14230.2,0], 8] call redSp;
		_wp = (group _dood) addWaypoint [[11442.2,14230.2,0], 0];
		_wp setWaypointType "GUARD";
		_Punks = _Punks + (units (group _dood));
		_dood = [[11442.2,14230.2,0], 8] call redSp;
		_Punks = _Punks + (units (group _dood));
		null = [_dood, [11442.2,14230.2,0], (getPos _DOOD), 1, 4 + (random 6)] execVM "System\Generators\wpgen.sqf";
		
		_building = nearestBuilding [11442.2,14230.2,0];
		
		waitUntil {(damage _building) > 0.9};
		
		[_work,"SUCCEEDED",true] spawn BIS_fnc_taskSetState;
		workOrder = 3;
		
		sleep 3;
		
		};
		
if (workOrder == 3)
	
	then {
		
		_work = [_guy,"Auto Rescue",["Find a service truck or van, then register it.  Having Auto Rescue will keep your fleet of supply trucks maintained.","Altis Auto Rescue and Recovery","Defend"],nil,3,2,true,"Defend",false] call BIS_fnc_taskCreate;
		
		_vechs = ["C_Van_02_service_F", "C_Offroad_01_repair_F", "I_G_Offroad_01_repair_F", "O_G_Offroad_01_repair_F", "B_G_Offroad_01_repair_F"];
		
		while {(alive _guy) and (workOrder == 3)}
				
				do {
					
					if (_guy isEqualTo driver objectParent _guy)
						
						then {
							
							if (typeOf (vehicle _guy) in _vechs)
							
								then {
							
									hint "Go back to the shop and register this truck.";
									private _workTruck = (vehicle _guy);
									[_work, (_place buildingPos 5)] call BIS_fnc_taskSetDestination;
									waitUntil {_workTruck distance (_place buildingPos 5) < 5};
									hint "Register the truck.";
									[_work, (_place buildingPos 1)] call BIS_fnc_taskSetDestination;
									
									waitUntil {_workTruck in registeredCars};
									
									[_work,"SUCCEEDED",true] spawn BIS_fnc_taskSetState;
									carCollection deleteAt (carCollection find _workTruck);
									workOrder = 4;
									
									sleep 3;
											
									};
							};
						
					};
		};
		
if (workOrder == 4)
	
	
	then {
	
		if (isNil "_workTruck")
			
			then {theTruck = serv}
				
				else {theTruck = _workTruck};
		
		["Shop Work","SUCCEEDED",true] spawn BIS_fnc_taskSetState;
		hint parseText format ["You can now hire mechanics to join your team from any repair shop!<br></br>"];
		
		_trig = createTrigger ["EmptyDetector", [0,0,0]]; 
		_trig setTriggerArea [0, 0, 0, false]; 
		_trig setTriggerActivation ["ALPHA","NOT PRESENT", true]; 
		_trig setTriggerStatements ["this", "mechGo = 1; null = [player, theTruck] execVM 'System\Missions\Player\onCall_mechanic.sqf'", ""];
		
		
				
		};
		
		