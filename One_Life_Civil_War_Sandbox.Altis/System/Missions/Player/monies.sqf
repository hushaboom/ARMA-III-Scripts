
_loot = _this select 0;
_guy = _this select 1;

private _pos = getPos _loot;

 _stuff = (backpackItems _guy) + ( uniformItems _guy) + (vestItems _guy);

while {true}
				
	do {
		
		 _stuff = (backpackItems _guy) + ( uniformItems _guy) + (vestItems _guy);
		 
		if (!alive _loot)
			
			exitWith {

				if  (_guy distance _pos < 5)
					
					then {
							
						_cash = (floor (random 10000)) + (floor (random 1000)) + (floor (random 100)) + (floor (random 10));
						hint format ["You found $%1!", _cash];

						_playerMap = playerMap get (name _guy);
						_playerMap params ["_tickets", "_points", "_money", "_roster", "_claims", "_kills", "_shots"];

						_money = _money + _cash;

						_playerMap = [_tickets, _points, _money, _roster, _claims, _kills, _shots];
						playerMap set [(name _guy), _playerMap];

						postIt = 1;
						
						};
						
				};
		
		sleep 0.2;
		
		};