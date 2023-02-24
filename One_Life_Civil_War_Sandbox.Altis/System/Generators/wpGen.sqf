_grpLead = _this select 0;
_wayPos = _this select 1;
_startPos = _this select 2;
_combat = _this select 3;
_numberCount = _this select 4;

private ["_pc", "_spot", "_wp", "_grpLead", "_wpCount"];

_wpCount = 0;

deleteWaypoint [(group _grpLead), 0];

wpGen = {
	

	if (_wpCount >= _numberCount) exitWith {
		
		_wp = (group _grpLead) addWaypoint [_startPos, 10];
		_wp setWaypointType "CYCLE";
		_wp setWaypointCombatMode "BLUE";
		
		_wpCount = 0;
		
	};
	
	_foliage = nearestTerrainObjects [_startPos, ["Tree"], 100];
	_houses = _startPos nearObjects ["house",500];
	
	if (count _foliage > 85)
		
		then {
			
			_foliage = nearestTerrainObjects [_startPos, ["Tree"], 400];
			
			for "_i" from 0 to 3 do {
				
				_spot = selectRandom _foliage;
				
				if (isNull _spot) exitWith {[] call wpGen2};
				
				_type = selectRandom ["MOVE", "SAD"];
				_speed = selectRandom ["LIMITED", "NORMAL"];
				_mode = selectRandom ["RED", "YELLOW", "WHITE"];
				
				while {(getPos _spot) distance player < 225} do {_spot = selectRandom _foliage};
				
				_wp = (group _grpLead) addWaypoint [(getPos _spot), 1];
				_wp setWaypointType _type;
				_wp setWaypointSpeed _speed;
				_wp setWaypointCombatMode _mode;
				
				_wpCount = _wpCount + 1;
				
				};
			
			}
		
			else {
				
				if (count _houses < 5) exitWith {[] call wpGen2};
				
				_spot = selectRandom _houses;
				
				if (isNull _spot) exitWith {[] call wpGen2};
				
				while {(getPos _spot) distance player < 225} do {
					
					_houses deleteAt (_houses find _spot);
					_spot = selectRandom _houses};
				
				_pc = [_spot] call BIS_fnc_buildingPositions;
				
				if (isNil {"_pc"}) exitWith {[] call wpGen2};
				
				
				while {count _pc < 3} do {
					
					_houses deleteAt (_houses find _spot);
					
					if (count _houses < 1) exitWith {[] call wpGen2};
					
					_spot = selectRandom _houses;
					
					if (isNull _spot) exitWith {[] call wpGen2};
				
					_pc = [_spot] call BIS_fnc_buildingPositions;
					
					if (isNil {"_pc"}) exitWith {[] call wpGen2};
					
					};
					
				_dice = random 1000;
				
				if (_dice < 250)
					
					then {
						
						for "_i" from 1 to (count _pc)/2 
							
							do {
								
								_room = selectRandom _pc;
								_pc deleteAt (_pc find _room);
								
								_mode = selectRandom ["RED", "YELLOW"];
								
								if (typeName _spot == "ARRAY")
									
									then {_wp = (group _grpLead) addWaypoint [_spot, 1];
									
									}
									
									else {
										
										_wp = (group _grpLead) addWaypoint [(getPos _spot), 1];
										
										};
								
								_wp setWaypointType "MOVE";
								_wp setWaypointSpeed "LIMITED";
								_wp setWaypointCombatMode _mode;
								_wp setWaypointTimeout [10, 10, 10];
								
								};
								
							_wpCount = _wpCount + 1;
							
						}
						
						else {
							
							_spot = [(getPos _grpLead), 80, 135, 0, 0, 60, 0] call BIS_fnc_findSafePos;
								
							for "_i" from 0 to 3
							
								do {
								
								_type = selectRandom ["MOVE", "SAD"];
								_speed = selectRandom ["LIMITED", "NORMAL"];
								_mode = selectRandom ["RED", "YELLOW", "WHITE"];
								
								_wp = (group _grpLead) addWaypoint [_spot, 1];
								_wp setWaypointType _type;
								_wp setWaypointSpeed _speed;
								_wp setWaypointCombatMode _mode;
								
								_spot = [_spot, 80, 135, 0, 0, 60, 0] call BIS_fnc_findSafePos;
							
								};
								
							_wpCount = _wpCount + 1;
							
							};
				
				};
				
				if (isNil {"_pc"}) exitWith {[] call wpGen2};
				
	[] call wpGen;
	
};

wpGen2 = {

	_spot = getPos _grpLead;
	
	for "_i" from 0 to (1 + random 3)
							
		do {
		
		_type = selectRandom ["MOVE", "SAD"];
		_speed = selectRandom ["LIMITED", "NORMAL"];
		_mode = selectRandom ["WHITE", "YELLOW"];
		
		_wp = (group _grpLead) addWaypoint [_spot, 1];
		_wp setWaypointType _type;
		_wp setWaypointSpeed _speed;
		_wp setWaypointCombatMode _mode;
		
		_spot = [_spot, 80, 135, 0, 0, 60, 0] call BIS_fnc_findSafePos;
	
		};
		
	_wpCount = _wpCount + 1;
	
	[] call wpGen;
	
	};
	



[] call wpGen;