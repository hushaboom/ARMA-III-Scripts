_clinic = _this select 0;

_clinic addAction

	[
		"Jobs",	// title
		{
			params ["_target", "_caller", "_actionId", "_arguments"];
			
			null = [_caller, _target] execVM "System\Missions\Player\medicalWork.sqf";
			
			//hint "No jobs available at this time.";
	
			// script
		},
		nil,		// arguments
		5,		// priority
		true,		// showWindow
		true,		// hideOnUse
		"",			// shortcut
		"meds == 0", 	// condition
		12,			// radius
		false,		// unconscious
		"",			// selection
		""			// memoryPoint
		
		];
		
_clinic addAction

	[
		"Recruit EMT",	// title
		{
			params ["_target", "_caller", "_actionId", "_arguments"];
			
			_map = playerMap get (name _caller);
			_map params ["_tickets", "_points", "_money", "_roster", "_claims", "_kills", "_shots"];
			
			if (((count _roster) < ((count registeredLand) - (count warehouses)) * 4) and ((count (units (group _caller)) < 6)))
				
				then {
					
					_unit = (group _caller) createUnit ["C_Man_Paramedic_01_F", [(getPos _target), 25, 50, 1, 0, 3, 0, [], []] call BIS_fnc_findSafePos, [], AISkillNum, "FORM"];
					onHand = onHand + [_unit];
					
					_playerMap = [_tickets, _points, _money, _roster + [_unit], _claims, _kills, _shots];
					playerMap set [(name _caller), _playerMap];
					
					postIt = 1;
					
					}
						
						else {hint "Your Roster is full!  Register more buildings!"};
	
			// script
		},
		nil,		// arguments
		4,		// priority
		true,		// showWindow
		true,		// hideOnUse
		"",			// shortcut
		"True", 	// condition
		12,			// radius
		false,		// unconscious
		"",			// selection
		""			// memoryPoint
		
		];
		
_clinic addAction

	[
		"Hire Doctor",	// title
		{
			params ["_target", "_caller", "_actionId", "_arguments"];
			
			_map = playerMap get (name _caller);
			_map params ["_tickets", "_points", "_money", "_roster", "_claims", "_kills", "_shots"];
			
			if (_money >= 105000)
				
				then {
					
					_pg = createGroup civilian;
					_unit = _pg createUnit ["C_Man_formal_4_F_tanoan", [(getPos _target), 5, 10, 1, 0, 3, 0, [], []] call BIS_fnc_findSafePos, [], AISkillNum, "FORM"];
					
					_bPos = [_target] call BIS_fnc_buildingPositions;
					_unit setPosATL (_bPos select ((count _bPos) - 4));
					
					_money = _money - 105000;
					
					_playerMap = [_tickets, _points, _money, _roster + [_unit], _claims, _kills, _shots];
					playerMap set [(name _caller), _playerMap];
					
					postIt = 1;
					
					hint "Athira now has a resident physician.  
						Your Doctor will do his rounds every hour, 
						healing everyone within your Territory at no cost.";
						
					docOn = 1;
					
					}
						
						else {hint "You cannot afford a Doctor yet!  Doctor's cost $105,000!"};
	
			// script
		},
		nil,		// arguments
		3,		// priority
		true,		// showWindow
		true,		// hideOnUse
		"",			// shortcut
		"docOn == 0", 	// condition
		12,			// radius
		false,		// unconscious
		"",			// selection
		""			// memoryPoint
		
		];
		