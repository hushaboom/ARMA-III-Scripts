_guy = _this select 0;


while {(alive _guy) and (strongCount > 5)}
	
	do {
		
		strongHolds = [strongHolds, [], { _guy distance (getPos _x) }, "ASCEND"] call BIS_fnc_sortBy;
		
		if (floor (random 12) in [7, 11])
			
			then {
				
				private _spot = strongHolds select 1;
				private _pos = getPos _spot;
				
				if (_spot distance _guy > 450)
					
					then {
						
						hint "Enemy Outpost nearby";
						
						_dood = [_pos, 6] call redSp;
						
						null = [_dood, _pos, _pos, 1, 6] execVM "System\Generators\wpgen.sqf";
						sleep 0.5;
						
						_bc = [_spot] call BIS_fnc_buildingPositions;
						
						for "_i" in (floor (count _bc)/3)
							
							do {
								
								_ct = random (count FIAArray_EAST) - 1;
								_pg = createGroup east;
								_unit = _pg createUnit [(FIAArray_EAST select _ct), [_bc, 1, 1, 1, 0, 3, 0, [], []] call BIS_fnc_findSafePos, [], AISkillNum, "FORM"];
								
								_wp = _pg addWaypoint [_bc, 0];
								_wp setWaypointType "HOLD";
								
								};
							
						};
					
				};
			
		};