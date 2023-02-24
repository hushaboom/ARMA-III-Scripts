_guy = player;



hint "The GLG20's, are alive and under heavy fire in Downtown Pyrgos.";

_reg = [_guy,"SLU",["Link up with the GLG20's trapped in Downtown Pyrgos, and lend assistance.",
		"Spies Like Us.","Defend"],[16788.2,12717.1,0],1,2,true,"Defend",false] call BIS_fnc_taskCreate;
		
		{
		_x addAction

			[
				"Join Us",	// title
				{
					params ["_target", "_caller", "_actionId", "_arguments"];
					
					_map = playerMap get (name _caller);
					_map params ["_tickets", "_points", "_money", "_roster", "_claims", "_kills", "_shots"];
					
					[_caller] join glg20;
					
					GLG20Mission = 1;
					
					// script
				},
				nil,		// arguments
				1,		// priority
				true,		// showWindow
				true,		// hideOnUse
				"",			// shortcut
				"True", 	// condition
				3,			// radius
				false,		// unconscious
				"",			// selection
				""			// memoryPoint
				
				];
			
			} forEach (units glg20);
	
waitUntil {GLG20Mission == 1};

{removeAllActions _x} forEach (units glg20);

[_reg,"SUCCEEDED",true] spawn BIS_fnc_taskSetState;

sleep 2;

while {(count (waypoints glg20))) > 0} do {
				
	deleteWaypoint ((waypoints glg20) select 0);

	};

_reg = [_guy,"SLU0",["Find the missing GLG20's",
		"The Other Guys","Defend"],nil,1,2,true,"Defend",false] call BIS_fnc_taskCreate;

_path = [[16828.6,12664.1,0], [17280,12380.8,0], [17194.6,11754,0]];

while {(count (waypoints glg20))) > 0} do {
				
	deleteWaypoint ((waypoints glg20) select 0);

	};

{
	
	_wp = glg20 addWaypoint [_x, 1];
	_wp setWaypointType "MOVE";
	_wp setWaypointBehaviour "AWARE";
	
	} forEach _path;
	
_wp = glg20 addWaypoint [(getPos chevy), 1];
_wp setWaypointType "MOVE";
_wp setWaypointBehaviour "AWARE";

waitUntil {glg20a distance chevy < 20};

[_reg,"SUCCEEDED",true] spawn BIS_fnc_taskSetState;

sleep 4.6;

{_x allowDamage true} forEach units glg20;

hint "Help the decoy's escape to Athira.";

_reg = [_guy,"SLU1",["These idiots are the decoys..  They weren't supposed to make it TBH..  Better escort them back to Athira for debrief.",
		"The Decoys","Defend"],(getPos grecop),1,2,true,"Defend",false] call BIS_fnc_taskCreate;

sleep 1.6;
[_guy] join grpNull;
[chevy, dan] join (group _guy);

waitUntil {regOn == 0.5};

if ((alive chevy) and (alive dan))
	
	then {
		
		[_reg,"SUCCEEDED",true] spawn BIS_fnc_taskSetState;
		hint "We really didn't care if these men survived, but you did a great job.  Here's 20 skill points and $15,000 for your trouble.";
		
		_guyMap = playerMap get (name _guy);
		_guyMap params ["_tickets", "_points", "_money", "_roster", "_claims", "_kills", "_shots"];
			
		_playerMap = [_tickets + 20, _points, _money + 15000, _roster, _claims, _kills, _shots];
		playerMap set [(name _guy), _playerMap];
	
		postIt = 1;
		
		}
		
		else {
			
			[_reg,"CANCELED",true] spawn BIS_fnc_taskSetState;
			
			hint "One or both decoys didn't make it aparently.  Really, we care about these men and will certainly think about contacting their families..  "
			
			};