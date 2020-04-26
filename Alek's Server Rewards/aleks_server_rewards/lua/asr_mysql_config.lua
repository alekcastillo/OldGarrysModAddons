--[[

███╗   ███╗██╗   ██╗███████╗ ██████╗ ██╗
████╗ ████║╚██╗ ██╔╝██╔════╝██╔═══██╗██║
██╔████╔██║ ╚████╔╝ ███████╗██║   ██║██║
██║╚██╔╝██║  ╚██╔╝  ╚════██║██║▄▄ ██║██║
██║ ╚═╝ ██║   ██║   ███████║╚██████╔╝███████╗
╚═╝     ╚═╝   ╚═╝   ╚══════╝ ╚══▀▀═╝ ╚══════╝

]]

ASR.UseMySQL = false
--[[ Set this to true if you want to save all the server rewards data on a MySQL
database. Please, keep in mind that this is still a wip, it should work, but it might
have some issues here and there, so please be patient if using it, and open a support
ticket if you have any issue with it. ]]

ASR.MySQLModule = 1
--[[ This is the MySQL module you want the script to use in order to save data. It can
either be 1 for tmysql4 (recommended) or 2 for mysqloo (not recommended). ]]

ASR.DB_Host = "localhost"
ASR.DB_Username = "root"
ASR.DB_Password = "1234"
ASR.DB_Name = "gmodserver"
ASR.DB_Port = 3306
