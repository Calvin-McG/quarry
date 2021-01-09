
_unit = (_this select 0);

_pos = getPos _unit;
_angle = (getDir _unit);
_length = 3.5;
//_pos set [1,(_pos select 1) + (cos(_angle)*_length)];
//_pos set [0,(_pos select 0) + (sin(_angle)*_length)];
//_pos set [2,(_pos select 2) + 2];

if (hasInterface) then {

    _cam = "camera" camCreate (getPos _unit);
    _cam camSetTarget _unit;
    _cam camSetRelPos [0, 4, 2.5];
    _cam cameraEffect ["internal", "front"];
    _cam camCommit 0;
    cameraEffectEnableHUD true;
    showCinemaBorder false;

    /*
    999 cutRsc ["MissionPassedPic", "PLAIN",5];
    1000 cutText [format ["Winner: %1",name _unit],"PLAIN DOWN"];
    playSound  "victoryEndSound";
    sleep 10;

    if (!hasInterface) then {
        ["end1",true,0,false] spawn BIS_fnc_endMission;
    } else {
        if (player == _unit) then {
            ["end1",true,0,false] spawn BIS_fnc_endMission;
        } else {
            ["end2",true,0,false] spawn BIS_fnc_endMission;
        };
    };
    */

    playSound  "victoryEndSound2";
    uiSleep 3;
    999 cutRsc ["MissionPassedPic2", "PLAIN",5];
    1000 cutText [format ["Winner: %1",name _unit],"PLAIN"];

    "colorCorrections" ppEffectAdjust[0.9, 1.1, 0.004, [0,0,0,0.5] , [0,0,0,1],[0,0,0,0]];
    "colorCorrections" ppEffectCommit 0;
    "colorCorrections" ppEffectEnable true;
    _cam camCommitPrepared 2;
    waitUntil {camCommitted _cam};
    _cam camSetFov (2); // 45 0.78539
    _cam camCommit 3;
    waitUntil {camCommitted _cam};
    _cam camSetFov (1); // 45 0.78539
    _cam camCommit 3;
    waitUntil {camCommitted _cam};
    _cam camSetFov (2); // 45 0.78539
    _cam camCommit 3;
    waitUntil {camCommitted _cam};
    _cam camSetFov (1); // 45 0.78539
    "colorCorrections" ppEffectAdjust[0.9, 1.1, 0.004, [0,0,0,1] , [0,0,0,1],[0,0,0,0]];
    "colorCorrections" ppEffectCommit 3;
    _cam camCommit 3;
    waitUntil {camCommitted _cam};
    sleep 5;
    if (player == _unit) then {
		endMission "end1";
	} else {
		endMission "end2";
	};
} else {
    sleep 20;
    endMission "end1";
};

