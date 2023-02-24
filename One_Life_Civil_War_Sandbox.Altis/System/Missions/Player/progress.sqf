_guy = _this select 0;

waitUntil {!alive TJ};

sleep 5;

if ((baseOn == 0) and (isPlayer _guy))
	
	then {
	
		hint "You have been awarded 10 Skill Points!";

		_myMap = playerMap get (name _guy);
		_myMap params ["_tickets", "_points", "_money", "_roster", "_claims", "_kills", "_shots"];

		playerMap set [(name _guy), [_tickets, _points + 10, _money, _roster, _claims, _kills, _shots]];

		postIt = 1;
	
		sleep 5;
		
		_reg = [_guy,"RTB",["Return to Athira and find a home for yourself.  Claim a builing near the city, then proceed to the Athira Registrar to register your claim.",
		"Claim a home Near Athira","Defend"],(getPos grecop),1,2,true,"Defend",false] call BIS_fnc_taskCreate;

		waitUntil {baseOn == 1};
		
		hint "Claim a building to be your home.";
		
		[_reg,"SUCCEEDED",true] spawn BIS_fnc_taskSetState;
		regOn = 0.5;
		sleep 3;

		sleep 8;
		
		};

sleep 1;

waitUntil {(count registeredLand) > 2};

sleep 15;

_reg1 = [_guy,"Grow",["Claim more buildings and continue building your army..","Expand your Roster","Attack"],nil,3,2,true,"Attack",false] call BIS_fnc_taskCreate;

waitUntil {(count registeredLand > 15)};

[_reg1,"SUCCEEDED",true] spawn BIS_fnc_taskSetState;

sleep 0.5;

hint "You've been awarded 25 Skill Points!";

_myMap = playerMap get (name _guy);
_myMap params ["_tickets", "_points", "_money", "_roster", "_claims", "_kills", "_shots"];

playerMap set [(name _guy), [_tickets, _points + 25, _money, _roster, _claims, _kills, _shots]];

postIt = 1;

