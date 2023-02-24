_guy = _this select 0;

private ["_bmap", "_mr"];

if ((count buildings) > 0)
	
	exitWith {};

_xl = nearestObjects [xPos, ["house"], 17500];

{
		
		waitUntil {vx >= 160};
		
		_bc = [_x] call BIS_fnc_buildingPositions;
		
		if ((_x in buildings) or (count _bc <= 4) or ( (typeOf _x) in whiteList) or ( (typeOf _x) in blackList) or ((getPos _x) distance (getPos cpad) < 1550)) 
			
			then {
				
				if ((typeOf _x) == "Land_i_Shed_Ind_F")
				
					then {
						
						if (_x in warehouses)
							
							then {}
								
								else {
								
									null = [_x] execVM "System\Claims\warehouse.sqf";
									
									};
									
						};
						
				if ((typeOf _x) == "Land_CarService_F")
					
					then {
						
						if (_x in service)
							
							then {}
								
								else {null = [_x] execVM "System\Claims\servicestation.sqf";};
						};
						
				} else {
				
					sleep 0.1;
							
					if (_x in buildings)
						
						then {}
							
							else {
							
								buildings = buildings + [_x];
								
								_myMap = playerMap get (name _guy);
								_myMap params ["_tickets", "_points", "_money", "_roster", "_claims", "_kills", "_shots"];
								
								_x addAction

									[
										"Claim",	// title
										{
											params ["_target", "_caller", "_actionId", "_arguments"];
							
											private ["_mark", "_ct"];
											
											private _map = playerMap get (name _caller) ;
											_map params ["_tickets", "_points", "_money", "_roster", "_claims", "_kills", "_shots"];
				
											if (_tickets < 1) then {Hint "No Ticket!"}
												
												else {
													
													_tickets = _tickets - 1;
													
													_name = format ["%1%2", (name _caller), (getPos _target)];
													_mark = createMarker [_name,(getPos _target)];
													_mark setMarkerType "hd_dot";
													_mark setMarkerAlpha 1;
													_mark setMarkerColor "colorWhite";
													
													removeAllActions _target;
													
													buildings deleteAt (buildings find _target);
													claimMarkrs = claimMarkrs + [_mark];
													
													_claim = [_target, _mark, []];
													
													null = [ _caller, _claim] execVM "System\Claims\claimhouse.sqf";
													
													_map = [_tickets, _points, _money, _roster, _claims, _kills, _shots];
													playerMap set [(name _caller), _map];
													
													postIt = 1;
													
													};
													
											// script
										},
										nil,		// arguments
										1.5,		// priority
										true,		// showWindow
										true,		// hideOnUse
										"",			// shortcut
										"true", 	// condition
										8,		// radius
										false,		// unconscious
										"",			// selection
										""			// memoryPoint
									];
								
								};
					
					};
				
		if (_x distance xPos > 3500)
			
			then {
				
				waitUntil {(count warehouses) >= 1};
				sleep 0.2;
				
				};
			
		if ((count _bc) > 15)
			
			then {
				
				strongHolds = strongHolds + [_x];
				buildings deleteAt (buildings find _x);
				
				
				
				};
			
		}forEach _xl;

