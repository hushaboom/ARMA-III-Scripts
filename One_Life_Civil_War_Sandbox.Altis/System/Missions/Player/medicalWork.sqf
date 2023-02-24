_guy = _this select 0;
_clinic = _this select 1;

if (meds == 0)
	
	then {
	
		_reg = [_guy,"Medical",["We are running low on medical supplies.  We need 50 First-Ais packs, and 6 medkits",
		"Medical Supplies.","Defend"],(getPos medBox),1,2,true,"Defend",false] call BIS_fnc_taskCreate;
		
		_pacs = 0;
		_kits = 0;
		
		meds = 1;
		
		_clinic addAction

			[
				"Deposit Supplies",	// title
				{
					params ["_target", "_caller", "_actionId", "_arguments"];
					
					private _kits = [];
					private _pacs = [];
					
					_stuff = itemCargo medBox;
					
					{
						
						if (_x == "Medikit")
							
							then {_kits = _kits + [_x]};
							
						if (_x == "FirstAidKit")
						
							then {_pacs = _pacs + [_x]};
							
						} forEach _stuff;
					
					if (((count _kits) == 5) and ((count _pacs) == 50))
						
						then {
							
							["Medical","SUCCEEDED",true] spawn BIS_fnc_taskSetState;
							meds = 1.5;
							
							}
								
								else {
								
									
									_c0 = 0 + (count _kits);
									_c1 = 0 + (count _pacs);
									
									_txt0 = format ["You need %1 more MedKits.", (5 - _c0)];
									_txt1 = format ["You need %1 more Firstaid Packs.", (50 - _c1)];
									
									if ((_c0 < 5) and (_c1 < 50))
										
										then {hint parseText format ["%1<br></br>%2", _txt0, _txt1]};
										
									if ((_c0 >= 5) and (_c1 < 50))
										
										then {hint _txt1};
										
									if ((_c0 < 5) and (_c1 >= 50))
										
										then {hint _txt0};
										
									};
						
					// script
				},
				nil,		// arguments
				5,		// priority
				true,		// showWindow
				true,		// hideOnUse
				"",			// shortcut
				"true", 	// condition
				12,			// radius
				false,		// unconscious
				"",			// selection
				""			// memoryPoint
				
				];
		
			
		};

waitUntil {meds > 1};

hint "You've been awarded 15 skill points and recieved a $5000 bonus!";
		
_myMap = playerMap get (name _guy);
_myMap params ["_tickets", "_points", "_money", "_roster", "_claims", "_kills", "_shots"];

playerMap set [(name _guy), [_tickets, _points + 15, _money + 5000, _roster, _claims, _kills, _shots]];

postIt = 1;

	
if (meds == 1.5)
	
	then {
	
		_trucks = ["B_G_Van_01_transport_F", "I_G_Van_01_transport_F", "O_G_Van_01_transport_F", "B_Truck_01_covered_F",
			"B_T_Truck_01_covered_F", "B_Truck_01_transport_F", "B_T_Truck_01_transport_F", "C_Truck_02_transport_F", 
			"O_Truck_03_transport_F", "O_Truck_03_covered_F", "I_Truck_02_transport_F", "I_E_Truck_02_transport_F", 
			"I_Truck_02_covered_F", "I_E_Truck_02_F"];
			
		_civTrucks = ["C_Truck_02_covered_F", "C_Van_01_transport_F"];
		
		hint "You need a Transport.  Find the right truck, and haul ass to Zaros.";
		
		sleep 1.61;
		
		_reg = [_guy,"transport",["Find a transport vehicle capable of carrying 9 or more passengers, and register it.",
		"Evac the Refugees.","Defend"],nil,1,2,true,"Defend",false] call BIS_fnc_taskCreate;
		
		waitUntil {((typeOf (vehicle _guy)) in _trucks) or ((typeOf (vehicle _guy)) in _civTrucks)};
		
		private _truck = (vehicle _guy);
		
		hint "You must register this vehicle before use.";
		
		waitUntil {_truck in registeredCars};
		
		[_reg,"SUCCEEDED",true] spawn BIS_fnc_taskSetState;
		
		hint "You've been awarded 5 skill points!";
		
		_myMap = playerMap get (name _guy);
		_myMap params ["_tickets", "_points", "_money", "_roster", "_claims", "_kills", "_shots"];

		playerMap set [(name _guy), [_tickets, _points + 5, _money, _roster, _claims, _kills, _shots]];

		postIt = 1;
		
		meds = 2;
		
		sleep 4;
		
		_reg = [_guy,"refuge",["There are 9 refugees trapped at the HI Zaros Hostel.  The area has been occupied by Rose Guerrillas and the are going door to door, executing anyone who refuses Rose doctrine.  The refugees qualify for execution.<br></br>Get to Zaro's ASAP, rescue the people trapped at the Hostel, and transport them to the supply port so they can escape on the next boat out.  You will need a truck to transport them.",
		"Evac the Refugees.","Defend"],[9064.84,11799.9,0],1,2,true,"Defend",false] call BIS_fnc_taskCreate;
		
		_badSpawn = [8890.2,12140.9,0];
		_tgtPos = [9064.84,11799.9,0];
		
		_building = nearestObject [_tgtPos, "House"];
		_rooms = [_building] call BIS_fnc_buildingPositions;
		
		_doods = [];
		
		{
			
			_pg = createGroup civilian;
		
			_unit = _pg createUnit [(selectRandom CIVArray), _x, [], random AISkillNum, "FORM"];
			_doods = _doods + [_unit];
			
			_unit addAction

				[
					"Rescue",	// title
					{
						params ["_target", "_caller", "_actionId", "_arguments"];
						_arguments params ["_doods", "_truck"];
						
						_target assignAsCargo _truck;
						_target join grpNull;
						_doods deleteAt (_doods find _target);
						
						{
							
							_x assignAsCargo _truck;
							
							} forEach _doods;
						
						_doods join _target;
						
						_wp = (group _target) addWaypoint [(getPos _truck), 1];
						_wp setWaypointType "GETIN";
						
						meds = 2.1;
						
						{removeAllActions _x} forEach _doods;
						
						// script
					},
					[_doods, _truck],		// arguments
					1,		// priority
					false,		// showWindow
					true,		// hideOnUse
					"",			// shortcut
					"True", 	// condition
					3,			// radius
					false,		// unconscious
					"",			// selection
					""			// memoryPoint
					
					];

			
			} forEach _rooms;
		
		waitUntil {meds == 2.1};
		
		[_reg, (getMarkerPos "marker_0")] call BIS_fnc_taskSetDestination;
		
		waitUntil {_truck distance (getMarkerPos "marker_0") < 12};
		
		_truck setFuel 0;
		
		waitUntil {speed _truck < 1};
		commandGetOut _doods;
		
		sleep 2;
		
		_guy setCaptive false;
		
		[_reg,"SUCCEEDED",true] spawn BIS_fnc_taskSetState;
		
		hint "You've been awarded 25 skill points and recieved $25,000 bonus!";
		
		_myMap = playerMap get (name _guy);
		_myMap params ["_tickets", "_points", "_money", "_roster", "_claims", "_kills", "_shots"];

		playerMap set [(name _guy), [_tickets, _points + 25, _money + 25000, _roster, _claims, _kills, _shots]];

		postIt = 1;
	
		meds = 3;
		
		};
		
waitUntil {meds > 2.5};