_guy = _this select 0;
_place = _this select 1;

private ["_building"];

_townList = cityHold + townHold;
_townList = [_townList, [], { (_place select 0) distance (getMarkerPos _x) }, "ASCEND"] call BIS_fnc_sortBy;

_town = nearestLocation [(getMarkerPos (_townList select 0)), ""];

_name = name _town;
_size = size _town;
_rad = sqrt(((_size select 0)^2) + (_size select 1)^2)/2;

if (_name == "")
	
	then {_name = text _town};
	
vx = 150;

_staff = [];

_place params ["_building", "_mark", "_staff"];
buildings deleteAt (buildings find _building);

ClaimedBuildings = ClaimedBuildings + [_building];

_playerMap = playerMap get (name _guy);

_playerMap params ["_tickets", "_points", "_money", "_roster", "_claims", "_kills", "_shots"];

if (baseOn != 0)
	
	then {_staff = []};

_playerMap = [_tickets, _points, _money, _roster, _claims + [_place], _kills, _shots];
playerMap set [(name _guy), _playerMap];

postIt = 1;

sleep 0.1;
null = [_guy, _mark, _building] execVM "System\Missions\Player\residential.sqf";

if ((count onHand) < 12)
	
	then {
		
		
		for "_i" from 0 to 1 do {

			_bc = [_building] call BIS_fnc_buildingPositions;
			_pos = selectRandom _bc;
			_dood = [_pos, 0] call mySp;
			sleep 0.1;
			onHand = onHand + [_dood];
			_dood setPosATL _pos;
			addSwitchableUnit _dood;
			sleep 0.1;
			
			if (_i == 0)
				
				then {
						
					_wp = (group _dood) addWaypoint [_pos, 0];
					_wp setWaypointType "MOVE";
					null = [_dood, _building, _guy] execVM "System\guards.sqf";
					
					} else {
					
						null = [_dood, _pos, _pos, 0, 5] execVM "System\Generators\wpgen.sqf";
						
						};
			
			};
			
		};
		

	
_building addAction

	[
		"SaveGame",	// title
		{
			params ["_target", "_caller", "_actionId", "_arguments"];
			
			_map = playerMap get (name _caller);
			_map params ["_tickets", "_points", "_money", "_roster", "_claims", "_kills", "_shots"];
			
			enableSaving [true, true];	
			saveGame;
			
			// script
		},
		nil,		// arguments
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
		
_building addAction

	[
		"Recruit Unit",	// title
		{
			params ["_target", "_caller", "_actionId", "_arguments"];
			
			_map = playerMap get (name _caller);
			_map params ["_tickets", "_points", "_money", "_roster", "_claims", "_kills", "_shots"];
			
			if ((count (units (group _caller))) < 6)
				
				then {
					
					onHand = [onHand, [], { _caller distance (getPos _x) }, "ASCEND"] call BIS_fnc_sortBy;
					
					_a = [];
					
					{
						
						if (_x in (units (group _caller)))
							
							then {}
								
								else {
									
									if (_x == (leader (group _x)))
										
										then {
											
											_a = _a + [_x];
								
											};
										
									};
							
						} forEach onHand;
					
					sleep 0.1;
					
					if ((count _a) == 0)
						
						then {hint "No Units available!"}
							
							else {
								
								if ((_a select 0) in onHand)
									
									then {
										
										[(_a select 0)] join _caller;
										
										null = [(_a select 0)] execVM "System\doodman.sqf";
										
										}
										
										else {
											
											hint "No Units available!"
											
											};
										
								};
						
					}
					
					else {hint "You can only have 6 units per team!"};
					
			// script
		},
		nil,		// arguments
		1.3,		// priority
		true,		// showWindow
		true,		// hideOnUse
		"",			// shortcut
		"True", 	// condition
		3,			// radius
		false,		// unconscious
		"",			// selection
		""			// memoryPoint
		
		];
		
_building addAction

	[
		"Hire Guards",	// title
		
		{
			params ["_target", "_caller", "_actionId", "_arguments"];
			
			_map = playerMap get (name _caller);
			_map params ["_tickets", "_points", "_money", "_roster", "_claims", "_kills", "_shots"];
			
			if ((_money >= 2500) and ((count _roster)<= (count registeredLand) * 4))
				
				then {
					
					_bc = [_target] call BIS_fnc_buildingPositions;
					_pos = selectRandom _bc;
					_dood = [_pos, 0] call mySp;
					
					sleep 0.1;
					
					_arguments = _arguments + [_dood];
					_dood setPosATL _pos;
					_roster = _roster + [_dood];
					
					addSwitchableUnit _dood;
					
					null = [_dood, _target, _caller] execVM "System\guards.sqf";
					
					_wp = (group _dood) addWaypoint [_pos, 0];
					_wp setWaypointType "GUARD";
					
					_playerMap = [_tickets, _points, (_money - 2500), _roster + [_dood], _claims, _kills, _shots];
					playerMap set [(name _caller), _playerMap];
					propertyMap set [(name _target), _arguments];
					
					onHand = onHand + (units (group _dood));
			
					}
					
					else {
						
						if (_money < 2500)
							
							then {hint "Not enough money! Guards cost $2500."};
							
						if ((count _roster) >= ((count registeredLand) * 4))
							
							then {hint "Roster full! Claim more buildings for more roster slots."};
							
						};
	
			// script
		},
		_staff,		// arguments
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
		
while {(damage _building < 0.9)}
	
	do {
		
		//hint format ["%1", (damage _building)];
		
		waitUntil {(damage _building) > 9};
		
		};
		
hint "BOOM";