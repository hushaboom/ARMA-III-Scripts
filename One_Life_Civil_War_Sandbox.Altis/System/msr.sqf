_guy = _this select 0;
_msr = _this select 1;
_pos = _this select 2;

_start = [15470.8,15910,0];
_box = "VirtualReammoBox_F" createVehicle [15306,15852.3,0];

private ["_reg"];
private _name = (name _guy);

if (msrFail == 3)
	
	exitWith {
		
		hint "Nope, you're banned!";
		
		};

if (msrRec == 1)
	
	then {hint "You are busy.  Come back later."}
		
		else {

			removeAllActions Chappie;
			
			vx = 210;

			private _po = _start nearRoads 20;
			private _cTruck = "C_Van_01_transport_F" createVehicle _start;
			private _info = getRoadInfo (_po select 0);
			
			_cTruck allowDamage false;
			
			if (workOrder >= 3)
				
				then {
				
					_cTruck allowDamage false;
					
					}
					
					else {
					
						_cTruck allowDamage true;
						
						};
			
				
			_info params ["_mapType", "_width", "_isPedestrian", "_texture", "_textureEnd", "_material", "_begPos", "_endPos", "_isBridge"];
			private _p = [_begPos, _endPos];
			
			_p = [_p, [], { _cTruck distance _x }, "DECEND"] call BIS_fnc_sortBy;
			
			_cTruck setDir (_cTruck getDir (_p select 0));
			
			registeredCars = registeredCars + [_cTruck];
			
			Trucks = Trucks + [_cTruck];

			vx = 300;
			
			if ((count _msr) < 1)
				
				then {
					
					msrRec = 1;
					
					_truckDir = getDir nearestBuilding Chappie;
					_cTruck setDir _truckDir - 90;
					_cTruck setPosATL (getPos (nearestBuilding Chappie));
				
					_box attachTo [_cTruck, [0,-1.3,0.4]];
					
					sleep 1;
				
					detach _box;
		
					_box addAction

						[
							"Secure Cargo",	// title
							{
								params ["_target", "_caller", "_actionId", "_arguments"];
								
								(_arguments select 0) attachTo [(_arguments select 1), [0,-1.3,0.4]];
								
								removeAllActions _target;
								
								// script
							},
							[_box, _cTruck],		// arguments
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
					
					
					sleep 0.1;
					
					private _building = nearestBuilding _pos;
					
					if ((count Trucks) <= 1)
						
						then {
						
							_reg = [_guy,"MSR",["Set up a supply route from the docks.","MSR","Attack"],getpos _cTruck,3,2,true,"Attack",false] call BIS_fnc_taskCreate;
							
							}
							
							else {
							
								_reg = [_guy,"ASR",["Set up an Ancillary Supply Route from the docks.","ASR","Attack"],getpos _cTruck,3,2,true,"Attack",false] call BIS_fnc_taskCreate;
							
								};
							
					_map = playerMap get (name _guy);
					_map params ["_tickets", "_points", "_money", "_roster", "_claims", "_kills", "_shots"];

					_name = format ["%1%2", (name _guy), _building];
					_mark = createMarker [_name,(getPos _building)];
					_mark setMarkerType "hd_dot";
					_mark setMarkerAlpha 1;
					_mark setMarkerColor "colorGreen";

					_claims = _claims + [_building, _mark, []];
					_map = [_tickets, _points, _money, _roster, _claims, _kills, _shots];

					playerMap set [(name _guy), _map];

					postIt = 1;

					buildings deleteAt (buildings find _building);

					waitUntil {_guy distance _cTruck < 5};

					hint "Drive to your warehouse.";
					
					msrRec = 1;

					[_reg,_start] call BIS_fnc_taskSetDestination;
					waitUntil {_cTruck distance _start < 7};

					_msr = _msr + [_start];
					_lastPos = _start;
					_ct = 0;

					hint "Now recording Supply Route.";
					
					sleep 0.1;
					
					[_reg,(getPos _building)] call BIS_fnc_taskSetDestination;

					while {(_cTruck distance (getPos _building) > 150) and ((alive _guy) and ((damage _cTruck) < 0.85))}
						
						do {
						
						if (_cTruck distance _box > 8)
						
							exitWith {
								
								msrOn = 0;
								msrRec = 0;
								
								_msr = [];
								
								hint "It's not our job to make sure YOUR load is secure.  Do your job correctly, or you'll be banned from the yard.";
								deleteMarker _mark;
								[_reg,"FAILED",true] spawn BIS_fnc_taskSetState;
								
								msrFail = msrFail + 1;
								
								if (msrFail == 3)
									
									then {
										
										hint "Ok pal, you've damaged enough cargo.  Get the hell off my yard and don't come back.";
										null = [_guy] execVM "System\Player\dockban.sqf";
										
										};
								
								_cTruck setFuel 0;
								
								waitUntil {_guy distance _cTruck > 500};
								
								{deleteVehicle _x} forEach [_box, _cTruck];
								
								};
							
						waitUntil {(_cTruck distance _lastPos > 50) };
						_lastPos = getPos _cTruck;
						
						_ct = _ct + 1;
						
						if (_ct == 18)
							
							then {
							
								_msr = _msr + [_lastPos];
								_ct = 0;
								
								};
						
						};
					
					
					if ((damage _cTruck) > 0.85)
						
						exitWith {
							
							msrOn = 0;
							msrRec = 0;
							
							_msr = [];
							
							hint "Your truck is too badly damaged!";
							deleteMarker _mark;
							[_reg,"FAILED",true] spawn BIS_fnc_taskSetState;
							
							waitUntil {_guy distance _cTruck > 500};
								
							{deleteVehicle _x} forEach [_box, _cTruck];
							
							null = [_guy, [], _pos] execVM "System\msr.sqf";
							
							};
					
					if ((damage _cTruck < 0.85) and (_cTruck distance _box < 5))
						
						then {
						
							_posE = _building buildingExit 0;
							_pos = [_posE, 8, 8, 1, 0, 3, 0, [], []] call BIS_fnc_findSafePos;
							_msr = _msr + [_pos];

							_cTruck setFuel 0;

							if (player in _cTruck)
								
								then {
									
									hint "Exit vehicle";
									waitUntil {speed _cTruck < 1};
									commandGetOut units (group _guy);
									
									};

							sleep 2;

							waitUntil {player distance _cTruck > 25};

							[_reg,"SUCCEEDED",true] spawn BIS_fnc_taskSetState;
							
							msrRec = 0;
							
							if (w <= 2)
								
								then {w = w + 1};
							
						};
					
				};

			if (isNull (driver _cTruck))
				
				then {
					
					_map = playerMap get (name _guy);
					_map params ["_tickets", "_points", "_money", "_roster", "_claims", "_kills", "_shots"];
					
					createVehicleCrew _cTruck;
					
					sleep 0.3;
					
					(driver _cTruck) setCombatBehaviour "CARELESS";
					(driver _cTruck) allowFleeing 0;
					
					_roster = _roster + [(driver _cTruck)];
					_map = [_tickets, _points, _money, _roster, _claims, _kills, _shots];

					playerMap set [(name _guy), _map];
					
					msrRec = 0;
					postIt = 1;
						
					}
						
						else {
							
							_p = createGroup civilian;
							[(driver _cTruck)] join _p;
							msrRec = 0;
							
							};

			sleep 1;

			_cTruck setFuel 1;
			(driver _cTruck) allowDamage false;
			
			vx = 500;

			while {(alive _cTruck) or (damage _cTruck < 1)}
			
			do {
					
					{_x allowDamage true} forEach Trucks;
						
					_msrBack = [];
					
					private _end = _msr select 0;
					
					if (_cTruck distance Chappie < 300)
						
						then {
							
							_box = "VirtualReammoBox_F" createVehicle _start;
							_box attachTo [_cTruck, [0,-1.2,0.4]];
							
							
							_cTruck setDir (getDir _cTruck + 180);
						
							sleep (random 420);
							
							}
								
								else {
									
									if (!alive _guy)
										
										then {_guy = player};
										
									_playerMap = playerMap get (name _guy);
									_playerMap params ["_tickets", "_points", "_money", "_roster", "_claims", "_kills", "_shots"];

									sleep 15;
									detach _box;
									sleep 5;
									deleteVehicle _box;
									sleep 15;
									
									sleep 0.3;
									
									_txt0 = format ["Delivery complete. $%1 has been deposited into your account.  <br></br>All ammo boxes have been restocked.", (2500*lootLevel)];
									
									hint parseText _txt0;
											
									_playerMap = [_tickets, _points, (_money + (2500*lootLevel)), _roster, _claims, _kills, _shots];
									playerMap set [(name _guy), _playerMap];
							
									sleep 0.1;
									_boxes = nearestObjects [_cTruck, ["ReammoBox_F"], 1200];
									
									{
										
										if ((damage _x) > 0.5)
											
											then {deleteVehicle _x}
												
												else {
															
													_pos = (getPos _x);
													_dir = (getDir _x);
													_box = (typeOf _x);
													deleteVehicle _x;
													sleep 0.4;
													_boxnew = createVehicle [_box, _pos];
													_boxnew setDir _dir;
													
													};
										
										} forEach _boxes;
									
									postIt = 1;
									
									};
					
					while {(count (waypoints (group _cTruck))) > 0} do {
					
						deleteWaypoint ((waypoints (group _cTruck)) select 0);
						
						};
						
					sleep 2;
					
					for "_i" from 0 to (count _msr - 1) do {
				
						_msrBack = _msrBack + [(_msr select ((count _msr) - 1 -_i))];
					
						};
						
					{
						_wp = (group _cTruck) addWaypoint [_x,0];
						_wp setWaypointType "MOVE";
						_wp setWaypointBehaviour "CARELESS";
						_wp setWaypointCombatMode "BLUE";
						
						} forEach _msrBack;
						
					_msr = _msrBack;
					
					waitUntil {_cTruck distance _end < 10};
					
					if (_cTruck distance Chappie > 500)
						
						then {
							
							sleep 15;
							
							}
							
							else {
										
								sleep 60;
								
								};
					
				};
				
			registeredCars deleteAt (registeredCars find _cTruck);
			Trucks deleteAt (Trucks find _cTruck);
			
			hint "One of your Supply Trucks was destroyed. 
				A new truck is available.";
			
			msrOn = 0;
			msrRec = 0;
			
			};
