_guy = _this select 0;

_startTime = (floor dayTime) + 1;

while {alive _guy} do {
	
	_playerMap = playerMap get (name _guy);
	_playerMap params ["_tickets", "_points", "_money", "_roster", "_claims", "_kills", "_shots"];
	
	if (docOn == 1)
		
		then {
			
			{
				
				if (((side _x) == independent) or ((side _x) == civilian))
					
					then {_x setDamage 0};
					
				} forEach allUnits;
			
			};
	
	if ((_startTime + 1) < dayTime)
		
		then {
			
			postIt = 1;
			sleep 0.2;
			
			_payCount = (count _roster) + (count (units (group _guy)) - 1);
			_startTime = _startTime + 1;
			
			_pay = _payCount * 100;
			
			if (_money > 0)
				
				then {
						
					_txt0 = format ["$%1 has been paid in wages.", _pay];
					_txt1 = format ["<br></br>Your doctor has finished his rounds.  All units restored to 100% health."];
					
					if (docOn == 1)
						
						then {
							
							hint parseText (format ["%1%2", _txt0, _txt1]);
							
							{
								
								if ((side _x) in [independent, civilian])
									
									then {_x setDamage 0};
									
								} forEach allUnits;
							
							}
							
							else {
							
								hint _txt0;
								
								};
					
					};
					
			sleep 0.1;
			_money = _money - _pay;
			
			if (_money < 01)
		
				then {
					
					payUp = payUp + 1;
					
					sleep 1;
					} 
					
					else {
						
						if (payUp > 0)
							
							then {payUp = payUp - 1};
							
						};

			if (payUp == 1)
				
				then {
					
					hint "You have no money to pay your staff!";
					
					};
					
				if (payUp == 3)
				
				then {
					
					_txt0 = format ["You have $%1 in you account, and haven't paid your staff in 3 pay periods.",_money];
						
						"Pay Up" hintC [
							
							_txt0,
							"Earn money NOW, and pay you men. They are getting angry, and will revolt."
							
							];
					
					};
				
			if (payUp == 5)
			
				then {
					
					_txt0 = "Fine.";
					
					breakWith "
					
						vx = -200000000000000000000000000000000000000;
						hint _txt0;
						_guy addRating vx;
						
						"
						
					};
			
			
			_playerMap = [_tickets, _points, _money, _roster, _claims, _kills, _shots];
			playerMap set [(name _guy), _playerMap];
		
			postIt = 1;
			
			waitUntil {dayTime >= _startTime};
			
			};
		
	sleep 0.05;
	
	
			
	};
	
if (vx < 0)
	
	then {
		
		_reg = [_guy,"Game Over",["You didn't pay your men.  You lose.","Game Over","Attack"],getpos _guy,3,2,true,"Attack",false] call BIS_fnc_taskCreate;
		registeredLand = buildings;
		AISkillNum = 1;
		
		{
			
			_dood = [(getPos _x), 3] call mySp;
			null = [_dood, (getPos _guy), (getPos _guy), 1, 5] execVM "System\Generators\wpgen.sqf";
							
			} forEach doods;
		
		while {alive _guy}
			
			do {
				
				_pos = getPos _guy;
				
				waitUntil {(getPos _guy) distance _pos > 200};
				
				[_reg,(getPos _guy)] call BIS_fnc_taskSetDestination;
				
				{
					
					if ((side _x) == independent)
						
						then {
						
							while {(count (waypoints (group _x))) > 0} do {
								
								deleteWaypoint ((waypoints (group _x)) select 0);
							
								};
							
							sleep 0.1;
							
							null = [_x, (getPos _guy), (getPos _guy), 1, 5] execVM "System\Generators\wpgen.sqf";
			
							
							};
						
					} forEach allUnits;
					
				hintSilent "You can run...";
					
				};
			
		};

"end5" call BIS_fnc_endMission;
forceEnd;