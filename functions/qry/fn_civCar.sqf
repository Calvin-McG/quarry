if (isServer) then {
	_unit = _this select 0;
	

	
	//Issue the gear
	clearWeaponCargoGlobal _unit;
	clearMagazineCargoGlobal _unit;
	clearItemCargoGlobal _unit;
	clearBackpackCargoGlobal _unit;
	
	//Random gear
	_gearOpt = round random 2; // this means default is more likely.
	switch (_gearOpt) do {
		case 0:	{
			_unit addWeaponCargoGlobal ["hgun_ACPC2_F", 1];
			_unit addMagazineCargoGlobal ["9Rnd_45ACP_Mag",4];
			_unit addItemCargoGlobal ["FirstAidKit",2];
		};
		case 1: {
			_unit addMagazineCargoGlobal ["DemoCharge_Remote_Mag",2];
			_unit addItemCargoGlobal ["FirstAidKit",2];
		};
		case 2: {
			_unit addMagazineCargoGlobal ["9Rnd_45ACP_Mag",3];
			_unit addMagazineCargoGlobal ["11Rnd_45ACP_Mag",3];
			_unit addMagazineCargoGlobal ["16Rnd_9x21_Mag",2];
			_unit addMagazineCargoGlobal ["6Rnd_45ACP_Cylinder",5];
			_unit addItemCargoGlobal ["FirstAidKit",2];
		};
		default {
			_unit addItemCargoGlobal ["FirstAidKit",5];
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