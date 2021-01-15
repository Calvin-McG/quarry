if (isServer) then {
	_unit = _this select 0;

	//Issue the gear
	clearWeaponCargoGlobal _unit;
	clearMagazineCargoGlobal _unit;
	clearItemCargoGlobal _unit;
	clearBackpackCargoGlobal _unit;


	player action["lighton", _unit];

	//Random gear
	_gearOpt = round random 9; //Generates number from 0 to 9. 8+ will result in the default case being called
	switch (_gearOpt) do {
		case 0:	{//Sawed off with four shells
            _unit addMagazineCargoGlobal ["2Rnd_12Gauge_Slug",1];
            _unit addWeaponWithAttachmentsCargo [["sgun_HunterShotgun_01_sawedoff_F", "", "", "", ["2Rnd_12Gauge_Slug", 2], [], ""], 1];
        };
		case 1: {//Two charges, Two FAKs
			_unit addMagazineCargoGlobal ["DemoCharge_Remote_Mag",2];
			_unit addItemCargoGlobal ["FirstAidKit",2];
		};
		case 2: {//This is the .45 kit some players spawn with
            _unit addMagazineCargoGlobal ["11Rnd_45ACP_Mag",5];
            _unit addItemCargoGlobal ["FirstAidKit",2];
            _unit addWeaponWithAttachmentsCargo [["hgun_Pistol_heavy_01_F", "", "acc_flashlight_pistol", "optic_mrd", ["11Rnd_45ACP_Mag", 11], [], ""], 1];
        };
        case 3:	{//Assassin kit. Silenced glock with laser and 30 round mags
            _unit addMagazineCargoGlobal ["30Rnd_9x21_Mag",1];
            _unit addItemCargoGlobal ["FirstAidKit",2];
            _unit addWeaponWithAttachmentsCargo [["UK3CB_BAF_L117A2", "uk3cb_baf_silencer_l105a1", "uk3cb_baf_l105a1_llm_ir_r", "", ["30Rnd_9x21_Mag", 30], [], ""], 1];
        };
        case 4:	{//Dirty Harry kit
            _unit addMagazineCargoGlobal ["Cre8ive_Mag_6Rnd_357_Speedloader_Tracer_Red",3];
            _unit addItemCargoGlobal ["FirstAidKit",2];
            _unit addWeaponWithAttachmentsCargo [["Cre8ive_Pst_CV_Ruka_357", "", "", "", ["Cre8ive_Mag_6Rnd_357_Speedloader_Tracer_Red", 6], [], ""], 1];
        };
        case 5:	{//Spare mags for each gun, NVG binocs
            _unit addMagazineCargoGlobal ["11Rnd_45ACP_Mag",2];
            _unit addMagazineCargoGlobal ["16Rnd_9x21_Mag",2];
            _unit addItemCargoGlobal ["ACE_Vector",1];
        };
        case 6:	{//Spare mags for each gun, press vest
            _unit addMagazineCargoGlobal ["11Rnd_45ACP_Mag",2];
            _unit addMagazineCargoGlobal ["16Rnd_9x21_Mag",2];
            _unit addItemCargoGlobal ["V_Press_F",1];
        };
        case 7: {//Tactical ladder
            _unit addBackpack "ACE_TacticalLadder_Pack";
        };
        case 8: {//Shitload of rocks
            _unit addMagazineCargoGlobal ["Cre8ive_Mag_Stone",69];
        };
		default {//Spare ammo, medical supplies
			_unit addMagazineCargoGlobal ["11Rnd_45ACP_Mag",5];
            _unit addMagazineCargoGlobal ["16Rnd_9x21_Mag",4];
            _unit addItemCargoGlobal ["FirstAidKit",2];
		};
	};
	
    //prevent vehicle destruction in first few seconds incase is spawned in a lamppost.
    _unit addEventHandler
    [
        "HandleDamage",
        {
            _unit = _this select 0;
            if (time > 5) then {
              (_this select 2)  
            } else {
             0   
            }
        }
    ];

};
