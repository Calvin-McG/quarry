private["_unit","_uniforms","_headgears","_vests","_backpacks","_gearOpt"];
_unit = _this select 0;
[_unit] spawn {
	_unit = _this select 0;
	waitUntil{!isNil "playerList"};
	playerList pushBack _unit;
	waitUntil{!isNil "alivePlayerList"};
	alivePlayerList pushBack _unit;
};

//Add death handler

if (local _unit) then {
	// tweak the gear...
	// Backpacks
	_unit addMPEventHandler ["mpkilled","_this call qry_fnc_civKilled;"];
	
	removeAllWeapons _unit;
	_unit removeItem "ItemRadio";
	
	// Bino
	
	// Satchel
	//Vanilla - Arma 3
	_uniforms = ["U_Rangemaster","U_C_Poloshirt_tricolour","U_C_Poloshirt_salmon","U_C_Poloshirt_burgundy","U_C_Poloshirt_blue","U_OrestesBody","U_Competitor","U_IG_Guerilla1_1","U_IG_Guerilla2_1","U_IG_Guerilla2_2","U_IG_Guerilla3_1","U_IG_Guerilla3_2","U_IG_leader","U_C_HunterBody_grn","U_I_G_resistanceLeader_F","U_C_Driver_3","U_C_Journalist","U_Marshal","U_NikosBody"];
	_headgears = 	["H_Booniehat_khk","H_Cap_red","H_Cap_tan","H_Cap_blk","H_Cap_grn_BI","H_Bandanna_surfer","H_Bandanna_khk","H_Bandanna_camo","H_Shemag_khk","H_Shemag_olive","H_Beret_blk","H_Watchcap_blk","H_StrawHat","H_Hat_brown","H_Hat_checker","H_Cap_blk_ION","H_StrawHat_dark"];
	_vests = ["V_Rangemaster_belt","V_BandollierB_khk","V_BandollierB_rgr"];	
	_backpacks = ["B_AssaultPack_khk","B_AssaultPack_rgr","B_AssaultPack_blk","B_AssaultPack_cbr","B_Kitbag_rgr","B_Kitbag_cbr","B_Kitbag_sgg","B_TacticalPack_blk","B_Carryall_khk","B_FieldPack_cbr","B_FieldPack_khk","B_TacticalPack_oli"];
	// RDS civ pack
	//_uniforms = _uniforms + ["rds_uniform_assistant","rds_uniform_citizen1","rds_uniform_citizen2","rds_uniform_citizen3","rds_uniform_citizen4","rds_uniform_Functionary1","rds_uniform_Functionary2","rds_uniform_priest","rds_uniform_Profiteer1","rds_uniform_Profiteer2","rds_uniform_Profiteer3","rds_uniform_Profiteer4","rds_uniform_Villager1","rds_uniform_Villager2","rds_uniform_Villager3","rds_uniform_Villager4","rds_uniform_Woodlander1","rds_uniform_Woodlander2","rds_uniform_Woodlander3","rds_uniform_Woodlander4","rds_uniform_Worker1","rds_uniform_Worker2","rds_uniform_Worker3","rds_uniform_Worker4","rds_uniform_doctor"];
	//_headgears = _headgears + ["rds_Profiteer_cap4","rds_Profiteer_cap1","rds_Profiteer_cap2","rds_Profiteer_cap3","rds_Villager_cap1","rds_Villager_cap2","rds_worker_cap1","rds_worker_cap2","rds_worker_cap3","rds_worker_cap4"];
	//TRYK
	//_uniforms = _uniforms + ["TRYK_OVERALL_nok_flesh","TRYK_OVERALL_SAGE","TRYK_U_B_PCUGs_BLK","TRYK_U_B_BLK_T_BK","TRYK_U_B_BLK_T_WH","TRYK_U_B_Denim_T_BK","TRYK_U_B_Denim_T_WH"];
	
	removeUniform _unit;
	removeheadgear _unit;
	_unit forceAddUniform (_uniforms call BIS_fnc_selectRandom);
	_unit addheadgear (_headgears call BIS_fnc_selectRandom);
	_unit linkItem "ItemGPS";
	_unit linkItem "ItemMap";
	_unit linkItem "ItemCompass";
	
	_gearOpt = round random 5;
	_unit addvest(_vests call BIS_fnc_selectRandom);
	_unit addbackpack(_backpacks call BIS_fnc_selectRandom);
	_unit addmagazine "Chemlight_yellow";
	_unit addmagazine "SatchelCharge_Remote_Mag";
	_unit addItem "ACE_Earplugs";
	_unit addmagazines ["ACE_M84",1];
	_unit addmagazines ["MiniGrenade",1];
	switch (_gearOpt) do {
	    case 0: {//Modern 45 with RDS and Flashlight
            _unit addmagazines["11Rnd_45ACP_Mag",1];
            _unit addweapon "hgun_Pistol_heavy_01_F";
            _unit addmagazines["11Rnd_45ACP_Mag",4];
            _unit addWeaponItem ["hgun_Pistol_heavy_01_F", "acc_flashlight_pistol"];
            _unit addWeaponItem ["hgun_Pistol_heavy_01_F", "optic_mrd"];
        };
		case 1: {//9mm with flashlight and standard mags
			_unit addmagazines["16Rnd_9x21_Mag",1];
			_unit addweapon "AMF_Pamas";
			_unit addmagazines["16Rnd_9x21_Mag",3];
			_unit addWeaponItem ["AMF_Pamas", "acc_flashlight_pistol"];
		};
		default {
			_unit addmagazines["16Rnd_9x21_Mag",1];
            _unit addweapon "AMF_Pamas";
            _unit addmagazines["16Rnd_9x21_Mag",3];
            _unit addWeaponItem ["AMF_Pamas", "acc_flashlight_pistol"];
		};
	};
};
