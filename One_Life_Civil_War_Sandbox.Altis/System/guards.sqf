_guy = _this select 0;
_building = _this select 1;
_caller = _this select 2;

_map = playerMap get (name _caller);
_map params ["_tickets", "_points", "_money", "_roster", "_claims", "_kills", "_shots"];
			
_roster = _roster + (units (group _guy));

hint format ["%1 Unit Available", (count _roster)];

_playerMap = [_tickets, _points, _money, _roster, _claims, _kills, _shots];
playerMap set [(name _guy), _playerMap];

postIt = 1;

onHand = onHand + [_guy];

null = [_guy] execVM "System\doodman.sqf";