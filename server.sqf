attackerTargetList = [];

fn_pick_target = {
	private["_ignore","_target","_tempArray"];
	_ignore = _this select 0;
	_target = _ignore;
	_tempArray = alivePlayerList - [_ignore];
	if (count _tempArray > 0) then {
		_target = _tempArray call BIS_fnc_selectRandom;
	};
	_target
};

waitUntil{time > 1}; //Wait till mission start
_null = [] spawn {
	sleep 5;
	// Pick initial targets for all players.
	
	//alivePlayerList = alivePlayerList;
	if (count alivePlayerList > 1) then {
		for "_x" from 0 to (count alivePlayerList) -1 do {
			_attacker = alivePlayerList select _x;
			_target = [_attacker] call fn_pick_target;
			_attacker setVariable ["qry_target",_target,true];
			attackerTargetList pushBack [_attacker, _target]; // presync_attackerTargetList = presync_attackerTargetList + [[_attacker, _target]]; 
		};
	};
	
	// main loop
    while {true} do {
		private["_entry","_newtarget","_x","_length"];
		//Check all targets are still valid, if not issue new ones...
		// have a list of players to check (if they have a target)
		// check that the player is okay..
		_x = 0;
		_length = count attackerTargetList;
		while {_x < _length} do {
			// 0 for target, 0 for s
			_entry = attackerTargetList select _x;
			if (alive (_entry select 0)) then {
				if (!alive (_entry select 1)) then {
					// target is dead, give a new target...
					 _newtarget = [_entry select 0] call fn_pick_target;
					 // replace old (saves resizing array)
					 (_entry select 0) setVariable ["qry_target",_newtarget,true];
					 attackerTargetList set [_x,[_entry select 0, _newtarget]];
				};
			} else {
				//attacker is dead remove record
				attackerTargetList deleteAt _x;
				 _x = _x - 1;
				_length = _length - 1;
			};
			_x = _x + 1;
		};
		if (count attackerTargetList <= 1) then {
			// Send winner 
			winner = objNull;
			if (count alivePlayerList == 1) then {
				winner = alivePlayerList select 0;
			};
			publicVariable "winner";
            0 = [] execVM "endMission.sqf";
			sleep 100;
		};
		
		sleep 1;
	};
	//Exit Loop: End Mission
	
};



