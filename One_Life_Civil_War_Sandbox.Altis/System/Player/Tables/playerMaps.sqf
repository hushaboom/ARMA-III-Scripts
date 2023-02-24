/*
	Manages/creates Hashmaps for tracking player progress.
	Keeps track of points, team, money, property, etc.  Everything the player collects gets 
	recorded here.
	
*/

_guy = _this select 0;

if ((name _guy) in keys playerMap) 
	
	then {}
		
		else {
			
			_claims = [];
			
			playerMap set [(name _guy), [1, 0, 1500, [(name _guy)], _claims, [0,0],0]];
	
			};

_myMap = playerMap get (name _guy);
_myMap params ["_tickets", "_points", "_money", "_roster", "_claims", "_kills", "_shots"];
	_kills params ["_eny", "_frn"];

null = [_guy] execVM "System\Player\playerInit.sqf";