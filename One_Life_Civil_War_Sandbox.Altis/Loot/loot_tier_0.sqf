_guy = _this select 0;
_tally = _this select 1;

_center = getPos _guy;

private ["_loot", "_tally", "_mapType", "_width", "_isPedestrian", "_texture", "_textureEnd", "_material", "_begPos", "_endPos", "_isBridge"];

createMarker ["tm", [0,0,0]];

_tc = 0;
_rm = nearestObjects [_center, ["House"], 1200];
_loot = guns + ClothArray + PackArray + ItemArray + AccArray + VestArray;

{	

	_dice = random 250;
				
	if (_dice < 100) 
		
		then {
			
			for "_i" from 0 to (1 + (random 3)) do {
			
				_rooms = [_x] call BIS_fnc_buildingPositions;
				
				if ((count _rooms > 4) and ((getPos _x) distance _guy > 50))
				
					then {
						
						_rm = selectRandom _rooms;
						
						private _intels = ["Intel_File1_F", "Leaflet_05_F", "Leaflet_05_New_F", "Intel_Photos_F",
											"Leaflet_05_Old_F", "Leaflet_05_Stack_F", "Intel_File2_F", "Item_FlashDisk", 
											"Item_Files"];
						
						if ((_rm in lootPos) or ((typeOf _x) in whiteList) or ((typeOf _x) in blackList))
							
							then {}
								
								else {
								
									_pc = createVehicle [(selectRandom _loot), _rm];
									lootPos = lootPos + [_rm];
									_tally = _tally + [_pc];
									 _pc enableDynamicSimulation true;
									 
									 if ((typeOf _pc) in ["Land_Money_F", "Item_Money_stack", "Item_Money_roll", "Item_Money_bunch", "Item_Money"])
										
										then {
											
											null = [_pc, _guy] execVM "System\Missions\Player\monies.sqf";
											
											};
									 
									if (_pc in _intels)
										
										then {
											
											null = [_guy, _pc] execVM "System\Missions\Player\intels.sqf";
											
											};
										
									};
						
						
					
					};
				
				};
			
			};
			
		carCollection = [carCollection, [], { _guy distance (getPos _x) }, "ASCEND"] call BIS_fnc_sortBy;
		
		if ((_dice >= 3.55) and (_dice <= 3.58) and (count carCollection < 12) and (regOn == 1))
			
			then {
				
				_plug = 0;
				
				_rds = (getPos _x) nearRoads 1685;
				_vehcs = TruckArray + CarArray;
				_vehc = selectRandom _vehcs;
				
				while {_plug == 0}
					
					do {
						
						private _po = (selectRandom _rds);
				
						private _info = getRoadInfo _po;
						_info params ["_mapType", "_width", "_isPedestrian", "_texture", "_textureEnd", "_material", "_begPos", "_endPos", "_isBridge"];
						
						AISkillNum = 0.65;
						
						_plug = 1;
						_roadDir = _begPos getDir _endPos;
		
						_pc = "I_APC_Wheeled_03_cannon_F" createVehicle _begPos;
						_pc setDir _roadDir - 90;
						
						_dood = [_begPos, 3] call redSp;
						
						_dood assignAsCommander _pc;
						(units (group _dood) select 1) assignAsDriver _pc;
						(units (group _dood) select 2) assignAsGunner _pc;
						
						_wp = (group _dood) addWaypoint [_begPos, 10];
						_wp setWaypointType "GETIN NEAREST";
						_wp setWaypointCombatMode "RED";
						
						_pos = ([(getPos grecop), 455, 550, 3, 0, 20, 0] call BIS_fnc_findSafePos);
						
						createGuardedPoint [east, _pos, -1, objNull];
						
						_wp = (group _dood) addWaypoint [_pos, 10];
						_wp setWaypointType "MOVE";
						
						_wp = (group _dood) addWaypoint [_pos, 0];
						_wp setWaypointType "GUARD";
						
						_dood = [_pos, 6] call redSp;
						
						null = [_dood, (_pos), (getPos _pc), 1, 6] execVM "System\Generators\wpgen.sqf";
						
						AISkillNum = ((count registeredLand)/200);
							
					};
 
				};
				
		carCollection = [carCollection, [], { _guy distance (getPos _x) }, "ASCEND"] call BIS_fnc_sortBy;	
			
		if (floor _dice in [6, 144, 223, 808])
			
			then {
			
				_plug = 0;
				
				_rds = (getPos _x) nearRoads 685;
				_vehcs = TruckArray + CarArray;
				_vehc = selectRandom _vehcs;
				
				while {_plug == 0}
					
					do {
						
						private _po = (selectRandom _rds);
				
						private _info = getRoadInfo _po;
						_info params ["_mapType", "_width", "_isPedestrian", "_texture", "_textureEnd", "_material", "_begPos", "_endPos", "_isBridge"];
						
						if ((_begPos distance _guy > 180) and (_mapType != "MAIN ROAD"))
							
							then {
								
								_plug = 1;
								_stuff = nearestObjects [_begPos, ["Vehicle"], 190];
								
								if ((count _stuff) >= 1)
									
									then {}
										
										else {
										
											_roadDir = _begPos getDir _endPos;
											"tm" setMarkerPos _begPos;
										
											_pc = _vehc createVehicle ((getMarkerPos "tm") vectorAdd [0,-(_width/2),0]);
											_pc allowDamage false;
											_pc setDamage 0;
											_pc setDir _roadDir;
											carCollection = carCollection + [_pc];
											_tally = _tally + [_pc];
											
											if ((typeOf _pc) in ["C_Van_01_transport_F", "B_G_Van_01_transport_F", "O_G_Van_01_transport_F", "I_G_Van_01_transport_F"])
												
												then {
													
													null = [_pc, _guy] execVM "System\Missions\Player\bombtruck.sqf";
													
													};
												
											
											sleep 0.3;
											_pc allowDamage true;
											
											if (_vehc in TruckArray)
												
												then {
													
													if ((random 100) > 80)
														
														then {
															
															_dood = [_begPos, 3] call redSp;
															
															while {(count (waypoints (group _dood))) > 0} do {
					
																deleteWaypoint ((waypoints (group _dood)) select 0);
																
																};
																
															_wp = (group _dood) addWaypoint [(getPos _pc),0];
															_wp setWaypointType "GETIN NEAREST";
															

															null = [_dood, (_begPos), (getPos _guy), 1, 4] execVM "System\Generators\wpgen.sqf";

															};
													};
											};
									
								
								};
						
						};
 
				};
			
		if (_dice < 29)
			
			then {
				
				_rooms = [_x] call BIS_fnc_buildingPositions;
				
				if ((count _rooms > 0) and (count _rooms < 8))
				
					then {
						
						_box = selectRandom AmmoArray;//hint format ["%1", getDir _x];
						_rm = (selectRandom _rooms);
						
						if ((_rm in lootPos) or (_x in whiteList) or (_x in blackList))
							
							then {}
								
								else {
								
									_pc = createVehicle [_box, _rm];
									_pc setDir (getDir _x);
									lootPos = lootPos + [_rm];
									sleep 0.2;
									
									if ((damage _pc) > 0.3)
										
										then {deleteVehicle _pc};
									};
						
					
					};
				
				
			};
	
	} forEach _rm;

sleep 2;

waitUntil {_guy distance _center > 1490};

{
	
	if (((getPos _x) distance _guy < 800) or (_guy in _x))
		
		then {}
			
			else{
				
				_tally deleteAt (_tally find _x);
				
				if ((_x in registeredCars) or (_x in boxes))
					
					then {}
						
						else {
						
							deleteVehicle _x;
							
							};
				
				};
				
	} forEach _tally;
	
sleep 2;

null = [_guy, _tally] execVM "Loot\loot_tier_0.sqf";
