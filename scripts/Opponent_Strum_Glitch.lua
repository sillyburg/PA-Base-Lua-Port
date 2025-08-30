local intensities = {

}

function onCreatePost()
    for i = 0,3 do
        setSpriteShader('opponentStrums.members['..i..']', 'distort')
        setShaderFloat('opponentStrums.members['..i..']', 'binaryIntensity', getRandomFloat(4, 6))
        setShaderFloat('opponentStrums.members['..i..']', 'negativity', 0)
    end

    runTimer('UPDATE_GLITCH', stepCrochet / 1000)
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == "UPDATE_GLITCH" then
        for i = 0,3 do
            setShaderFloat('opponentStrums.members['..i..']', 'binaryIntensity', getRandomFloat(4, 6))
            callOnLuas("onStrumGlitchUpdate", {i})
        end

        runTimer('UPDATE_GLITCH', stepCrochet / 1000)
    end
end