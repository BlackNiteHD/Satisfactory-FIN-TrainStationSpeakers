-- CUSTOMIZABLE VALUES
STATION = component.proxy("DBC6FDB444252BFFEA74FFAF36171B04") -- The ID of the station (use the Network Manager item)
SPEAKER = component.proxy("CEE6889D4A8756833BDE41A70E7B166D") -- The ID of the speaker (use the Network Manager item)
SPEAKER_VOLUME = 2                                            -- Volume Gain of the speaker
SPEAKER_RANGE = 7000                                          -- Range of the speaker (optimized for 1 station and 5 platforms)
ANNOUNCEMENT_DISTANCE = 100000                                -- The distance a train has to be to a station for the announcement to start (optimized for 1 station and 5 platforms)
TRAINS_TO_TAIL = {"Golden Coast Express"}                     -- List of the trains you want messages for
MSG_COUNT = 11                                                -- The amount of one liners minus 1 (only change if you tempered with the audio files for that)
USE_CUSTOM_AUDIO = true                                       -- If this is set to 'true' you NEED custom audio files (check the guide on how to make them), otherwise it will always call every train/station "Train" and "Station"
CALCULATION_INTERVAL = 2									  -- The interval (seconds) in which the distance between the tailed trains and the station is calculated

-- VARIABLES USED BY THE PROGRAM
stationX, _, stationZ = STATION:getLocation()
stationName = STATION.name
trackGraph = STATION:getTrackGraph()
trains = trackGraph:getTrains()
playing = false
inRange = false
stage = 0

-- SETUP THE SPEAKER
SPEAKER:setVolume(SPEAKER_VOLUME)
SPEAKER:setRange(SPEAKER_RANGE)
event.listen(SPEAKER)

-- MAIN
-- Optimizations are always welcome.
-- Just make a pull request on the repository to integrate your changes
while true do
    e, _, state = event.pull(CALCULATION_INTERVAL)

    for _,train in ipairs(trains) do
        for _,tailedTrain in ipairs(TRAINS_TO_TAIL) do
            if train:getName() == tailedTrain then
			    locomotive = train:getMaster()
				
				-- Prevents the program to run into errors when loading the save
				-- When loading the save train:getMaster() returns nil
				if locomotive then
					trainX, _, trainZ = locomotive:getLocation()
					-- Why the fuck does math.pow not exist!?
					distanceX = math.abs((stationX * stationX) - (trainX * trainX))
					distanceZ = math.abs((stationZ * stationZ) - (trainZ * trainZ))
					distance = math.sqrt(distanceX + distanceZ)
					timeTable = train:getTimeTable()
					nextStop = timeTable:getStop(timeTable:getCurrentStop()).station.name

					if e == "SpeakerSound" and state == 2 then
						if stage == 1 then
							if USE_CUSTOM_AUDIO then
								SPEAKER:playSound("trains/" .. tailedTrain)
							else
								SPEAKER:playSound("trains/default")
							end
							
							stage = 2
						elseif stage == 2 then
							if nextStop == stationName then
								SPEAKER:playSound("arrivingat")
							else
								SPEAKER:playSound("commingthrough")
							end
                        
							stage = 3
						elseif stage == 3 then
							if USE_CUSTOM_AUDIO then
								SPEAKER:playSound("stations/" .. stationName)
							else
								SPEAKER:playSound("stations/default")
							end
							
							stage = 4
						elseif stage == 4 then
							SPEAKER:playSound("msg/msg" .. math.random(0, MSG_COUNT))
							stage = 5
						else
							playing = false
							stage = 0
						end
					end

					if distance > ANNOUNCEMENT_DISTANCE and inRange then
						inRange = false
					end

					if distance <= ANNOUNCEMENT_DISTANCE and not playing and not inRange then
						SPEAKER:playSound("announcement")
						stage = 1
						playing = true
						inRange = true
					end
				end
            end
        end
    end
end