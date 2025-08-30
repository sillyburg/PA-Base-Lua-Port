local _shaderIntensity = 0

function onCreatePost()
    makeLuaSprite('_shader_sing', nil, 0, 0)
    setSpriteShader('_shader_sing', 'Pibbified')
    setShaderFloat('_shader_sing', 'iMouseX', 500)
    setShaderFloat('_shader_sing', 'glitchMultiply', 0)
    setShaderInt('_shader_sing', 'NUM_SAMPLES', 3)

    if shadersEnabled then
        runHaxeCode([[
            for (camLol in [game.camGame, game.camHUD]) camLol.setFilters([new ShaderFilter(game.getLuaObject("_shader_sing").shader)]);

            if (game.camGame._filters != null)
                game.callOnLuas("onShaderCreate", []);
        ]])
    end
end

local _time = 0

function opponentNoteHit(index, noteData, noteType, isSustain)
    if getRandomBool(50) then addChrom() end
end

function addChrom()
    _shaderIntensity = getRandomFloat(0.2, 0.7)

    callOnLuas('onSingChrom')
end

function onUpdate(elapsed)
    _time = _time + elapsed
    
    _shaderIntensity = lerp(_shaderIntensity, 0, elapsed * 7)

    setShaderFloat('_shader_sing', 'glitchMultiply', _shaderIntensity)
    setShaderFloat('_shader_sing', 'uTime', _time)
end

function lerp(a, b, t) return a + (b - a) * t end