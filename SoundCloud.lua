--credentials missing
scriptTitle = "SoundCloud Connector"

enable_Connector=0
cur_angle=0

function playpause_track()adsa
	-- body
	if platform == "Windows" or platform == "MacOS" then
		myo.keyboard("space", "press")
	end
end

function next_track()
	-- body
	if platform == "Windows" or platform == "MacOS" then
		myo.keyboard("right_arrow", "press", "shift")
	end
end

function previous_track()
	-- body
	if platform == "Windows" or platform == "MacOS" then
		myo.keyboard("left_arrow", "press", "shift")
	end
end

function seek_foward()
	-- body
	if platform == "Windows" or platform == "MacOS" then
		myo.keyboard("right_arrow", "press")
	end
end

function seek_backward()
	-- body
	if platform == "Windows" or platform == "MacOS" then
		myo.keyboard("left_arrow", "press")
	end
end

function onPoseEdge( pose, edge )

    divider0 = PACE_PARAMETER_FOR_SLOWEST_SEEKING
    divider1 = PACE_PARAMETER_FOR_SLOW_SEEKING
    divider2 = PACE_PARAMETER_FOR_ABITFASTER_SEEKING
    divider3 = PACE_PARAMETER_FOR_ABITMOREFASTER_SEEKING
    divider4 = PACE_PARAMETER_FOR_FAST_SEEKING
    divider5 = PACE_PARAMETER_FOR_SLOWEST_SEEKING
    divider6 = PACE_PARAMETER_FOR_SLOW_SEEKING
    divider7 = PACE_PARAMETER_FOR_ABITFASTER_SEEKING
	divider8 = PACE_PARAMETER_FOR_ABITMOREFASTER_SEEKING
    divider9 = PACE_PARAMETER_FOR_FAST_SEEKING
 	milisec = myo.getTimeMilliseconds()

 	pose = conditionallySwapWave(pose) --check for left handed

		if edge=="on" then
			if pose=="fingersSpread" then
				playpause_track()
			elseif pose=="waveOut" then
				next_track()
			elseif pose=="waveIn" then
				previous_track()
			end
			myo.unlock("timed")
		end

		if pose=="fist" then

			seekActive= edge == "on";
        	cur_angle=getMyoRollDegrees()
        	if edge=="off" then
         	   --myo.lock()
         	   myo.unlock("timed")
        	else
           	   myo.unlock("hold")
        	end
		end


end

function conditionallySwapWave(pose)
    if myo.getArm() == "left" then
        if pose == "waveIn" then
            pose = "waveOut"
        elseif pose == "waveOut" then
            pose = "waveIn"
        end
    end
    return pose
end

function getMyoRollDegrees()
    local degrees = math.deg(myo.getRoll())
    return degrees
end

PACE_PARAMETER_FOR_SLOWEST_SEEKING = 1400
PACE_PARAMETER_FOR_SLOW_SEEKING = 1050
PACE_PARAMETER_FOR_ABITFASTER_SEEKING = 700
PACE_PARAMETER_FOR_ABITMOREFASTER_SEEKING = 350
PACE_PARAMETER_FOR_FAST_SEEKING = 150

function onActiveChange(isActive)
    if not isActive then
        dif_angle = 0
        divider0 = PACE_PARAMETER_FOR_SLOWEST_SEEKING
        divider1 = PACE_PARAMETER_FOR_SLOW_SEEKING
        divider2 = PACE_PARAMETER_FOR_ABITFASTER_SEEKING
        divider3 = PACE_PARAMETER_FOR_ABITMOREFASTER_SEEKING
        divider4 = PACE_PARAMETER_FOR_FAST_SEEKING
        divider5 = PACE_PARAMETER_FOR_SLOWEST_SEEKING
        divider6 = PACE_PARAMETER_FOR_SLOW_SEEKING
        divider7 = PACE_PARAMETER_FOR_ABITFASTER_SEEKING
		divider8 = PACE_PARAMETER_FOR_ABITMOREFASTER_SEEKING
        divider9 = PACE_PARAMETER_FOR_FAST_SEEKING
    end
end

function onPeriodic( )
	-- body
	 local time = myo.getTimeMilliseconds()

	if seekActive == true then

		dif_angle=degreeDiff(getMyoRollDegrees(),cur_angle)

		--myo.debug(dif_angle)
		if dif_angle>0 then --SEEK FOWARD
			if dif_angle<1.7 then
				if (time-milisec)/divider0 > 1 then
					divider0 = divider0 + PACE_PARAMETER_FOR_SLOWEST_SEEKING
					seek_foward()
					--myo.debug("poluxalaro +")
					--myo.debug(dif_angle)
				end
			elseif dif_angle<3.4 then
				if (time-milisec)/divider1 > 1 then
					divider1 = divider1 + PACE_PARAMETER_FOR_SLOW_SEEKING
					seek_foward()
					--myo.debug("xalaro +")
					--myo.debug(dif_angle)
				end
			elseif dif_angle<5 then
				if (time-milisec)/divider2 > 1 then
					divider2 = divider2 + PACE_PARAMETER_FOR_ABITFASTER_SEEKING
					seek_foward()
					--myo.debug("ligoooo +")
					--myo.debug(dif_angle)
				end
			elseif dif_angle<7 then
				if (time-milisec)/divider3 > 1 then
					divider3 = divider3 + PACE_PARAMETER_FOR_ABITMOREFASTER_SEEKING
					seek_foward()
					--myo.debug("piopolu +")
					--myo.debug(dif_angle)
				end
			elseif dif_angle<8.4 then
				if (time-milisec)/divider4 > 1 then
					divider4 = divider4 + PACE_PARAMETER_FOR_FAST_SEEKING
					seek_foward()
					--myo.debug("GRIpolu +")
					--myo.debug(dif_angle)
				end
			else
				seek_foward()
				--myo.debug("grigoro +")
				--myo.debug(dif_angle)
			end
		elseif dif_angle<0 then --SEEK BACKWARD
			if dif_angle>-1.7 then
				if (time-milisec)/divider5 > 1 then
					divider5 = divider5 + PACE_PARAMETER_FOR_SLOWEST_SEEKING
					seek_backward()
					--myo.debug("poluxalaro -")
					--myo.debug(dif_angle)
				end
			elseif dif_angle>-3.4 then
				if (time-milisec)/divider6 > 1 then
					divider6 = divider6 + PACE_PARAMETER_FOR_SLOW_SEEKING
					seek_backward()
					--myo.debug("xalaro -")
					--myo.debug(dif_angle)
				end
			elseif dif_angle>-5 then
				if (time-milisec)/divider7 > 1 then
					divider7 = divider7 + PACE_PARAMETER_FOR_ABITFASTER_SEEKING
					seek_backward()
					--myo.debug("ligoooo -")
				--	myo.debug(dif_angle)
				end
			elseif dif_angle>-7 then
				if (time-milisec)/divider8 > 1 then
					divider8 = divider8 + PACE_PARAMETER_FOR_ABITMOREFASTER_SEEKING
					seek_backward()
					--myo.debug("piopolu -")
				--	myo.debug(dif_angle)
				end
			elseif dif_angle>-8.4 then
				if (time-milisec)/divider9 > 1 then
					divider9 = divider9 + PACE_PARAMETER_FOR_FAST_SEEKING
					seek_backward()
					--myo.debug("GRIpolu -")
				--	myo.debug(dif_angle)
				end
			else
				seek_backward()
				--myo.debug("grigoro -")
			--	myo.debug(dif_angle)
			end
		end

	end

end

function degreeDiff(value, base)
    local diff = value - base

    if diff > 180 then
        diff = diff - 360
    elseif diff < -180 then
        diff = diff + 360
    end
    return diff
end

function onForegroundWindowChange(app, title)
	--Updated
	if platform == "Windows" then
		if string.match(title, "%| Free Listening on SoundCloud") or string.match(title, "%Your stream on SoundCloud") or string.match(title, "%you follow on SoundCloud") or string.match(title, "% - Hear ") or string.match(title, "% by ") and (app == "chrome.exe" or app == "firefox.exe" or app == "iexplore.exe")  then
			myo.vibrate("short")
			return true
		end
	elseif platform=="MacOS" then
		if string.match(title, "%| Free Listening on SoundCloud") or string.match(title, "%Your stream on SoundCloud") or string.match(title, "%you follow on SoundCloud") or string.match(title, "% - Hear ") or string.match(title, "% by ") and (app == "com.apple.Safari" or app == "com.google.Chrome" or app == "org.mozilla.firefox") then
			myo.vibrate("short")
	        return true
		end
	end
	return false
end

function activeAppName()
    return "SoundCloud"
end
