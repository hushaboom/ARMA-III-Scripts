_guy = _this select 0;

while {(count (waypoints (group _guy))) > 0} do {
					
	deleteWaypoint ((waypoints (group _guy)) select 0);

	};
if (isPlayer _guy)
			
	then {removeAllActions _guy};

private ["_house", "_spot", "_dood", "_allies", "_tickets", "_doodLevel"];

_snap = getPos _guy;
_allies = [];

if (baseOn == 0)
	
	then {
		
		_pos = [(getPos cTruck), 350, 450, 3, 0, 20, 0] call BIS_fnc_findSafePos;
	
		while {_pos distance _guy < 200}
	
			do {_pos = [(getPos cTruck), 350, 450, 3, 0, 20, 0] call BIS_fnc_findSafePos};
			
		_dood = [_pos, 5] call redSp;
		
		null = [_dood, (getPos cTruck), (getPos cTruck), 0, 6] execVM "System\Generators\wpgen.sqf";

		registeredLand = [(nearestBuilding mycar), (nearestBuilding cTruck)];
		
		};

_startTime = (floor dayTime) + 1;

null = [_guy] execVM "System\Player\payday.sqf";
waitUntil {(regOn == 1) or (vx >= 160)};

sleep 6;

while {(alive _guy)} do {
	
	waitUntil {vx > 150};
	
	if (_guy in (units glg20))
		
		then {}
			
			else {
						
				while {(count (waypoints (group _guy))) > 0} do {
								
					deleteWaypoint ((waypoints (group _guy)) select 0);
				
					};
					
				};
					
	sleep 0.1;

	_doodLevel = (floor (150 * (lootLevel/10))) + (popStart * (lootLevel/10));

	if (_doodLevel < 32) then {_doodLevel = 32};
	
	if ((_guy distance redcop < 2100) or (_guy distance Cardinal < 2100))
		
		then {_doodLevel = _doodLevel + 34};

	if (_doodLevel > 105)
		
		then {_doodLevel = 105};

	_place = nearestBuilding _guy;
	
	if ((count allUnits) > 105)
		
		then {
			
			spawnOnOff = 0;
			
			{
				
				if (_x distance _guy > 1200)
					
					then {
						
						if (_x in (units(group player)))
							
							then {}
								
								else {
											
									deleteVehicle _x;
									doods deleteAt (doods find _x);
									
									};
									
						};
						
				} forEach doods;
				
			{
				
				if (_x distance _guy > 1200)
					
					then {
						
						if (_x in (units (group player)))
							
							then {}
								
								else {
											
									deleteVehicle _x;
									onHand deleteAt (onHand find _x);
									
									};
									
						};
						
				} forEach onHand;
				
			if ((count allUnits) < 105)
				
				then {spawnOnOff = 1};
			
			}
			
			else {spawnOnOff = 1};
		
	if ((spawnOnOff == 1) and (vx >= 200) and ((count doods) < _doodLevel) and (redForce > 0))
		
		then {
	
		_land = [RoseLand, [], { _guy distance (getMarkerPos _x) }, "ASCEND"] call BIS_fnc_sortBy;
		_land = _land select 0;
		
		if ((_guy distance getMarkerPos _land < 2200))
			
			then {
				
				_txt = parseText format ["<t size='1.25' color='#ff0000'>WARNIG!</t><br></br>You are tresspassing on Rose Territory."];
				_houses = getMarkerPos _land nearObjects ["house",1500];
				
				_p = AISkillNum;
				
				AISkillNum = AISkillNum + 0.46;
				
				while {RoseOpperators < (_doodLevel/4)}
					
					do {
						_house = selectRandom _houses;
						_pos = [(getPos _house), 45, 90, 3, 0, 20, 0] call BIS_fnc_findSafePos;
						_pops = [RoseLand, [], { _guy distance (getMarkerPos _x) }, "ASCEND"] call BIS_fnc_sortBy;
						_dood = [_pos, (2 + (random 4))] call redSp;
						null = [_dood, (getMarkerPos (_pops select 0)), (getMarkerPos(_pops select 0)), 1, 6 + (random 16)] execVM "System\Generators\wpgen.sqf";
							
						RoseOpperators = RoseOpperators + (count (units (group _dood)));
						
						};
				
				AISkillNum = _p;
				hintSilent _txt;
				
				};
			
		registeredLand = [registeredLand, [], { _guy distance (getPos _x) }, "ASCEND"] call BIS_fnc_sortBy;
		
		{
			if ((_guy distance _x < 350) and ((count registeredLand) > 1))
				
				then {
							
					if (((count onHand) < 24) and ((floor (random 12)) in [7, 11]))
						
						then {
							
							_pos = [(getPos _x), 1, 5, 3, 0, 20, 0] call BIS_fnc_findSafePos;
							
							if ((getPos _x) in spawnLocs)
								
								then {}
									
									else {
									
										_dood = [_pos, 1] call mySp;
										spawnLocs = spawnLocs + [(getPos _x)];
										onHand = onHand + [_dood];
										addSwitchableUnit _dood;
							
							_wp = (group _dood) addWaypoint [(getPos _x), 10];
							_wp setWaypointType "GUARD";
							
									};
					
							};	
					};
				
				} forEach registeredLand;
				
		_rad = 400;
		
		if (baseOn == 1)
			
			then {_rad = 850};
			
		_houses = _snap nearObjects ["house",_rad];
		_houses = _houses call BIS_fnc_arrayShuffle;
		_foliage = nearestTerrainObjects [_guy, ["Tree"], (_rad/2)];
		
		_doods = [];
		
		_count = (floor (175 * (lootLevel/10))) + popStart;
		
		if ((_guy distance _snap < 500) and ((count allUnits) < _count))
			
			then {
				
				if (count _foliage > 85)
					
					then {
						
						_foliage = nearestTerrainObjects [_guy, ["Tree"], _rad];
						_spot = (selectRandom _foliage);
						
						if (typeName _spot == "ARRAY")
							
							then {
								
								_foliage = _snap nearRoads _rad;
		
								_spot = (selectRandom _foliage);
								
								};
							
						_house = _spot;	
						
						}
							
							else {
								
								_house = selectRandom _houses;
								_houses deleteAt (_houses find _house);
								
								};
				
				if (((getPos _house) distance _guy < 150))
					
					then {}
					
						else {
						
							_playerMap = playerMap get (name _guy);
							_playerMap params ["_tickets", "_points", "_money", "_roster", "_claims", "_kills", "_shots"];
													
							_pos = [(getPos _house), 5, 30, 3, 0, 20, 0] call BIS_fnc_findSafePos;
							
							if ((_guy distance blucop < 1500) and (bluForce > 0))
								
								then {_dood = [_pos, (1 + (lootLevel))] call blueSp}
								
									else {
										
										registeredLand = [registeredLand, [], { _guy distance _x }, "ASCEND"] call BIS_fnc_sortBy;
										
										if (((count onHand) < (48*(lootLevel/10))) and ((_guy distance grecop < 350) or (_guy distance Chappie < 350) or (_guy distance (getPos (registeredLand select 0)) < 350)))
											
											then {
											
												_dood = [_pos, (1 + (random 3))] call mySp;
												addSwitchableUnit _dood;
												
												if ((count _roster) < ((count registeredLand)*4))
													
													then {
															
														_roster = _roster + [_dood];
														
														};
												
												_playerMap = [_tickets, _points, _money, _roster, _claims, _kills, _shots];
												playerMap set [(name _guy), _playerMap];
												
												postIt = 1;
												
												}
											
												else {_dood = [_pos, (1 + (random 3))] call redSp;};
								
										};
							
							sleep 0.2;
							
							if (isNull _dood)
								
								then {}
									
									else {
									
										null = [_dood, (getPos _guy), (getPos _guy), 1, 1 + (random 6)] execVM "System\Generators\wpgen.sqf";
										
										};
									
							_dice = random 1000;
							
							if (_dice > 720)
								
								then {
									
									_pos = [(getPos _house), 45, 90, 3, 0, 20, 0] call BIS_fnc_findSafePos;
									registeredLand = [registeredLand, [], { _guy distance _x }, "ASCEND"] call BIS_fnc_sortBy;
									
									if ((_guy distance (getPos (registeredLand select 0)) <= 450) or (_guy distance grecop < 650))
										
										then {
											
											_dood = [_pos, (2 + random 2)] call mySp;
											addSwitchableUnit _dood;
											
											}
											
											else {
														
												if ((_guy distance blucop < 1500) or (_guy distance grecop < 1500))
													
													then {
														
														if (bluForce > 0)
															
															then {_dood = [_pos, (2 + random 2)] call blueSp};
															
															}
														
														else {
															
															if (redForce > 0)
																
																then {
																
																_dood = [_pos, (2 + random 2)] call redSp;
																	
																	};
															
															};
														
												};
									
									if (isNull _dood)
										
										then {}
											
											else { 
											
												if (floor (random 12) in [7, 11])
													
													then {
													
														if ((nearestObject [_pos, "LandVehicle"]) in registeredCars)
															
															then {}
																
																else {
														
																	_pos0 = getPos (nearestObject [_pos, "LandVehicle"]);
																	
																	_wp = (group _dood) addWaypoint [_pos0, 0];
																	_wp setWaypointType "MOVE";
																	
																	_wp = (group _dood) addWaypoint [_pos0, 0];
																	_wp setWaypointType "GETIN NEAREST";
																	
																	_pos1a = (getPos _guy) nearRoads 500;
																	
																	_wp = (group _dood) addWaypoint [getPos (selectRandom _pos1a), 0];
																	_wp setWaypointType "MOVE";
																	
																	_wp = (group _dood) addWaypoint [getPos (selectRandom _pos1a), 0];
																	_wp setWaypointType "GUARD";
																	
																	};
																	
														}
														
														else {
															
															null = [_dood, (_pos), (getPos _guy), 1, 12 + (random 6)] execVM "System\Generators\wpgen.sqf";
												
														};
													
													};
									};
							
							if (_dice < 220)
								
								then {
								
									_playerMap = playerMap get (name _guy);
									_playerMap params ["_tickets", "_points", "_money", "_roster", "_claims", "_kills", "_shots"];
															
									_pos = [(getPos _house), 45, 90, 3, 0, 20, 0] call BIS_fnc_findSafePos;
									_dood = [_pos, floor (random 1)] call civSp;
									addSwitchableUnit _dood;
									
									if (floor (random 12) in [7, 11])
										
										then {
										
											if ((nearestObject [_pos, "LandVehicle"]) in registeredCars)
												
												then {}
													
													else {
														
														_pos0 = getPos (nearestObject [_pos, "LandVehicle"]);
														
														_wp = (group _dood) addWaypoint [_pos0, 0];
														_wp setWaypointType "MOVE";
														
														_wp = (group _dood) addWaypoint [_pos0, 0];
														_wp setWaypointType "GETIN NEAREST";
														
														_pos1a = (getPos _guy) nearRoads 500;
														
														_wp = (group _dood) addWaypoint [getPos (selectRandom _pos1a), 0];
														_wp setWaypointType "MOVE";
														
														_wp = (group _dood) addWaypoint [getPos (selectRandom _pos1a), 0];
														_wp setWaypointType "GUARD";
														
														};
														
											}
											
											else {
												
												null = [_dood, (_pos), (getPos _guy), 1, 12 + (random 6)] execVM "System\Generators\wpgen.sqf";
									
											};
									};
								
							if ((_dice < 15) and (redForce > 0))
								
								then {
									
									_pos = [(getPos _house), 145, 290, 3, 0, 20, 0] call BIS_fnc_findSafePos;
									_dood = [_pos, 2] call redSp;
									
									if (floor (random 12) in [7, 11])
										
										then {
										
											if ((nearestObject [_pos, "LandVehicle"]) in registeredCars)
												
												then {}
													
													else {
											
														_pos0 = getPos (nearestObject [_pos, "LandVehicle"]);
														
														_wp = (group _dood) addWaypoint [_pos0, 0];
														_wp setWaypointType "MOVE";
														
														_wp = (group _dood) addWaypoint [_pos0, 0];
														_wp setWaypointType "GETIN NEAREST";
														
														_pos1a = (getPos _guy) nearRoads 500;
														
														_wp = (group _dood) addWaypoint [getPos (selectRandom _pos1a), 0];
														_wp setWaypointType "MOVE";
														
														_wp = (group _dood) addWaypoint [getPos (selectRandom _pos1a), 0];
														_wp setWaypointType "GUARD";
														
														};
														
											}
											
											else {
												
												null = [_dood, (_pos), (getPos _guy), 1, 12 + (random 6)] execVM "System\Generators\wpgen.sqf";
									
											};
											
									};
									
							sleep 0.2;
							
							};
						
				
				}
					
					else {
					
						if (_guy distance _snap > 351)
							
							then {_snap = (getPos _guy)};
						
						{
							
							if ((alive _x) and (_x distance _guy) > 1500)
								
								then {
									
									doods deleteAt (doods find _x);
									deleteVehicle _x;
									
									};
									
							sleep 0.1;
							
							if (!alive _x)
								
								then {
									
									doods deleteAt (doods find _x);
									
									};
								
							} forEach doods;
						
							sleep 0.1;
							
						{
							
							if ((alive _x) and (_x distance _guy) > 1500)
								
								then {
									
									onHand deleteAt (onHand find _x);
									deleteVehicle _x;
									
									};
								
							sleep 0.1;
							
							if (!alive _x)
								
								then {
									
									onHand deleteAt (onHand find _x);
											
									};
								
							} forEach onHand;
						
							
						};
		
		sleep 0.1;
		
		{
			
			if ((side _x) == INDEPENDENT) then {_allies = _allies + [_x]}
			
			} forEach doods;
		
		if ((count _allies > ((count doods) / 4)) and ((random 1000) < 85) and (count doods < ((count registeredLand) * 12))) 
			
			then {
			
			if (count _foliage > 85)
					
				then {
					
					_foliage = nearestTerrainObjects [_guy, ["Tree"], _rad];
					_spot = (selectRandom _foliage);
					
					if (typeName _spot == "ARRAY")
						
						then {
							
							_foliage = _snap nearRoads _rad;

							_spot = (selectRandom _foliage);
							
							};
						
					_house = _spot;	
					
					}
						
						else {
							
							_house = selectRandom _houses;
							_houses deleteAt (_houses find _house);
							
							};
							
				_pos = [(getPos _house), 145, 290, 3, 0, 20, 0] call BIS_fnc_findSafePos;
				_dood = [_pos, 2 + (random 2)] call redSp;
				
				null = [_dood, (getPos _guy), (getPos _guy), 1, 2 + (random 6)] execVM "System\Generators\wpgen.sqf";
									
			};
			
		} else {
			
			{
				
				if (((side _x == independent) or (side _x == civilian)) and (count units (group _x) == 1))
					
					then {
						
						null = [_x] execVM "System\recruit.sqf";
						doods deleteAt (doods find _x);
						
						if (_x in onHand)
							
							then {}
								
								else {onHand = onHand + [_x]};
						
						};
					
				} forEach doods;
				
						
			{
				if ((!alive _x) or (_x distance _guy > 1500))
				
					then {
						
						doods deleteAt (doods find _x);
						
						if (alive _x)
							
							then {deleteVehicle _x};
							
						};
						
				} forEach doods;
				
			{
				if ((!alive _x) or (_x distance _guy > 1200))
				
					then {
						
						if (alive _x)
							
							then {
									
								if (_x in (units (group player)))
									
									then {onHand deleteAt (onHand find _x);}
										
										else {
													
											deleteVehicle _x;
											
											};
											
								};
				
						};
						
				} forEach onHand;
			
			
			};
	
	sleep 0.1;
		
	{
		if ((!alive _x) or (_x distance _guy > 1500))
		
			then {
				
				doods deleteAt (doods find _x);
				
				if (alive _x)
					
					then {deleteVehicle _x};
					
				};
				
		} forEach doods;
		
	{
		if ((!alive _x) or (_x distance _guy > 1200))
		
			then {
				
				if (alive _x)
					
					then {
							
						if (_x in (units (group player)))
							
							then {onHand deleteAt (onHand find _x);}
								
								else {
											
									deleteVehicle _x;
									
									};
									
						};
						
				};
				
		} forEach onHand;
	
	AISkillNum = ((count registeredLand)/200);
	
	{
		
		if (_x distance _guy > 550)
			
			then {
				
				spawnLocs deleteAt (spawnLocs find _x);
				
				};
				
		} forEach spawnLocs;
	
	while {((count registeredLand) >= startcount) and (startcount < 50)}
		
		do {
			
			lootLevel = lootLevel +1;
			startcount = startcount * 2;
			
			hintSilent format ["Your Influence level has increased.  Level - %1/10", lootLevel];
			
			};
			
	
	if (redForce < (650 - (650*0.9)))
		
		then {
		
			w = 4;
			
			_reg4 = [_guy,"RTB2",["Report your success to the Registrar","Return to Athira.","Attack"],(getPos grecop),3,2,true,"Attack",false] call BIS_fnc_taskCreate;

			waitUntil {_guy distance grecop < 20};

			removeAllActions grecop;

			grecop addAction

				[
					"Report",	// title
					{
						params ["_target", "_caller", "_actionId", "_arguments"];
						
						hint "Mission Complete.";
						
						w = 5;
						
						postIt = 1;
						
						// script
					},
					nil,		// arguments
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

			waitUntil {w == 5};

			[_reg4,"SUCCEEDED",true] spawn BIS_fnc_taskSetState;

			sleep 3;

			postIt = 1;

			sleep 1.6;
			
			"end1" call BIS_fnc_endMission;
			
			};
		
	};
	
