/*
	File: fn_clothing_bruce.sqf
	Author: Bryan "Tonic" Boardwine
	
	Edited by: [noLife]casp0or
	
	Description:
	Master configuration file for VIP Clothing Store.
*/
private["_filter"];
_filter = [_this,0,0,[0]] call BIS_fnc_param;
//Classname, Custom Display name (use nil for Cfg->DisplayName, price

//Shop Title Name
ctrlSetText[3103,"Feuerwehr Kleiderladen"];

switch (_filter) do
{
	//Uniforms
	case 0:
	{
		[
			["U_C_WorkerCoveralls","Feuerwehr Uniform",25]		
		];
	};
	
	//Hats
	case 1:
	{
		[
			["H_Cap_usblack",nil,50]
		];
	};
	
	//Glasses
	case 2:
	{
		[
			["G_Shades_Black",nil,25],
			["G_Shades_Blue",nil,20],
			["G_Sport_Blackred",nil,20],
			["G_Sport_Checkered",nil,20],
			["G_Sport_Blackyellow",nil,20],
			["G_Sport_BlackWhite",nil,20],
			["G_Aviator",nil,75],
			["G_Squares",nil,10],
			["G_Lowprofile",nil,30],
			["G_Combat",nil,55]
		];
	};
	
	//Vest
	case 3:
	{
		[
		
		];
					
			
	};
	
	//Backpacks
	case 4:
	{
		[
			["B_Kitbag_cbr",nil,800]
		];
	};
};
