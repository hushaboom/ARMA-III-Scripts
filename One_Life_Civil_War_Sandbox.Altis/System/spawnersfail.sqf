_guy = _this select 0;

mySp = {
	
	params ["_pos", "_count"];
	private ["_unit", "_array"];
	
	_pg = createGroup independent;
	
	_array = SYNArray;
	
	if ((count registeredLand) > 12) then {_array = SYNArray + FIAArray_INDEPENDENT};
	if ((count registeredLand) > 35) then {_array = AAFArray};
	if ((count registeredLand) > 50) then {_array = AAFArray + CTRGArray};
	
	AISkillNum = AISkillNum + 0.2;
	
	for "_i" from 0 to (_count)
		
		do {
			
			_ct = random (count _array) - 1;
			if (_ct < 1) then {_ct = 0};
			_unit = _pg createUnit [(_array select _ct), [_pos, 3, 50, 1, 0, 3, 0, [], []] call BIS_fnc_findSafePos, [], AISkillNum, "FORM"];
			onHand = onHand + [_unit];
			
			_playerMap = playerMap get (name _guy);
			_playerMap params ["_tickets", "_points", "_money", "_roster", "_claims", "_kills", "_shots"];
	
			if ((count _roster) < ((count registeredLand)*4))
				
				then {
						
					_roster = _roster + [_unit];
					
					};
					
			null = [_unit] execVM "System\switcher.sqf";
			
			_unit addEventHandler ["Killed", {
			
				params ["_unit", "_killer"];
				
				if ((name _killer) == (name player))
					
					then {
						
						hint "PID YOUR DAMN TARGETS!";
						
						_playerMap = playerMap get (name _killer);
						_playerMap params ["_tickets", "_points", "_money", "_roster", "_claims", "_kills", "_shots"];;
						_kills params ["_eny", "_frn"];
						
						_playerMap = [_tickets, _points - 10, _money, _roster, _claims, [_eny, _frn + 1], _shots];
						playerMap set [(name _killer), _playerMap];
						
						killcount = killcount + 1;
						
						postIt = 1;
						
						};
					
				}];
				
			};
			
			AISkillNum = AISkillNum - 0.2;
			
		(leader group _unit);
	};

blueSp = {
	
	params ["_pos", "_count"];
	private ["_unit"];
	
	_pg = createGroup west;
	
	for "_i" from 0 to (_count)
		
		do {
			
			_ct = random (count FIAArray_WEST) - 1;
			if (_ct < 1) then {_ct = 0};
			_unit = _pg createUnit [(FIAArray_WEST select _ct), [_pos, 3, 50, 1, 0, 3, 0, [], []] call BIS_fnc_findSafePos, [], random AISkillNum, "FORM"];
			doods = doods + [_unit];
			removeHeadgear _unit;
		
			_unit addEventHandler ["Killed", {
			
				params ["_unit", "_killer"];
				
				bluForce = bluForce - 1;
				
				if ((name _killer) == (name player))
					
					then {
						
						_playerMap = playerMap get (name _killer);
						_playerMap params ["_tickets", "_points", "_money", "_roster", "_claims", "_kills", "_shots"];
						_kills params ["_eny", "_frn"];
						
						_playerMap = [_tickets, _points + 1, _money, _roster, _claims, [_eny + 1, _frn], _shots];
						
						playerMap set [(name _killer), _playerMap];
						
						killcount = killcount + 1;
						
						postIt = 1;
						
						};
					
				}];
				
			_unit addHeadgear "Headgear_H_PASGT_basic_white_F";
			
			};
			
		(leader group _unit)
	};

greenSp = {
	
	params ["_pos", "_count"];
	private ["_unit"];
	
	_pg = createGroup independent;
	
	for "_i" from 0 to (_count)
		
		do {
			
			_ct = random (count (SYNArray + FIAArray_INDEPENDENT)) - 1;
			if (_ct < 1) then {_ct = 0};
			_unit = _pg createUnit [((SYNArray + FIAArray_INDEPENDENT) select _ct), [_pos, 3, 50, 1, 0, 3, 0, [], []] call BIS_fnc_findSafePos, [], random AISkillNum, "FORM"];
			onHand = onHand + [_unit];
			
			_unit addEventHandler ["Killed", {
			
				params ["_unit", "_killer"];
				
				if ((name _killer) == (name player))
					
					then {
						
						hint "PID YOUR DAMN TARGETS!";
						
						_playerMap = playerMap get (name _killer);
						_playerMap params ["_tickets", "_points", "_money", "_roster", "_claims", "_kills", "_shots"];;
						_kills params ["_eny", "_frn"];
						
						_playerMap = [_tickets, _points - 10, _money, _roster, _claims, [_eny, _frn + 1], _shots];
						playerMap set [(name _killer), _playerMap];
						
						killcount = killcount + 1;
						
						postIt = 1;
						
						};
					
				}];
				
			};
			
		(leader group _unit);
	};

redSp = {
	
	params ["_pos", "_count"];
	private ["_unit", "_pg"];
	
	_pg = createGroup east;
	
	for "_i" from 0 to (_count)
		
		do {
			
			_ct = random (count FIAArray_EAST) - 1;
			if (_ct < 1) then {_ct = 1};
			_unit = _pg createUnit [(FIAArray_EAST  select _ct), [_pos, 3, 50, 1, 0, 3, 0, [], []] call BIS_fnc_findSafePos, [], random AISkillNum, "FORM"];
			doods = doods + [_unit];
			removeHeadgear _unit;
			
			_unit addEventHandler ["Killed", {
			
				params ["_unit", "_killer"];
				
				redForce = redForce - 1;
				
				if ((name _killer) == (name player))
					
					then {
						
						_playerMap = playerMap get (name _killer);
						_playerMap params ["_tickets", "_points", "_money", "_roster", "_claims", "_kills", "_shots"];;
						_kills params ["_eny", "_frn"];
						
						_playerMap = [_tickets, _points + 1, _money, _roster, _claims, [_eny + 1, _frn], _shots];
						
						playerMap set [(name _killer), _playerMap];
						
						killcount = killcount + 1;
						
						redForce = redForce - 1;
						
						postIt = 1;
						
						};
					
				}];
				
			_unit addHeadgear "Headgear_H_PASGT_basic_white_F";
				 
			};
			
		(leader group _unit);
	};

civSp = {
	
	params ["_pos", "_count"];
	private ["_unit"];
	
	_pg = createGroup civilian;
	
	for "_i" from 0 to (_count)
		
		do {
			
			_ct = random (count CIVArray) - 1;
			if (_ct < 1) then {_ct = 0};
			_unit = _pg createUnit [(CIVArray  select _ct), [_pos, 3, 50, 1, 0, 3, 0, [], []] call BIS_fnc_findSafePos, [], random AISkillNum, "FORM"];
			doods = doods + [_unit];
			
			_unit addEventHandler ["Killed", {
			
				params ["_unit", "_killer"];
				
				if ((name _killer) == (name player))
					
					then {
						
						hint "PID YOUR DAMN TARGETS!";
						
						_playerMap = playerMap get (name _killer);
						_playerMap params ["_tickets", "_points", "_money", "_roster", "_claims", "_kills", "_shots"];;
						_kills params ["_eny", "_frn"];
						
						_playerMap = [_tickets, _points - 25, _money, _roster, _claims, [_eny, _frn + 1], _shots];
						playerMap set [(name _killer), _playerMap];
						
						postIt = 1;
						
						};

				}];
				 
			};
			
		(leader group _unit);
	};
