NATOArray = [];
FIAArray_WEST = [];
FIAArray_INDEPENDENT = [];
CTRGArray = [];
AAFArray = [];
SYNArray = [];
CIVArray = [];
CSATArray = [];
VIPERArray = [];
FIAArray_EAST = [];
spArray = [];
CarArray = [];
MRAPArray = [];
CTRGcarArray = [];
TruckArray = [];
AmmoArray = [];
ClothArray = [];
PackArray = [];
ItemArray = [];
AccArray = [];
VestArray = [];

personelGen = {

 
	CivArrayGen = "( 
		(getNumber (_x >> 'scope') >= 2) && 
		{getNumber (_x >> 'side') == 3 && 
		{getText (_x >> 'vehicleClass') in ['Men'] 
			} 
		} 
	)" configClasses (configFile >> "CfgVehicles");


	AAFArrayGen = "( 
		(getNumber (_x >> 'scope') >= 2) && 
		{getNumber (_x >> 'side') == 2 && 
		{getText (_x >> 'vehicleClass') in ['Men'] 
			} 
		} 
	)" configClasses (configFile >> "CfgVehicles");


	NATOArrayGen = "( 
		(getNumber (_x >> 'scope') >= 2) && 
		{getNumber (_x >> 'side') == 1 && 
		{getText (_x >> 'vehicleClass') in ['Men'] 
			} 
		} 
	)" configClasses (configFile >> "CfgVehicles");
	
	


	CSATArrayGen = "( 
		(getNumber (_x >> 'scope') >= 2) && 
		{getNumber (_x >> 'side') == 0 && 
		{getText (_x >> 'vehicleClass') in ['Men'] 
			} 
		} 
	)" configClasses (configFile >> "CfgVehicles");
	






	/* Filter: WEST */
	for "_i" from 0 to (count NATOArrayGen - 1) do {
	
		if (getText(configFile >> "CfgVehicles" >> (configName (NATOArrayGen select _i)) >> "displayName") in blacklist) then {sleep 0.1;} else {
	
			if ((configName (NATOArrayGen select _i)) select[0,3] == "B_G") 
	
				then {FIAArray_WEST = FIAArray_WEST + [(configName (NATOArrayGen select _i))]} 
			
					else {
		
						if ((configName(NATOArrayGen select _i)) select[0,6] == "B_CTRG") 
				
							then {CTRGArray = CTRGArray + [(configName (NATOArrayGen select _i))]} 
					
								else {
			
									NATOArray = NATOArray + [(configName (NATOArrayGen select _i))]}
	
					};
			};
	
	};

	/* Filter: INDEPENDENT */
	for "_i" from 0 to (count AAFArrayGen - 1) do {
	
		if (getText(configFile >> "CfgVehicles" >> (configName (AAFArrayGen select _i)) >> "displayName") in blacklist) then {sleep 0.1;} else {

			if ((configName (AAFArrayGen select _i)) select [0,3] == "I_G")
	
				then {FIAArray_INDEPENDENT = FIAArray_INDEPENDENT + [(configName (AAFArrayGen select _i))]}
		
					else {
			
						if ((configName (AAFArrayGen select _i)) select [0,3] == "I_C")
				
							then {SYNArray = SYNArray + [(configName (AAFArrayGen select _i))]}
					
								else {AAFArray = AAFArray + [(configName (AAFArrayGen select _i))]}
					};
	
		};
	
	};


	/* Filter: CIVILIAN */
	for "_i" from 0 to (count CivArrayGen -1) do {
		
		if (getText(configFile >> "CfgVehicles" >> (configName (CivArrayGen select _i)) >> "displayName") in blacklist) then {sleep 0.1;} else {
	
			CivArray = CivArray + [(configName (CivArrayGen select _i))]
		};
	
	};

	
	/* Filter: CSAT */
	for "_i" from 0 to (count CSATArrayGen - 1) do {
	
		if (getText(configFile >> "CfgVehicles" >> (configName (CSATArrayGen select _i)) >> "displayName") in blacklist) then {sleep 0.1;} else {
	
			if ((configName (CSATArrayGen select _i)) select [0,3] == "O_V")
		
				then {VIPERArray = VIPERArray + [(configName (CSATArrayGen select _i))]}
		
					else {
			
						if ((configName (CSATArrayGen select _i)) select [0,3] == "O_G")
				
							then {FIAArray_EAST = FIAArray_EAST + [(configName (CSATArrayGen select _i))]}
					
								else {CSATArray = CSATArray + [(configName (CSATArrayGen select _i))]}
					};
	
		};
	
	};
	
	
vx = 20;

}; // End of PersonelGen

carFind = {

	private ["_carName"];
	
	
	CarArrayGen = "( 
		(getNumber (_x >> 'scope') >= 0) && 
		{getNumber (_x >> 'side') <= 3 && 
		{getText (_x >> 'vehicleClass') in ['Car_F'] 
			} 
		} 
	)" configClasses (configFile >> "CfgVehicles");
	
	TruckArrayGen = "( 
		(getNumber (_x >> 'scope') >= 2) && 
		{getNumber (_x >> 'side') <= 3 && 
		{getText (_x >> 'vehicleClass') in ['Car'] 
			} 
		} 
	)" configClasses (configFile >> "CfgVehicles");
	

	for "_i" from 0 to (count TruckArrayGen - 1) do {
		
		_carName = (configName (TruckArrayGen select _i));
		
		CarArray = CarArray + [_carName];
		//hint format ["%1", (_carName select [0,6])];
		if (((_carName select [0,6]) == "B_MRAP") or ((_carName select [0,8]) == "B_T_MRAP")) then {
			
			//CTRGArray = CTRGArray + [_carName];
			CarArray deleteAt (CarArray find _carName);
			};
		
		if (((_carName select [0,6]) == "B_CTRG") or ((_carName select [0,8]) == "B_T_CTRG")) then {
			
			//CTRGcarArray = CTRGcarArray + [_carName];
			CarArray deleteAt (CarArray find _carName);
			};
			
		if (((_carName select [0,7]) == "B_TRUCK") or ((_carName select [0,9]) == "B_T_TRUCK")) then {
			
				TruckArray = TruckArray + [_carName];
				CarArray deleteAt (CarArray find _carName);
			};
		
	};
	
	for "_i" from 0 to (count CarArrayGen - 1) do {
		
		_carName = (configName (CarArrayGen select _i));
		
		CarArray = CarArray + [_carName];
		
				
	};
	
};
	
gunfind = {
	
	private ["_gunName"];
	
	GunArrayGen = "( 
			(getNumber (_x >> 'scope') >= 2) && 
			{getNumber (_x >> 'side') <= 3 && 
			{getText (_x >> 'vehicleClass') in ['WeaponsHandguns', 'WeaponsPrimary'] 
				} 
			} 
		)" configClasses (configFile >> "CfgVehicles");
		

		
	for "_i" from 0 to (count GunArrayGen - 1) do {
		
		_gunName = (configName (GunArrayGen select _i));
		
		guns = guns + [_gunName];
		};
	
	vx = 50;
	
	};
	
ammofind = {
	
	private ["_gunName"];
	
	AmmoArrayGen = "( 
			(getNumber (_x >> 'scope') >= 2) && 
			{getNumber (_x >> 'side') <= 3 && 
			{getText (_x >> 'vehicleClass') in ['Ammo'] 
				} 
			} 
		)" configClasses (configFile >> "CfgVehicles");
		

		
	for "_i" from 0 to (count AmmoArrayGen - 1) do {
		
		_gunName = (configName (AmmoArrayGen select _i));
		
		AmmoArray = AmmoArray + [_gunName];
		};
	
	vx = 60;
	
	};
	
clothfind = {
	
	private ["_gunName"];
	
	ClothArrayGen = "( 
			(getNumber (_x >> 'scope') >= 2) && 
			{getNumber (_x >> 'side') <= 3 && 
			{getText (_x >> 'vehicleClass') in ['ItemsUniforms'] 
				} 
			} 
		)" configClasses (configFile >> "CfgVehicles");
		

		
	for "_i" from 0 to (count ClothArrayGen - 1) do {
		
		_gunName = (configName (ClothArrayGen select _i));
		
		ClothArray = ClothArray + [_gunName];
		};
	
	vx = 70;
	
	};
	
packfind = {
	
	private ["_gunName"];
	
	PackArrayGen = "( 
			(getNumber (_x >> 'scope') >= 2) && 
			{getNumber (_x >> 'side') <= 3 && 
			{getText (_x >> 'vehicleClass') in ['Backpacks'] 
				} 
			} 
		)" configClasses (configFile >> "CfgVehicles");
		

		
	for "_i" from 0 to (count PackArrayGen - 1) do {
		
		_gunName = (configName (PackArrayGen select _i));
		
		PackArray = PackArray + [_gunName];
		};
	
	vx = 70;
	
	};
	
itemfind = {
	
	private ["_gunName"];
	
	ItemArrayGen = "( 
			(getNumber (_x >> 'scope') >= 2) && 
			{getNumber (_x >> 'side') <= 3 && 
			{getText (_x >> 'vehicleClass') in ['Items'] 
				} 
			} 
		)" configClasses (configFile >> "CfgVehicles");
		

		
	for "_i" from 0 to (count ItemArrayGen - 1) do {
		
		_gunName = (configName (ItemArrayGen select _i));
		
		ItemArray = ItemArray + [_gunName];
		};
	
	vx = 80;
	
	};
	
accfind = {
	
	private ["_gunName"];
	
	AccArrayGen = "( 
			(getNumber (_x >> 'scope') >= 2) && 
			{getNumber (_x >> 'side') <= 3 && 
			{getText (_x >> 'vehicleClass') in ['WeaponAccessories'] 
				} 
			} 
		)" configClasses (configFile >> "CfgVehicles");
		

		
	for "_i" from 0 to (count AccArrayGen - 1) do {
		
		_gunName = (configName (AccArrayGen select _i));
		
		AccArray = AccArray + [_gunName];
		};
	
	vx = 90;
	
	};

vestfind = {
	
	private ["_gunName"];
	
	VestArrayGen = "( 
			(getNumber (_x >> 'scope') >= 2) && 
			{getNumber (_x >> 'side') <= 3 && 
			{getText (_x >> 'vehicleClass') in ['ItemsVests'] 
				} 
			} 
		)" configClasses (configFile >> "CfgVehicles");
		

		
	for "_i" from 0 to (count VestArrayGen - 1) do {
		
		_gunName = (configName (VestArrayGen select _i));
		
		VestArray = VestArray + [_gunName];
		};
	
	vx = 100;
	
	};
		
call carFind;
call personelGen;
call gunfind;
call ammofind;
call clothfind;
call packfind;
call itemfind;
call accfind;
call vestfind;

vx = 120;