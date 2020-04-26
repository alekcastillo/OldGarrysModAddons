//Functions

local function AsrConnectToDatabase()
	asr_db = mysqloo.connect(ASR.DB_Host, ASR.DB_Username, ASR.DB_Password, ASR.DB_Name, ASR.DB_Port)

	function asr_db:onConnected()
		print(ASR.ChatTag.." The connection with the database has been successful!")

		sqlSuccess = true

		AsrSendTables()
	end

	function asr_db:onConnectionFailed(err)
		print(ASR.ChatTag.." A problem ocurred while connecting to the database; using the text library instead!\nThe error: "..err)
	end

	asr_db:connect()
end

function AsrQuery(query, callback)
	local asr_query = asr_db:query(query)

	function asr_query:onSuccess(results)
		if callback != nil then
			if results != nil then
				callback(results)
			else
				callback(false)
			end
		end
	end

	function asr_query:onError(err, _)
		if asr_db:status() == mysqloo.DATABASE_NOT_CONNECTED then
			asr_db:connect()

			return
		elseif callback != nil then
			callback(false)
		end
	end

	asr_query:wait()
	asr_query:start()
end

//Init
require("mysqloo")
AsrConnectToDatabase()
