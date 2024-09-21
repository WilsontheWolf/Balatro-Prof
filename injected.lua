PROF_CAPTURE = true
prof = require("jprof")
PROF_LOGGER = {
    log = print,
    debug = print,
    info = print,
    warn = print,
    error = print
}
PROF_ENABLED = false

local success, dpAPI = pcall(require, "debugplus-api")
if success and dpAPI.isVersionCompatible(0) then
    local debugplus = dpAPI.registerID("Profiler")
    PROF_LOGGER = debugplus.logger
end
prof.enabled(false)

debug.sethook(function(type)
    if not PROF_IN_FRAME then return end
    local db = debug.getinfo(3, 'n')
    prof.push(db.namewhat .. ":" .. db.name)
end, "c")
debug.sethook(function(type)
    if not PROF_IN_FRAME then return end
    local db = debug.getinfo(3, 'n')
    prof.pop()
end, "r")


