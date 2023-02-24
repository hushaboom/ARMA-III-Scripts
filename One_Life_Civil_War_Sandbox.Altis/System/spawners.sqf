_guy = _this select 0;

mySp = {
	
	params ["_pos", "_count"];
	private ["_unit", "_array", "_tl"];
	
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
			
			if (_i == 0)
				
				then {
					
					_tl = ["I_C_Soldier_Para_7_F", "I_G_Soldier_TL_F", "I_G_Officer_F", "I_G_Soldier_SL_F"];
					_unit = _pg createUnit [(selectRandom _tl), [_pos, 3, 50, 1, 0, 3, 0, [], []] call BIS_fnc_findSafePos, [], AISkillNum, "FORM"];
					
					}
					
					else {
						
						_form = (_array select _ct);
						
						while {_form in _tl}
							
							do {_form = (_array select _ct);};
							
						_unit = _pg createUnit [_form, [_pos, 3, 50, 1, 0, 3, 0, [], []] call BIS_fnc_findSafePos, [], AISkillNum, "FORM"];
			
						};
						
			onHand = onHand + [_unit];
			
			//null = [_unit] execVM "System\Player\playerInit.sqf";
			null = [_unit] execVM "System\switcher.sqf";
			
			playerMap set [(name _unit), [1, 0, 2500, [], [], [0,0],0]];
			
			_unit addEventHandler ["Killed", {
			
			
				params ["_unit", "_killer"];
				
				if ((name _killer) == (name player))
					
					then {
						
						hint "PID YOUR TARGETS!";
						
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
						_playerMap params ["_tickets", "_points", "_money", "_roster", "_claims", "_kills", "_shots"];;
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
	
	_array = SYNArray;
	
	if ((count registeredLand) > 12) then {_array = SYNArray + FIAArray_INDEPENDENT};
	if ((count registeredLand) > 35) then {_array = AAFArray};
	if ((count registeredLand) > 50) then {_array = AAFArray + CTRGArray};
	
	_pg = createGroup independent;
	
	for "_i" from 0 to (_count)
		
		do {
			
			_ct = random (count _array) - 1;
			if (_ct < 1) then {_ct = 0};
			
			if (_i == 0)
				
				then {
					
					_tl = ["I_C_Soldier_Para_7_F", "I_G_Soldier_TL_F", "I_G_Officer_F", "I_G_Soldier_SL_F"];
					_unit = _pg createUnit [(selectRandom _tl), [_pos, 3, 50, 1, 0, 3, 0, [], []] call BIS_fnc_findSafePos, [], AISkillNum, "FORM"];
					
					}
					
					else {
						
						_form = (_array select _ct);
						
						while {_form in _tl}
							
							do {_form = (_array select _ct);};
							
						_unit = _pg createUnit [_form, [_pos, 3, 50, 1, 0, 3, 0, [], []] call BIS_fnc_findSafePos, [], AISkillNum, "FORM"];
			
						};
			
			onHand = onHand + [_unit];
			
			//playerMap set [(name _unit), [1, 0, 2500, [], [], [0,0],0]];
			//null = [_unit] execVM "System\Player\playerInit.sqf";
			
			_unit addEventHandler ["Killed", {
			
				params ["_unit", "_killer"];
				
				if ((name _killer) == (name player))
					
					then {
						
						hint "PID YOUR TARGETS!";
						
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
			
			//playerMap set [(name _unit), [1, 0, 2500, [], [], [0,0],0]];
			//null = [_unit] execVM "System\Player\playerInit.sqf";
			
			_unit addEventHandler ["Killed", {
			
				params ["_unit", "_killer"];
				
				if ((name _killer) == (name player))
					
					then {
						
						hint "PID YOUR TARGETS!";
						
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
