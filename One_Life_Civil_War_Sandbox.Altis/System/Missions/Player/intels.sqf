_guy = _this select 0;
_intel = _this selct 1;

if (_intel == "Land_Wallet_01_F")
	
	then {
		
		if ((floor (random 100)) < 25)
			
			then {
			
			while {true}
				
				do {
					
					 _stuff = (backpackItems _guy) + ( uniformItems _guy) + (vestItems _guy);
					 
					if ((typeOf _intel) in _stuff)
						
						exitWith {
							
							_playerMap = playerMap get (name _guy);
							_playerMap params ["_tickets", "_points", "_money", "_roster", "_claims", "_kills", "_shots"];
	
							_cash = (floor (random 1000));
							_txt0 = format ["You found $%1!<br></br>", _cash];
							_money = _money + _cash;
							
							if ((floor (random 12)) in [7,11])
								
								then {
									
									_txt0 = _txt0 + "You found a claim ticket!";
									_tickets = _tickets + 1;
									
									};
								
							hint parseText _txt0;
							
							_playerMap = [_tickets, _points, _money, _roster, _claims, _kills, _shots];
							playerMap set [(name _guy), _playerMap];
						
							postIt = 1;
							
							};
						
					};
				
			};
			
		}
		
		else {
			
			while {true}
				
				do {
					
					 _stuff = (backpackItems _guy) + ( uniformItems _guy) + (vestItems _guy);
					 
					if (_intel in _stuff)
						
						exitWith {
							
							hint "Nothing yet";
							
							};
						
					};
			
			};
		
