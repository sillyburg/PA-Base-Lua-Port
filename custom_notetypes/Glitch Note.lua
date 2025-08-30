local char = "dad" -- change if u wanna glitch another character
local noteName = "Glitch Note" -- change to the note type's name

function opponentNoteHit(index, noteData, noteType, isSustain)
    if noteType == noteName and not isSustain then glitchOutChar(index) end
end

function glitchOutChar(noteIndex)
    local sus = 0

    if getProperty('notes.members['..noteIndex..'].sustainLength') > 0 then
        sus = getProperty('notes.members['..noteIndex..'].sustainLength') / 1000
    end

    setSpriteShader(char, "distort")
    setShaderFloat(char, "negativity", 1)
    setShaderFloat(char, "binaryIntensity", getRandomFloat(-1, -0.5))

    for i, v in pairs({
        {'opponentStrums.members[0]', defaultOpponentStrumX0, defaultOpponentStrumY0},
        {'opponentStrums.members[1]', defaultOpponentStrumX1, defaultOpponentStrumY1},
        {'opponentStrums.members[2]', defaultOpponentStrumX2, defaultOpponentStrumY2},
        {'opponentStrums.members[3]', defaultOpponentStrumX3, defaultOpponentStrumY3}
    }) do
        setProperty(v[1]..'.x', v[2] + getRandomFloat(-8, 8))
        setProperty(v[1]..'.y', v[3] + getRandomFloat(-8, 8))
    end

    runTimer("removeShader_"..char, sus + getRandomFloat(0.0475, 0.085))
    callOnLuas("onGlitchChar", {char})
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == "removeShader_"..char then
        removeSpriteShader(char)
        callOnLuas('onUnglitchChar', {char})
    end
end