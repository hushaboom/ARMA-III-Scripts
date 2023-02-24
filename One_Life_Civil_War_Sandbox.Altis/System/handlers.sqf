if (!isServer) exitWith {};

AISkillNum = ((count registeredLand)/200);  // AI Skill.  Increases over time

{
	
	_x addEventHandler ["Killed", {
			
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
		
	} forEach [TJ, Cardinal, redcop, blucop] + (units pp0) + (units pp1);

addMissionEventHandler ["TeamSwitch", {

	params ["_previousUnit", "_newUnit"];

	if (!alive _previousUnit)
		
		then {
		
			vx = 210;
				
			_playerMap = playerMap get (name _previousUnit);
			_playerMap params ["_tickets", "_points", "_money", "_roster", "_claims", "_kills", "_shots"];
			
			_playerMap = [0, 0, _money, _roster, _claims, [0,0], _shots];
			playerMap set [(name _newUnit), _playerMap];
			removeAllActions _newUnit;
			
			workOrder = 0;
			msrOn = 0;
			msrRec = 0;
			
			{
				
				_pg = createGroup independent;
				_pos = getPos (selectRandom registeredLand);
				_unit = _pg createUnit [(typeOf _x), [_pos, 3, 50, 1, 0, 3, 0, [], []] call BIS_fnc_findSafePos, [], AISkillNum, "FORM"];
				onHand = onHand + [_unit];
				_playerMap = [0, 0, _money, _roster, _claims, [0,0], _shots];
				playerMap set [(name _unit), _playerMap];
				removeAllActions _newUnit;
				
				} forEach _roster;
			
			postIt = 1;
			
			if ((count warehouses) > 0)
				
				then {
					
					//hint "All deliveries cancelled.  You need to redo youe supply lines.";
					
					};
			
			if (side _newUnit == civilian)
				
				then {
					
					_pg = createGroup independent;
					
					[_newUnit] join _pg;
					removeAllActions _newUnit;
					
					};
					
			players = players + [_newUnit];
			removeAllActions _newUnit;
			
			_playerMap = [0, 0, _money, _roster, _claims, _kills, _shots];
			playerMap set [(name _newUnit), _playerMap];
			
			null = [_newUnit] execVM "System\Player\playerInit.sqf";
			null = [_newUnit] execVM "System\Missions\Player\main.sqf";
			null = [_newUnit] execVM "System\Missions\Player\progress.sqf";
			null = [_newUnit] execVM "System\Player\playerMon.sqf";
			
			while {(count (waypoints (group _newUnit))) > 0} do {
					
				deleteWaypoint ((waypoints (group _newUnit)) select 0);
			
				};
				
			vx = 160;
			
			}
				
				else {
					
					removeAllActions _newUnit;
					null = [_previousUnit] execVM "System\recruit.sqf";
					
					};

	
	while {(count (waypoints (group _newUnit))) > 0} do {
					
		deleteWaypoint ((waypoints (group _newUnit)) select 0);
	
		};
	
	
	vx = 160;
		
		
	if ((payUp >= 5) or ((count _roster) < 1))
		
		then {}
			
			else {
			
				if (!alive _previousUnit)
					
					then {
						
						_cost = 2500/lootLevel;
						hint format ["$%1 has been taken for your funeral.<br></br><br></br>Your Supply Routes have been cancelled.", _cost];
						_money = _money - _cost;
						
						{_x setDamage 1} forEach Trucks;
						
						_playerMap = [_tickets, _points, _money, _roster, _claims, _kills, _shots];
						playerMap set [(name _newUnit), _playerMap];
						
						postIt = 1;
						
						};
					
				
				vx = 160;
				
				};
				
	vx = 210;
	
}];