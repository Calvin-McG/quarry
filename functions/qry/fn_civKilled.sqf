_killed = _this select 0;
_killer = _this select 1;

alivePlayerList = alivePlayerList - [_killed];

// Calculate
if (hasInterface) then {
	//_myTarget = player getVariable["qry_target",objNull];
	if (player == _killer) then {
		if (_killed in myTargetList) then {
			qry_hp = qry_hp + quarry_player_kill_time_reward; //player setVariable["qry_hp",(player getVariable["qry_hp",60*10])+(3*60)]; 
            player setVariable["qry_hp",qry_hp,true];
			systemChat "You killed your quarry. You have received an extra 3 minutes on your clock.";
		} else {
          //killed someone that wasn't my _killed.  
            _hasWeapon = (currentWeapon _killed != "");
            _hadWeapon = (((_killed getVariable ["qry_hadWeapon",(-30)])+5) > time);
            _wasSpeeding = (((_killed getVariable["qry_lastSpeeding",(-30)])+6) > time);
            if (side _killer == civilian) then {
                if (side _killed == civilian) then {
                    // was a civilan
                    if (_killed getVariable["qry_target",objNull] == player) then {
                        systemChat format["You killed %1 and they were hunting you.",name _killed];
                    } else {
                        if (_hasWeapon or _hadWeapon or _wasSpeeding) then {
                            systemChat format["You killed %1 and they were not hunting you, but you will recieve no penalty.",name _killed];
                        } else {
                            systemChat format["You killed %1 and they were not hunting you. You will lose 2 minutes of lifetime.",name _killed];
                            qry_hp = qry_hp - 120;
                            player setVariable["qry_hp",qry_hp,true];
                        };

                    }; 
                };
            } else {
                if (side _killed == civilian) then {
                  //Cop killed civilian  
                    if (_hasWeapon or _hadWeapon or _wasSpeeding) then {
                        systemChat format["You killed %1 and they were a valid threat.",name _killed];
                    } else {
                        systemChat format["You killed %1 and they were not a threat. Your smg has been confiscated, Pig.",name _killed];
                        player removeWeapon 'hlc_smg_9mmar';
                    };  
                };
                
            };
        };
	} else {
		if (player == _killed) then {
			if (side _killer == west) then {
				systemChat format["You were killed by officer %1.",name _killer];
			} else {
				if (_killer getVariable["qry_target",objNull] == player) then {
					systemChat format["You were killed by %1 and they were hunting you.",name _killer];
				} else {
					systemChat format["You were killed by %1, but they were not hunting you.",name _killer];
				};
			};
		};
	};
    if (player == _killed) then {
        qry_hp = -1;
    };
};
