_guy = _this select 0;

if (_guy in (units (group player)))
	
	then {
				
		_guy addAction

			[
				"Retire",	// title
				{
					params ["_target", "_caller", "_actionId", "_arguments"];
					
					_map = playerMap get (name _caller);
					_map params ["_tickets", "_points", "_money", "_roster", "_claims", "_kills", "_shots"];
					
					if (alive _target)
						
						then {
							
							if (_target in _roster)
								
								then {}
									
									else {
									
										_roster = _roster + [_target];
										
										};
										
							_target removeAction _actionId;
							[_target] join grpnull;
							null = [_target] execVM "System\doodman.sqf";
							_map = [_tickets, _points, _money, _roster, _claims, _kills, _shots];

							playerMap set [(name _caller), _map];
							
							portIt = 1;
							
							_b = selectRandom _claims;
							_bPos = getPos (_b select 0);
							
							_wp = (group _target) addWaypoint [(getPos _target), 0];
							_wp setWaypointType "HOLD";
							_wp setWaypointCombatMode "RED";
							_wp setWaypointBehaviour "COMBAT";
						
							addSwitchableUnit _target;
							
							} else {
								
								if (_target in _roster)
								
									then {
									
										_roster deleteAt (_roster find _target);
										removeAllActions _target;
										
										};
								
								};
						
					postIt = 1;
			
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
			
		} else {
		
			if (count (units player) >= 6)
				
				then {hint "You can only have 6 units in your team"}
					
					else {
								
						_guy addAction

							[
								"Recruit",	// title
								{
									params ["_target", "_caller", "_actionId", "_arguments"];
									
									_map = playerMap get (name _caller);
									_map params ["_tickets", "_points", "_money", "_roster", "_claims", "_kills", "_shots"];
									
									while {(count (waypoints (group _target))) > 0} do {
		
										deleteWaypoint ((waypoints (group _target)) select 0);
										
										};

									_roster = _roster + [_target];
									_target removeAction _actionId;
									[_target] join _caller;
									null = [_target] execVM "System\doodman.sqf";
									_map = [_tickets, _points, _money, _roster, _claims, _kills, _shots];

									playerMap set [(name _caller), _map];
									
									removeSwitchableUnit _target;
									
									postIt = 1;
							
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
							};
							
			};