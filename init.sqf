execVM "R3F_LOG\init.sqf";

tf_no_auto_long_range_radio = true;
tf_same_sw_frequencies_for_side = true;
tf_freq_west =    [0 ,7, ["31","32","33","34","35","36","37","38","39"],0, nil, -1, 0];
tf_freq_west_lr = [3 ,7, ["31","42","43","44","45","46","47","48","49"],0, nil, -1, 0];

enableSaving [false, false];

MISSION_ROOT = call {
    private "_arr";
    _arr = toArray __FILE__;
    _arr resize (count _arr - 8);
    toString _arr
};


//quarry_player_life_time_start = 15*60; // 10*60
quarry_player_life_time_start = ("param_lifetimer" call BIS_fnc_getParamValue) *60;
quarry_player_kill_time_reward = 60*3;
quarry_speed_limit = 80; // km/h
//FIX:
// Civi Vest not big enough to hold explosives
// Paramters; Time of day, ambient civilans?
// Score?

// TO DO: 
// Track kills


////////////////
/// POST 1.2 FEEDBACK.

// Admining/Perfecting
// Score for killing marks?
// Balancing the target selection....

//OPTION: have a random player chosen as the game master (black suit), spawn at least say 4km from the police HQ, if he dies all live players win and cops lose. Cops must keep him alive (no map marker for him).

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

		holstered = 0;  
		player addAction ["Holster sidearm","arc_holster.sqf",nil,2.5,false,true,"",""];
	};
	//Briefing: Instructions
	if (side player == west) then {
		_sit = player createDiaryRecord ["diary", ["Cop Briefing","
		As a cop you are expected to keep law and order. You are only authorized to use deadly force if a suspect has a weapon in their hands or is attempting to kill you or a fellow officer or citizen. Feel free to conversate with the citizens and harass them but in this country confiscating property other than vehicles is not authorized by the law.
		<br/>
		<br/>
		You will start with an armoured vest, an mp5, some basic medical supplies and a radio. There are also have several police vehicles available at the police HQ.
		<br/>
		<br/>
		To aid you keep the peace; On your map you will see all the players marked, blue for cops, red for civilians, black for dead players. But when roleplaying you should pretend to have no knowledge of this map.
		"]];
	} else {
		_sit = player createDiaryRecord ["diary", ["Civilian","
		You were ambushed and captured by men in masks on your journey to work, they knocked me out and next thing I recall was waking up in a dark cell. A mysterious man I could not see, explained to me that I would be partaking in a game of his making.
		<br/>
		<br/>
		He explained that when I next wake-up I would be forced to play his game. He said he put a GPS tracker in me and an explosive charge in my brain and he has done this to several others and that we're having a competition. When I wake up I'll have a watch, GPS device and a weapon. The watch will tell me how long if I have left till the charge in my brain blows, I can earn more time by killing people that show up on the GPS device. He discouraged me from killing people who are not marked as my target. He also said if I try to escape from his game I'll be killed.
		<br/>
		<br/>
		He also mentioned that there will be cops around. Their duty is to patrol the streets and prevent any deaths. They have only been authorized to use deadly force if they see a suspect with a weapon in their hands. I have a scroll wheel action to hide/retrieve a pistol I am carrying.
		"]];
	};
	//Briefing: Credits
	_sit = player createDiaryRecord ["diary", ["Credits","
	Sources of Inspiration: This is inspired by the Shacktac 'The Game' gamemode which was inspired by the game called 'The ship', which was made by Kevb0.<br/><br/>
	Rifling Matters (Austrialian Arma group) made a version called 'Quarry', and it is this name we use. <br/><br/><br/>
	This version was made by Snippers with several ideas from the Team One Tactical Community.<br/></br><br/><br/>
	Various code from the F3 framework has helped (Primarly the marker system served as a great example). I'd also thank to thank Head for the awesome spectator script (also F3). For full F3 credits please see <br/> https://github.com/ferstaberinde/F3<br/><br/>
	Thanks to Bear for helping provide the awesome ending</br></br>
	Ending song thanks to Super (Song called Biamby></br></br>
	Sound effects courtesey of freesounds.com<br/><br/>
    Thanks to R3F for their awesome logistics system!
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
