--[[
    onShaderCreate is NOT an actual psych function
    i called it because i was paranoid
]]

local _shaderIntensity = 0 -- don't remove, sets the chromatic aberration
local zoomIntensity = 0.08 -- default zoom intensity

function onShaderCreate()
    makeLuaSprite('_shader_zoom', nil, 0, 0)
    setSpriteShader('_shader_zoom', 'aberrationCam')
    setShaderFloat('_shader_zoom', 'aberration', 0.08)

    if shadersEnabled then
        runHaxeCode([[
            for (camLol in [game.camGame, game.camHUD]) camLol._filters.push(new ShaderFilter(game.getLuaObject("_shader_zoom").shader));

            game.callOnLuas("onShaderAdd", ["zoom"]);
        ]])
    end
end

function onBeatHit()
    if curBeat % 4 == 0 and cameraZoomOnBeat and getProperty("camZooming") then doChromZoom() end
end

function onEvent(event, value1, value2, strumTime)
    if event == "Add Camera Zoom" then doChromZoom() end
end

function doChromZoom()
    _shaderIntensity = 0.08 * getProperty('camZoomingMult')
end

function onUpdate(elapsed)
    _shaderIntensity = lerp(_shaderIntensity, 0, elapsed * 6)

    setShaderFloat('_shader_zoom', 'aberration', _shaderIntensity)
end

function lerp(a, b, t) return a + (b - a) * t end