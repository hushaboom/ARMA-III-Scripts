_guy = _this select 0;

while {alive _guy}
	
	do {
	
	if (_guy distance Chappie < 150)
		
		then {
			
			vx = -200000000000000000000000000000000000000;
			hint "You were told.  Now you'll learn.  Good-bye.";
			_guy addRating vx;};
	
	};
	
