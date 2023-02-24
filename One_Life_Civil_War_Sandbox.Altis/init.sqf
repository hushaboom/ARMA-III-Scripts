if (!isServer) exitWith{};


setDate [2073, 1 + (floor random 11), (floor random 27) + 1, 0, 0];
[0.0 + (random 0.85)] call BIS_fnc_setOvercast;

_sun = date call BIS_fnc_sunriseSunsetTime;
_time = _sun select 0;

0 fadeSound 0;
//enableSaving [false, false];
waitUntil {time > 0};

cutText ["AIM AWAY FROM FACE", "BLACK FADED", 1.1];
//disableUserInput true;

players = [player_0, player_1, player_2, player_3, player_4, player_5];


xPos = [14034.7,18660,0];	//Center point of mission
spawnOnOff = 1;	//Turns enemy spawning on/off.  1 = on.

playerMap = createHashMap;
propertyMap = createHashMap;

buildings = [];
warehouses = [];
Trucks = [];
markerHold = [];
cityHold = [];
townHold = [];
comHold = [];
boxes = [medBox, myBox];
carCollection = [];
RoseLand = ["marker_1", "marker_2"];
registeredLand = [];
registeredCars = [cTruck, myCar, myCar0];
Territories = ["Athira"];
guns = [];
doods = [];
civs = [];
lootPos = [];
snaps = [];
marks = [];
service = [];
onHand = [];
ClaimedBuildings = [];
claimMarkrs = [];
claimGuards = [];
spawnLocs = [];
specialDoods = [bob, grecop, cg_0];
strongHolds = [];
storage = [];
hitlist = [TJ, redCop, Cardinal];

RoseOpperators = 0;
carCount = 0;
cash = 0;
baseon = 0;
msrOn = 0;
msrRec = 0;
laptopOn = 0;
docOn = 0;
shopOn = 0;
regOn = 0;
vx = 0;
day = 0;
killcount = 0;
teamCap = 6;
postIt = 0;
payTime = 0;
payUp = 0;
lootLevel = 1;
startcount = 5;
popStart = (count allUnits);
msrFail = 0;
midcheck = 0;
bombTruck = 0;
workOrder = 0;
meds = 0;
w = 0;
GLG20Mission = 0;
mechGo = 0;
strongCount = 0;
hits = 0;

redForce = 650;
bluForce = 375;

null = [] execVM "System\texts.sqf";
null = [] execVM "System\handlers.sqf";

12 fadeSound 1;

null = [] execVM "System\Generators\makethman.sqf";
sleep 0.1;
null = [] execVM "System\places.sqf";
sleep 0.1;

waitUntil {vx > 100};

{
	if (isPlayer _x) then {
		
		_pos = ([xPos, 375, 450, 3, 0, 20, 0] call BIS_fnc_findSafePos);
		playerMap set [(name _x), [1, 0, 10000, [], [], [0,0],0]];
		null = [] execVM "System\Player\playerInit.sqf";
		null = [_x] execVM "System\regOfficer.sqf";
		null = [_x] execVM "System\Missions\Player\main.sqf";
		_p = nearestBuilding _x;
		
		_pPos = ([(getPos _p), 1, 6, 3, 0, 20, 0] call BIS_fnc_findSafePos);
		
		_x setDir (_x getDir TJ);
		
		}
			
		else {deleteVehicle _x};
	
	_index1 = _x createDiarySubject ["stats","Player Info"];
	
	} forEach players;

skipTime _time - 4500;

null = [0] execVM "System\dayticker.sqf";

sleep 0.3;

enableSaving [true, false];

disableUserInput false;
									
sleep 3;

vx = 160;

sleep 10;

vx = 200;