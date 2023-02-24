_guy = _this select 0;

_strt = [_guy,"Assassin",["
		1.  Eliminate the Prime Minister in <marker name='marker_3'>Pyrgos</marker>.<br></br>
		2.  Eliminate the General in <marker name='marker_1'>Kavala</marker>.<br></br>
		3.  Eliminate the Cardinal in <marker name='marker_2'>Selakano</marker>.<br></br>
		 ",
	 "Assassin","Attack"],(getPosATL TJ),3,2,true,"Attack",false] call BIS_fnc_taskCreate;

while {hits < 3}
	
	do {
	
		sleep 0.2;
		
		if ((!alive TJ) and (TJ in hitList))
			
			then {
				
				hits = hits + 1;
				[_strt, (getPosATL redCop)] call BIS_fnc_taskSetDestination;
				hitList deleteAt (hitList find TJ);
				_reg3 = [_guy,"Assassin 0",["The Beginning.","Assassinate The Prime Minister.","Attack"],(getMarkerPos "marker_2"),"SUCCEEDED",2,true,"Attack",false] call BIS_fnc_taskCreate;

				};
		
		if ((!alive redCop) and (redCop in hitList))
			
			then {
				
				hits = hits + 1;
				[_strt, (getPosATL Cardinal)] call BIS_fnc_taskSetDestination;
				hitList deleteAt (hitList find redCop);
				_reg2 = [_guy,"Assassin 1",["The Middle.","Assassinate The General.","Attack"],(getMarkerPos "marker_2"),"SUCCEEDED",2,true,"Attack",false] call BIS_fnc_taskCreate;

				};
				
		if ((!alive Cardinal) and (Cardinal in hitList))
			
			then {
				
				hits = hits + 1;
				hitList deleteAt (hitList find Cardinal);
				_reg3 = [_guy,"Assassin 2",["The End.","Assassinate The Cardinal.","Attack"],(getMarkerPos "marker_2"),"SUCCEEDED",2,true,"Attack",false] call BIS_fnc_taskCreate;

				};
		
		};
	
waitUntil {hits == 3};

sleep 1;

[_strt,"SUCCEEDED",true] spawn BIS_fnc_taskSetState;
	
sleep 2;

_reg4 = [_guy,"RTB2",["Report your success to the Registrar","Report to Athira.","Attack"],(getPos grecop),3,2,true,"Attack",false] call BIS_fnc_taskCreate;

waitUntil {_guy distance grecop < 20};

removeAllActions grecop;

grecop addAction

	[
		"Report",	// title
		{
			params ["_target", "_caller", "_actionId", "_arguments"];
			
			hint "Mission Complete.";
			
			w = 5;
			
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

waitUntil {w == 5};

[_reg4,"SUCCEEDED",true] spawn BIS_fnc_taskSetState;

sleep 3;

postIt = 1;


"end1" call BIS_fnc_endMission;