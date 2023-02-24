_guy = player;

tutorialCue = 0;

removeAllActions _guy;

while {(count (waypoints (group _guy))) > 0} do {
					
	deleteWaypoint ((waypoints (group _guy)) select 0);

	};

if (vx < 140)
	
	then {
			
		null = [_guy] execVM "System\populate.sqf";
		sleep 0.1;
		null = [_guy] execVM "System\Missions\Player\progress.sqf";
		sleep 0.1;	
		null = [_guy] execVM "System\spawners.sqf";
		sleep 0.1;
		null = [_guy] execVM "System\Player\playerMon.sqf";
		sleep 0.1;
		null = [_guy] execVM "System\Missions\Player\outPosts.sqf";
		sleep 0.1;
		
		};



	_guy addEventHandler ["Killed", {
			
				params ["_unit", "_killer"];
				
				_myMap = playerMap get (name _unit);
				_myMap params ["_tickets", "_points", "_money", "_roster", "_claims", "_kills", "_shots"];
				
				if ((count _roster) == 0)
					
					exitWith {
					
						"end2" call BIS_fnc_endMission;
						forceEnd;
						
						};
					
				{
					
					if ((!alive _x) and (_x in onHand))
						
						then {
							
							_roster deleteAt (_roster find _x);
							onHand deleteAt (onHand find _x);
							
							}
								
								else {
								
									_pg = createGroup independent;
									_place = selectRandom registeredLand;
									_unit = _pg createUnit [(typeOf _x), [(getPos _place), 1, 3, 1, 0, 3, 0, [], []] call BIS_fnc_findSafePos, [], AISkillNum+0.2, "FORM"];
									addSwitchableUnit _unit;
									
									null = [_unit, (getPos _place), (getPos _place), 0, 6 + (random 6)] execVM "System\Generators\wpgen.sqf";
									
									while {(count (waypoints (group _unit))) > 0} do {
													
										deleteWaypoint ((waypoints (group _unit)) select 0);
									
										};
									};
								
					} forEach _roster;
				
				{
					
					if (_x == (leader(group _x)))
						
						then {
							
							addSwitchableUnit _x;
							players = players + [_x];
							
							}
							
							else {
								
								
								};
					
					} forEach onHand;
				
				vx = 160;
				
				}];

if (_guy == player)
				
	then {
	
		_guy addEventHandler ["FiredMan", {

			params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_vehicle"];
			
			_myMap = playerMap get (name _unit);
			_myMap params ["_tickets", "_points", "_money", "_roster", "_claims", "_kills", "_shots"];
			
			playerMap set [(name _unit), [_tickets, _points, _money, _roster, _claims, _kills, _shots + 1]];
			
			postIt = 1;
			
			
			
			}];
			
		null = [_guy, []] execVM "Loot\loot_tier_0.sqf";

		};
	
		
while {(alive _guy) and (isPlayer _guy)} 

	do {
	
		while {(count (waypoints (group _guy))) > 0} do {
													
			deleteWaypoint ((waypoints (group _guy)) select 0);
		
			};
	
	{
		_myMap = playerMap get (name _guy);
		_myMap params ["_tickets", "_points", "_money", "_roster", "_claims", "_kills", "_shots"];
		
		if ((_x in _roster) and (!alive _x) and (_x in allUnits))
			
			then {
				
				_roster deleteAt (_roster find _x);
				onHand deleteAt (onHand find _x);
				
				playerMap set [(name _guy), [_tickets, _points, _money, _roster, _claims, _kills, _shots]];
		
				postIt = 1;
		
				};
			
		} forEach onHand;
		
	_myMap = playerMap get (name _guy);
	_myMap params ["_tickets", "_points", "_money", "_roster", "_claims", "_kills", "_shots"];
	_kills params ["_eny", "_frn"];
	
	sleep 0.1;
	
	_lc = 0;
	
	if (baseOn == 1)
		
		then {_lc = (count registeredLand)};
	
	_statTable = [
		
		["Claim Tickets ", _tickets], ["Friendly Kills", _frn], ["Enemy Kills   ", _eny],
		["Shots Fired   ", _shots], ["Skill Points  ", _points], 
		["Property        ", _lc],["Money         ", _money], ["Reserves         ", (count _roster)]
		
		];
	
	_guy removeDiarySubject "stats";
	_guy removeDiarySubject "Enemy";
	
	_index1 = _guy createDiarySubject ["stats","Player Info"];
	_index2 = _guy createDiarySubject ["Enemy","Enemy Force Count"];
	
	_out = "";
	
	{
		_x params ["_key", "_value"];
		_spc = "";

		for "_i" from 0 to floor ((34 - (count _key))/2)
			
			do {_spc = _spc + " "};
		
		_txt = format ["%1 %3 - %3 %2<br></br>", _key, _value, _spc];
		_out = _out + _txt;
		
		} forEach _statTable;
		
	_txt0 = (format ["Red - %1<br></br>Blue - %2", redForce, bluForce]);
	
	_guy createDiaryRecord ["Enemy", ["Enemy Force Count", _txt0]];
	_guy createDiaryRecord ["stats", ["Player Info", _out]];

	waitUntil {postIt == 1};
	
	postIt = 0;
	
	{
		
		if (_x != player)
			
			then {
				
				players deleteAt (players find _x);
				
				};
		
		} forEach players;
	
	if (((w == 5) and (!alive Cardinal) and (!alive redcop)) or ((!alive TJ) and (redForce < (650 - (650*0.9)))))
		
		exitWith {
			
			sleep 1.4;
			w = 4;
			
			};
		
	};
	
