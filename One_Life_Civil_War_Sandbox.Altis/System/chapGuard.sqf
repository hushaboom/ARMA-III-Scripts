_guy = _this select 0;

while {alive _guy}
	
	do {
	
		while {(count (waypoints CG0)) > 0} do {
					
			deleteWaypoint ((waypoints CG0) select 0);
		
			};
		
		_pos = [(getPos Chappie), 5, 15, 3, 0, 20, 0] call BIS_fnc_findSafePos;
		null = [_guy, _pos, _pos, 0, 6] execVM "System\Generators\wpgen.sqf";
						
		
		waitUntil {leader CG0 distance Chappie > 675};
		
		while {(count (waypoints CG0)) > 0} do {
					
			deleteWaypoint ((waypoints CG0) select 0);
		
			};
		
		_pos = [(getPos Chappie), 15, 30, 3, 0, 20, 0] call BIS_fnc_findSafePos;
		_wp = CG0 addWaypoint [(getPos Chappie),0];
		_wp setWaypointType "MOVE";
		_wp = CG0 addWaypoint [_pos,0];
		_wp setWaypointType "GUARD";
		
		waitUntil {leader CG0 distance Chappie > 450};
		
		};