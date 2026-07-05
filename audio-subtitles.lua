local utils = require("mp.utils")
local msg = require("mp.msg")

local SUB_EXT = { ass = true, ssa = true, srt = true, vtt = true }

local function scan(dir, base)
    local files = utils.readdir(dir, "files")
    if files then
        for _, file in ipairs(files) do
            local lower = file:lower()

            if lower:sub(1, #base) == base then
                local ext = lower:match("%.([^%.]+)$")
                local path = dir .. "/" .. file

                if ext == "mka" then
                    msg.info("Loading audio: " .. path)
                    mp.commandv("audio-add", path, "auto")

                elseif SUB_EXT[ext] then
                    msg.info("Loading subtitles: " .. path)
                    mp.commandv("sub-add", path, "auto")
                end
            end
        end
    end

    local dirs = utils.readdir(dir, "dirs")
    if dirs then
        for _, subdir in ipairs(dirs) do
            scan(dir .. "/" .. subdir, base)
        end
    end
end

local function load_tracks()
    local path = mp.get_property("path")
    if not path then
        return
    end

    local root, video = utils.split_path(path)
    local base = video:gsub("%.[^.]+$", ""):lower()

    -- In the root we look only for subfolders
    local dirs = utils.readdir(root, "dirs")
    if dirs then
        for _, dir in ipairs(dirs) do
            scan(root .. "/" .. dir, base)
        end
    end

    -- Adding subtitles
    mp.set_property("sid", "no")

    -- Select the first external audio track
    mp.add_timeout(0.1, function()
        for _, track in ipairs(mp.get_property_native("track-list")) do
            if track.type == "audio" and track.external then
                mp.set_property_number("aid", track.id)
                return
            end
        end
    end)
end

mp.register_event("file-loaded", load_tracks)