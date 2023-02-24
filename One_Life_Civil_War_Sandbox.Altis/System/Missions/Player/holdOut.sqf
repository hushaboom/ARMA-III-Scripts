

_pos = (getPos redcop);

_xl = nearestObjects [_pos, ["house"], 5500];

{
	
	_bc = [_x] call BIS_fnc_buildingPositions;
	
	if ((count _bc) > 12)
		
		then {
			
			if (_x in strongHolds)
				
				then {}
					
					else {
								
						strongHolds = strongHolds + [_x];
						
						if (_x in buildings)
							
							then {
									
								buildings deleteAt (buildings find _x);
								
								};
						
						};
			
			};
	
	} forEach _xl;
	
null = [] execVM "System\Missions\Player\outPosts.sqf";