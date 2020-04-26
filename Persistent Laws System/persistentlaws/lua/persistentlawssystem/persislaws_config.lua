PLS = {}

/*
  ________                                  .__      _________       __    __  .__                      
 /  _____/  ____   ____   ________________  |  |    /   _____/ _____/  |__/  |_|__| ____    ____  ______
/   \  ____/ __ \ /    \_/ __ \_  __ \__  \ |  |    \_____  \_/ __ \   __\   __\  |/    \  / ___\/  ___/
\    \_\  \  ___/|   |  \  ___/|  | \// __ \|  |__  /        \  ___/|  |  |  | |  |   |  \/ /_/  >___ \ 
 \______  /\___  >___|  /\___  >__|  (____  /____/ /_______  /\___  >__|  |__| |__|___|  /\___  /____  >
        \/     \/     \/     \/           \/               \/     \/                   \//_____/     \/ 

*/

PLS.LawsBoardTitle = "Your cool server's laws"
//The title of the laws board

PLS.DissableLawsWhenNoMayor = false
//Set this to true if you want the laws to be dissabled when there's no mayor on the city

PLS.ViewOrChangeLawsCommand = "laws"
//The command used to open the lawsboard, and to edit the laws as a mayor

PLS.AllowLawChangeRequesting = false
//Set this to true if you want normal citizens to have a button to protest again a certain law

/*
 ____ ___.___    _________       __    __  .__                      
|    |   \   |  /   _____/ _____/  |__/  |_|__| ____    ____  ______
|    |   /   |  \_____  \_/ __ \   __\   __\  |/    \  / ___\/  ___/
|    |  /|   |  /        \  ___/|  |  |  | |  |   |  \/ /_/  >___ \ 
|______/ |___| /_______  /\___  >__|  |__| |__|___|  /\___  /____  >
                       \/     \/                   \//_____/     \/ 

*/

PLS.LegalLawColor = Color(80,215,100,200)

PLS.IllegalLawColor = Color(255,68,68,200)

PLS.BackgroundColor = Color(50,50,50,185)

/*
.____                            _________       __    __  .__                      
|    |   _____ __  _  ________  /   _____/ _____/  |__/  |_|__| ____    ____  ______
|    |   \__  \\ \/ \/ /  ___/  \_____  \_/ __ \   __\   __\  |/    \  / ___\/  ___/
|    |___ / __ \\     /\___ \   /        \  ___/|  |  |  | |  |   |  \/ /_/  >___ \ 
|_______ (____  /\/\_//____  > /_______  /\___  >__|  |__| |__|___|  /\___  /____  >
        \/    \/           \/          \/     \/                   \//_____/     \/ 
                       
*/

PLS_Laws = 
/*
You can add as many laws as you want, seriosly, however, use the format correctly for all of them!
Format = 
   WRITE HERE THE LAW ITSELF			IS IT LEGAL OR ILLEGAL?	  CAN IT BE CHANGED BY THE MAYOR?
	{	"LAW",								"legal"/"illegal",	  true/false},
*/
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