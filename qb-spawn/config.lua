QB = {}

-- Enable spawning inside houses from the spawn selector
QB.EnableHouses = false

-- Enable spawning inside apartments from the spawn selector
QB.EnableApartments = false

QB.Spawns = {
    ["emerald"] = {
        coords = {
            x = 1417.818, 
            y = 268.0298, 
            z = 89.61942, 
            h = 144.5 
        },
        location = "emerald",
        label = "Emerald Ranch Fence",
    },

    ["rhodesst"] = {
        coords = {
            x = 1359.575, 
            y = -1301.451, 
            z = 77.76775, 
            h = 3.5 
        },
        location = "rhodesst",
        label = "Rhodes Sheriff Station",
    }
}

QB.DefaultSpawn = {
    ["default"] = {
        coords = {
            x = 1359.575, 
            y = -1301.451, 
            z = 77.76775, 
            h = 3.5 
        },
        location = "default",
        label = "Default Spawn"
    }
}
