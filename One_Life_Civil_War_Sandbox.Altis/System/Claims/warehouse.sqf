_building = _this select 0;

waitUntil {baseOn == 1};

_desk = createVehicle ["OfficeTable_01_new_F", (_building buildingPos 3)];
_laptop = createVehicle ["Land_Laptop_unfolded_F", (_building buildingPos 0)];
_box = createVehicle ["CargoNet_01_box_F", (_building buildingPos 9)];
_desk setDir ((getDir _building));
_box setDir ((getDir _building));
_laptop setDir (getDir _building) + 180;
_laptop attachTo [_desk, [0, 0, 0.55]];
_guy = player;

boxes = boxes + [_box];

null = [_laptop, _box, _building] execVM "System\laptop.sqf";


if ((_building in warehouses) or ((getPos _building) distance Chappie < 50))
	
	then {}
	
		else {
		
			_laptop addAction

				[
					"Register",	// title
					{
						params ["_target", "_caller", "_actionId", "_towns"];
						
						if ((count Territories)*2 == (count warehouses))
							
							then {
								
								hint "You can only have 2 warehouses!";
								
								}
								
									else {
											
										if (_target in warehouses)
											
											then {}
												
												else {
															
													warehouses = warehouses + [_target];
													
													};
													
										_target removeAction _actionId;
										null = [_caller, [], _target] execVM "System\msr.sqf";
										
										};

						
						// script
					},
					_towns,		// arguments
					3,		// priority
					true,		// showWindow
					true,		// hideOnUse
					"",			// shortcut
					"True", 	// condition
					3,			// radius
					false,		// unconscious
					"",			// selection
					""			// memoryPoint
					
					];
			
			
			
			};
			
sleep 6;

if (laptopOn == 1)
	
	exitWith {};
	
if ((count warehouses) == 0)
				
	then {
	
		laptopOn = 1;
		
		_reg0 = [_guy,"Warehouse",["Every town needs supplies.<br></br>You need an income.<br></br>
		Go to the warehouse nearby, and use the computer to register.  
		Once registered, your warehouse will need a supply route.  When your supply route is established, 
		you will start earning money from the deliveries.  Warehouses are your primary source of income,
		but you can only manage 2 at a time.<br></br><br></br>You can sell your loot and vehicles at any warehouse, even if it 
		is not registered.  Fill the supply box in the warehouse with your loot, then use the computer 
		to complete the transaction.  You can also sell your loot with a vehicle.  Any loot stored in the 
		vehicle you are selling will be paid for, and added to your total except for first-aid kits; those 
		are taken for donation to IDAP.<br></br><br></br>
		Once you have a warehouse and established your MSR, all ammo and supply boxes in your territory
		will be restocked.","Secure the Warehouse.","Attack"],[14544.6,18827.8,0],"CREATED",2,true,"Attack",false] call BIS_fnc_taskCreate;
	
		waitUntil {((count warehouses) == 1) and (w == 1)};
		
		[_reg0,"SUCCEEDED",true] spawn BIS_fnc_taskSetState;
		
		hint "You've been awarded 5 skill points!";
		
		_myMap = playerMap get (name _guy);
		_myMap params ["_tickets", "_points", "_money", "_roster", "_claims", "_kills", "_shots"];

		playerMap set [(name _guy), [_tickets, _points + 5, _money, _roster, _claims, _kills, _shots]];

		postIt = 1;
	
		

	};
	
waitUntil {w == 1};

if ((count warehouses) == 1)
	
	then {

		_reg1 = [_guy,"Another Warehouse",["Claim another warehouse anywhere on the map to maximize your profits.","Secure Another Warehouse.","Attack"],nil,"CREATED",2,true,"Attack",false] call BIS_fnc_taskCreate;
		waitUntil {((count warehouses) == 2) and (w == 2)};

		[_reg1,"SUCCEEDED",true] spawn BIS_fnc_taskSetState;
		
		hint "You've been awarded 10 skill points!";
		
		_myMap = playerMap get (name _guy);
		_myMap params ["_tickets", "_points", "_money", "_roster", "_claims", "_kills", "_shots"];

		playerMap set [(name _guy), [_tickets, _points + 10, _money, _roster, _claims, _kills, _shots]];

		postIt = 1;
	
		
		};
		
