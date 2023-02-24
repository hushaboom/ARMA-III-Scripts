if (!isServer) exitwith {};

whiteList = ["Land_PoliceStation_01_F", "Land_HealthCenter_01_F", "Land_FuelStation_03_shop_F",
			"Land_PowerStation_01_F", "Land_Substation_01_F", "Land_DPP_01_mainFactory_old_F", "Land_Factory_02_F",
			"Land_CementWorks_01_grey_F", "Land_CementWorks_01_brick_F", "Land_IndustrialShed_01_F", "Land_i_Shed_Ind_old_F", "Land_Mine_01_warehouse_F",
			"Land_Barn_03_large_F", "Land_Barn_03_small_F", "Land_i_Shed_Ind_F", "Land_CarService_F", "Land_GarageRow_01_large_F", "Land_GarageRow_01_small_F",
			"Land_VillageStore_01_F", "Land_Medevac_HQ_V1_F"
			
			]; //Important Objects

blackList = [[],"Land_ContainerLine_01_F","Lampstreet_Small_F","Land_LampHalogen_F","Land_Shed_05_F","Land_Shop_City_06_F","Land_Addon_03_F","Land_PowerLine_01_wire_50m_F","PowerLine_01_Pole_Small_F",
				"Land_PowerLine_01_wire_50m_main_F","Land_PowerLine_01_wire_50m_F","powerLine_01_wire_50m_F","Land_House_Small_06_F","Land_Shed_02_F","Land_Addon_01_F","Land_PowerLine_01_pole_transformer_F",
				"Pilot","Survivor","Helicopter Pilot","Helicopter Crew","Crewman","Marshal",
				"Miler","Deck Crew","Fighter Pilot","Range Master","Driver (Redstone)","Driver (Fuel)",
				"Driver (Bluking)","Driver (Vrana)","Scientist","Soldier (Unarmed)", "Rifleman (Unarmed)",
				"Solomon Maru","C_Offroad_01_white_F","Nifi", "Land_Pier_F", "Land_Pier_wall_F", "Land_dp_bigTank_F",
				"Land_i_Addon_04_V1_F", "Land_i_Addon_03mid_V1_F", "Land_i_Addon_03_V1_F", "FlexibleTank_01_forest_F",
				"FlexibleTank_01_sand_F", "B_Slingload_01_Repair_F", "B_Slingload_01_Medevac_F", "B_Slingload_01_Ammo_F",
				"B_Slingload_01_Fuel_F", "B_Slingload_01_Repair_F", "Land_RepairDepot_01_civ_F", "Land_RepairDepot_01_green_F",
				"Land_RepairDepot_01_tan_F", "Land_Pod_Heli_Transport_04_ammo_F", "Land_Pod_Heli_Transport_04_box_F",
				"Land_Pod_Heli_Transport_04_fuel_F", "Land_Pod_Heli_Transport_04_repair_F", "Land_Metal_Shed_F", "Land_CarService_F"];

_txt = format ["Primary Objectives:<br></br><br></br>

		1.  Eliminate the Prime Minister in <marker name='marker_3'>Pyrgos</marker>.<br></br>
		2.  Eliminate the General in <marker name='marker_1'>Kavala</marker>.<br></br>
		3.  Eliminate the Cardinal in <marker name='marker_2'>Selakano</marker>.<br></br>
		
		"];
		
_txtB = "Secondary Objectives:<br></br><br></br>
		
		1.  Fight the war, and eliminate 90% of Rose sponsored Insurgents.<br></br>";
		
_txt0 = format ["One Life - Civil War Survival
		<br></br><br></br>
		It has been 10 years since the last of the infected were put down, and society has been struggling to rebuild.  The survivors of the apocalypse have limited access to goods, and everyone survives off scavenging what supplies remain.  Governments of the world have all but collapsed, and only two Globalist factions remain:
		<br></br><br></br>
		Blue Team:<br></br>The Rhino's, a Pro-Government organization lead by self appointed femenist and psychotic despot with an exceptionally fragile ego, Prime Minister Tristan Jeneau.
		<br></br><br></br>
		Red Team:<br></br>The Rose Foundation, a religious group who manipulates scientific discovery to drive their agenda. Lead by The General and his propoganda minister Dr. Tony 'The Cardinal' Fuccetti, former biologist.
		<br></br><br></br>
		In April 2064, documents were discovered revealing that the Zombie Apocalypse in the Republic of Chernarus (circa 2008), which spread to other platforms.. er.. Countries, in 2012, began as a result of Dr. Fuccetti's failure to synthesize an mRNA vaccine to cure the common flu.
		<br></br><br></br>
		This discovery sparked a global civil war, which has now been raging for almost 10 years.
		<br></br><br></br>
		Your mission is to end it, before humanity goes extinct.  You must assassinate Tristan Jeneau, Dr. Fuccetti, and  the Rose Foundations head of security, known only as The General.
		<br></br><br></br>
		Eliminate the three targets while navigating a brutal civil war.
		<br></br><br></br>
		Good luck."];

_index2 = player createDiarySubject ["obj","Mission Overview"];
player createDiaryRecord ["obj", ["Secondary Objectives", _txtB]];
player createDiaryRecord ["obj", ["Primary Objectives", _txt]];
player createDiaryRecord ["obj", ["Mission Overview", _txt0]];
