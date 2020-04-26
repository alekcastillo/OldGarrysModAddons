
//DON'T EDIT ANY OF THESE SETTINGS WITH THE SERVER ON, IF WILL CAUSE LUA PROBLEMS!

CartoonHudConfig = {}

/*

 ██████╗ ███████╗███╗   ██╗███████╗██████╗  █████╗ ██╗         ██╗  ██╗██╗   ██╗██████╗     ███████╗███████╗████████╗████████╗██╗███╗   ██╗ ██████╗ ███████╗
██╔════╝ ██╔════╝████╗  ██║██╔════╝██╔══██╗██╔══██╗██║         ██║  ██║██║   ██║██╔══██╗    ██╔════╝██╔════╝╚══██╔══╝╚══██╔══╝██║████╗  ██║██╔════╝ ██╔════╝
██║  ███╗█████╗  ██╔██╗ ██║█████╗  ██████╔╝███████║██║         ███████║██║   ██║██║  ██║    ███████╗█████╗     ██║      ██║   ██║██╔██╗ ██║██║  ███╗███████╗
██║   ██║██╔══╝  ██║╚██╗██║██╔══╝  ██╔══██╗██╔══██║██║         ██╔══██║██║   ██║██║  ██║    ╚════██║██╔══╝     ██║      ██║   ██║██║╚██╗██║██║   ██║╚════██║
╚██████╔╝███████╗██║ ╚████║███████╗██║  ██║██║  ██║███████╗    ██║  ██║╚██████╔╝██████╔╝    ███████║███████╗   ██║      ██║   ██║██║ ╚████║╚██████╔╝███████║
 ╚═════╝ ╚══════╝╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝    ╚═╝  ╚═╝ ╚═════╝ ╚═════╝     ╚══════╝╚══════╝   ╚═╝      ╚═╝   ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚══════╝
                                                                                                                                                            
*/

CartoonHudConfig.AutoDownloadMaterials = true

CartoonHudConfig.ShowAvatar = true

CartoonHudConfig.ShowHunger = false

CartoonHudConfig.PlayersHPMode = 2
/* This controls how the HP is shown
on top of every player's head.
0 = Doesn't show the HP of other players.
1 = Shows the HP number on top of his job in a simplistic way.
2 = Shows an the HP number on top of the player's name, right to an HP icon.*/

/*

████████╗███████╗██╗  ██╗████████╗    ███████╗███████╗████████╗████████╗██╗███╗   ██╗ ██████╗ ███████╗
╚══██╔══╝██╔════╝╚██╗██╔╝╚══██╔══╝    ██╔════╝██╔════╝╚══██╔══╝╚══██╔══╝██║████╗  ██║██╔════╝ ██╔════╝
   ██║   █████╗   ╚███╔╝    ██║       ███████╗█████╗     ██║      ██║   ██║██╔██╗ ██║██║  ███╗███████╗
   ██║   ██╔══╝   ██╔██╗    ██║       ╚════██║██╔══╝     ██║      ██║   ██║██║╚██╗██║██║   ██║╚════██║
   ██║   ███████╗██╔╝ ██╗   ██║       ███████║███████╗   ██║      ██║   ██║██║ ╚████║╚██████╔╝███████║
   ╚═╝   ╚══════╝╚═╝  ╚═╝   ╚═╝       ╚══════╝╚══════╝   ╚═╝      ╚═╝   ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚══════╝
                                                                                                      
*/

CartoonHudConfig.NoAgendaText = "There's no agenda set!"

CartoonHudConfig.GunLicenseText = "You have a valid gun license"

CartoonHudConfig.WantedText = "You are wanted by the police!"

CartoonHudConfig.PlayerWantedText = "Wanted!"

CartoonHudConfig.LockdownTitle = "Lockdown!"

CartoonHudConfig.LockdownSubtitle = "Everyone outside will be arrested on sight!"

/*

██╗      █████╗ ██╗    ██╗███████╗    ███████╗███████╗████████╗████████╗██╗███╗   ██╗ ██████╗ ███████╗
██║     ██╔══██╗██║    ██║██╔════╝    ██╔════╝██╔════╝╚══██╔══╝╚══██╔══╝██║████╗  ██║██╔════╝ ██╔════╝
██║     ███████║██║ █╗ ██║███████╗    ███████╗█████╗     ██║      ██║   ██║██╔██╗ ██║██║  ███╗███████╗
██║     ██╔══██║██║███╗██║╚════██║    ╚════██║██╔══╝     ██║      ██║   ██║██║╚██╗██║██║   ██║╚════██║
███████╗██║  ██║╚███╔███╔╝███████║    ███████║███████╗   ██║      ██║   ██║██║ ╚████║╚██████╔╝███████║
╚══════╝╚═╝  ╚═╝ ╚══╝╚══╝ ╚══════╝    ╚══════╝╚══════╝   ╚═╝      ╚═╝   ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚══════╝
                                                                                                      
*/

CartoonHudConfig.ActivatePredifinedLaws = true
/* Set this to true if you want to activate the custom predifined laws system,
and its lawboard */

CartoonHudConfig.LawsBoardTitle = "Your cool server's laws | Red = Illegal | Green = Legal |"
/*The title of the laws board */

CartoonHudConfig.DisableLawsWhenNoMayor = false
/* Set this to true if you want the laws to be disabled when there's no mayor on the city */

CartoonHudConfig.ViewOrChangeLawsCommand = "laws"
/* The command used to open the lawsboard, and to edit the laws as a mayor */

CHS_Laws = 
/* Only edit this if you have CartoonHudConfig.ActivatePredifinedLaws set to true.
If not, this won't even load up, and the game will run with the default lawboards
system.

You can add as many laws as you want, however, use the format correctly for all of them!
Format = 
   WRITE HERE THE LAW ITSELF			IS IT LEGAL OR ILLEGAL?	  CAN IT BE CHANGED BY THE MAYOR?
	{	"LAW",								"legal"/"illegal",	  true/false}, */
{
	{	"Raiding",								"illegal",			false},
	{	"Murder",								"illegal",			false},
	{	"Money Printing",						"illegal",			true},
	{	"Placing / Asking for hits",			"legal",			true},
	{	"Using / selling drugs",				"legal",			true},
	{	"Small arms without a license",			"legal",			true},
	{	"Heavy arms without a license",			"legal",			true},
	{	"Guns out in public",					"legal",			true},
	{	"Reckless driving/street racing",		"legal",			true},
	{	"Placing hits",							"legal",			true},
	{	"Self-Defense Killing",					"legal",			true} --DON'T ADD "," IN THE LAST LINE!
}