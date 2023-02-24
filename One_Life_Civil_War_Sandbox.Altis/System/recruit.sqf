_guy = _this select 0;

_guy addAction

	[
		"Recruit",	// title
		{
			params ["_target", "_caller", "_actionId", "_arguments"];
			
			_map = playerMap get (name _caller);
			_map params ["_tickets", "_points", "_money", "_roster", "_claims", "_kills", "_shots"];
			
			if (((count _roster) < ((count registeredLand) - (count warehouses)) * 4) or (_target in onHand) or (_target in specialDoods))
				
				then {

					_roster = _roster + [_target];
					_target removeAction _actionId;
					[_target] join _caller;
					
					_map = [_tickets, _points, _money, _roster, _claims, _kills, _shots];
			
					playerMap set [(name _caller), _map];
					
					postIt = 1;
			
					} 
					
					else {
						
						hint "Not enough buildings! Claim more to recruit!";
						
						};
					
			// script
		},
		nil,		// arguments
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
		