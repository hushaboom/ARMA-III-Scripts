_guy = _this select 0;
_mark = _this select 1;
_building = _this select 2;

tutorialCue = 1;

vx = 1900;
removeAllActions grecop;

sleep 3;

_reg = [_guy,"Register",["Register the property with your Registration Officer.","Registration","Attack"],getpos grecop,3,2,true,"Attack",false] call BIS_fnc_taskCreate;

_myMap = playerMap get (name _guy);
_myMap params ["_tickets", "_points", "_money", "_roster", "_claims", "_kills", "_shots"];
sleep 0.1;

grecop addAction

	[
		"Register",	// title
		{
			params ["_target", "_caller", "_actionId", "_arguments"];
			
			_claims = _arguments select 0;
			
			{
				_x setMarkerColor "colorGreen";
				
				} forEach claimMarkrs;
			
			removeAllActions grecop;
			
			if (baseon == 0)
				
				then {
					
					registeredLand = [];
					baseon = 1;
					
					};
				
			{
			
				if ((count _x) != 3)
					
					then {}
						
						else {
							
							if ((_x select 0) in registeredLand)
								
								then {
								
									registeredLand = registeredLand + [(_x select 0)];
									
									};
							
							};
									
				} forEach _claims;
				
			null = [_caller] execVM "System\regOfficer.sqf";
			
			regOn = 1;
			
			vx = 200;
			
			sleep 4;
			
			vx = 201;
			
			// script
		},
		[_claims, _reg],		// arguments
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
		
