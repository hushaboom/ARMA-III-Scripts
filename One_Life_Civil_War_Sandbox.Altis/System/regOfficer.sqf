_guy = _this select 0;

grecop addAction

	[
		"Tickets - Cash",	// title
		
		{
			params ["_target", "_caller", "_actionId", "_arguments"];
			
			_map = playerMap get (name _caller);
			_map params ["_tickets", "_points", "_money", "_roster", "_claims", "_kills", "_shots"];
			
			if (_money < 10000)
				
				then {hint format ["Not enough Money!  Claim tickets cost $10,000.  You have $%1", _money]}
				
					else {
						
						_playerMap = [(_tickets + 1), _points, (_money - 10000), _roster, _claims, _kills, _shots];
						playerMap set [(name _caller), _playerMap];
						
						postIt = 1;
						
						hint format ["You have $%1 Tickets", _tickets];

						};
					
			// script
		},
		nil,		// arguments
		1.5,		// priority
		true,		// showWindow
		true,		// hideOnUse
		"",			// shortcut
		"True", 	// condition
		3,			// radius
		false,		// unconscious
		"",			// selection
		""			// memoryPoint
		
		];
		
grecop addAction

	[
		"Tickets - SP",	// title
		
		{
			params ["_target", "_caller", "_actionId", "_arguments"];
			
			_map = playerMap get (name _caller);
			_map params ["_tickets", "_points", "_money", "_roster", "_claims", "_kills", "_shots"];
			
			if (_points < 10)
				
				then {hint "Not enough Points!"}
				
					else {
						
						_playerMap = [_tickets + 1, _points - 10, _money, _roster, _claims, _kills, _shots];
						playerMap set [(name _caller), _playerMap];
						
						postIt = 1;
						
						hint format ["You have $%1 Tickets", _tickets];
						
						};
					
			// script
		},
		nil,		// arguments
		1.5,		// priority
		true,		// showWindow
		true,		// hideOnUse
		"",			// shortcut
		"True", 	// condition
		3,			// radius
		false,		// unconscious
		"",			// selection
		""			// memoryPoint
		
		];
		
