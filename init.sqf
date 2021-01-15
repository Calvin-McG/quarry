enableSaving [false, false];

MISSION_ROOT = call {
    private "_arr";
    _arr = toArray __FILE__;
    _arr resize (count _arr - 8);
    toString _arr
};


//quarry_player_life_time_start = 15*60; // 10*60
quarry_player_life_time_start = ("param_lifetimer" call BIS_fnc_getParamValue) *60;
quarry_player_kill_time_reward = 60*3;//Reward with three minutes
quarry_speed_limit = 80; //Traveling over this speed in kph will make you a valid target
//TODO - ambient civilans?
//TODO - Track kills

////////////////
/// POST 1.2 FEEDBACK.

// Admining/Perfecting
// Score for killing marks?
// Balancing the target selection....

// Event handler for death.
playerList = [];// civ1, civ2, civ3, civ4, civ5, civ6, civ7, civ8, civ9, civ10, civ11, civ12, civ13];
// now populated from the init.
// Construct playerList
alivePlayerList = [];
Target = objNull;
myTargetList = [];

attackerTargetList = [];

 "winner" addPublicVariableEventHandler {
	[winner] execVM "endMission.sqf";
 };

 
if (isServer) then {
    0 = [] execVM "vehicleCreate.sqf";
	0 = [] execVM "server.sqf";
};

[] execVM "f\safeStart\f_safeStart.sqf";

// Start forever loop?

if (hasInterface) then {
	if (side player != west) then {
		player setPos ([quarry_trigger,player] call qry_fnc_findPlayerSpawnPos);
	};
	//Briefing: Instructions
	if (side player == west) then {
		_sit = player createDiaryRecord ["diary", ["Cop Briefing","
		Keep the civillians from killing each other. For some reason your GPS seems to be picking up the transmitters the civs are carrying around, so you know where they all are.
		<br/>
		<br/>
		Possession and open carry of pistols is legal in this jurisdiction.
		<br/>
        <br/>
        Brandishing a weapon is illegal, and is grounds to use lethal force. However you should use caution, and give the civillian a chance to put away their weapon if they are not an immediate threat.
		"]];
	} else {
		_sit = player createDiaryRecord ["diary", ["Civilian","
		You have a bomb and a tracer in your head. Your watch tells you how many minutes you have left untill the bomb explodes.
		<br/>
		<br/>
		You have the GPS location of another player, and you will be rewarded with more time if you kill them.
		<br/>
        <br/>
        Somewhere out there is another player with your own GPS location. They want to earn more time by killing you.
        <br/>
        <br/>
        If you leave the zone, your timer will count down at ten times the normal speed.
        <br/>
        <br/>
		If you kill someone who is not your target, you will be docked time, unless that person was trying to kill you.
		<br/>
		<br/>
		There are police patroling the city. They may shoot you if you are brandishing a weapon. Default binding to holster is '0'
		"]];
	};
	//Briefing: Credits
	_sit = player createDiaryRecord ["diary", ["Credits","
	Sources of Inspiration: This is inspired by the Shacktac 'The Game' gamemode which was inspired by the game called 'The ship', which was made by Kevb0.<br/><br/>
	Rifling Matters (Austrialian Arma group) made a version called 'Quarry', and it is this name we use. <br/><br/>
	Snippers developed the version for the Team One Tactical Community.<br/></br><br/><br/>
	Calvin extended that version for Combined Arms.
	"]];
	
	fn_marker = compile preprocessFileLineNumbers "markerSystem.sqf";
	
	qry_hp = quarry_player_life_time_start;
	if (side player == civilian) then {
		0 = [] spawn {
			waitUntil{time > 0};
			//player setVariable["qry_hp",60*10];
			while {qry_hp > 0} do {
				newTarget = player getVariable["qry_target",objNull];
				if (Target != newTarget) then {
					Target = newTarget;
					if (!isNull Target) then {
						if (alive Target) then {
							hint format["Your target: %1",name Target];
						};
						myTargetList pushBack Target;
					};
				};
				uiSleep 1;
				//player setVariable["qry_hp",(player getVariable["qry_hp",60*10])-1]; // hopefully atomic.
				qry_hp = qry_hp - 1;
                if (!([getPos player,quarry_trigger] call CBA_fnc_inArea)) then {
                    playSound3D [MISSION_ROOT + "beep.wav", player,false,getPosASL player,1,1,10];
                    systemChat format["I am outside of the game area, my timer is decreasing 10x faster."];
                    qry_hp = qry_hp - 9;
                };
				if ((qry_hp mod 60) == 0) then { //((player getVariable["qry_hp",60*10]) mod 60 == 0) then {
					systemChat format["The timer on your watch decreases, it reads %1 minutes left of life.",round (qry_hp/60)];
                    player setVariable["qry_hp",qry_hp,true];
				};
                if (vehicle player != player) then {
                    if (speed player >= quarry_speed_limit) then {
                        if (((player getVariable["qry_lastSpeeding",(-30)]) + 6) > time ) then {
                            player setVariable["qry_lastSpeeding",time,true];
                        };
                    };
                };

				if (qry_hp < 11) then {
					switch (qry_hp) do {
						case 10: {playSound3D [MISSION_ROOT + "beep.wav", player,false,getPosASL player,1,1,10];};
						case 5: {playSound3D [MISSION_ROOT + "beep.wav", player,false,getPosASL player,1,1.1,10];};
						case 4: {playSound3D [MISSION_ROOT + "beep.wav", player,false,getPosASL player,1,1.3,10];};
						case 3: {playSound3D [MISSION_ROOT + "beep.wav", player,false,getPosASL player,1,1.6,10];};
						case 2: {playSound3D [MISSION_ROOT + "beep.wav", player,false,getPosASL player,1,2,10];};
						case 1: {playSound3D [MISSION_ROOT + "beep.wav", player,false,getPosASL player,3,10,20];};
						default {};
					};
				};
			};
			//Time up
			if ((alive player)) then {
			//https://community.bistudio.com/wiki/playSound3D
                if (faction player != "") then {
                    playSound3D [MISSION_ROOT + "beep.wav", player,false,[0,0,0],1,1,10];
                    player setDamage 1; //explode.
                };
			};
		};
	};
	
	//waitUntil{time > 1};

	// Map Markers, should also give spectators markers too?

	// MCC FIX - remove the HQs
	unitArray = allUnits;
	{
		if (typeof _x == "SideOPFOR_F") then {
		  unitArray = unitArray - [_x];
		};
		if (typeof _x == "SideBLUFOR_F") then {
		  unitArray = unitArray - [_x];
		};
		if (typeof _x == "SideResistance_F") then {
		  unitArray = unitArray - [_x];
		};
	} forEach unitArray;
	{[_x] spawn {[_this select 0] call fn_marker};} forEach unitArray;

};
