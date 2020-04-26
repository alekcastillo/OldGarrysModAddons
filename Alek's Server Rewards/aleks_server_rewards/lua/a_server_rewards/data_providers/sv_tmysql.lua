//Functions

function AsrConnectToDatabase()
	asr_db, asr_err = tmysql.initialize(ASR.DB_Host, ASR.DB_Username, ASR.DB_Password, ASR.DB_Name, ASR.DB_Port)

	if asr_db and !asr_err then
		print(ASR.ChatTag.." The connection with the database has been successful!")

		sqlSuccess = true
	else
		print(ASR.ChatTag.." A problem ocurred while connecting to the database; using the text library instead!\nThe error: "..asr_err)
	end
end

function AsrQuery(query, callback)
	local function onResults(results)
		if callback != nil then
			if results[1]["data"] != nil and !results[1]["error"] then
				callback(results[1]["data"])
			else
				callback(false)
			end
		end
	end

	asr_db:Query(query, onResults)
end

//Init
require("tmysql4")
AsrConnectToDatabase()
