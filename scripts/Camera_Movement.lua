local intensity = 25
local angleIntensity = 1

local offset = {
    x = 0,
    y = 0,
    angle = 0
}

function goodNoteHit(index, noteData, noteType, isSustain)
    if mustHitSection then moveCam(noteData) end
end

function opponentNoteHit(index, noteData, noteType, isSustain)
    if not mustHitSection then moveCam(noteData) end
end

function moveCam(index)
    if index == 0 then setOffsetPos({-intensity, 0, -angleIntensity}) end
    if index == 1 then setOffsetPos({0, intensity, 0}) end
    if index == 2 then setOffsetPos({0, -intensity, 0}) end
    if index == 3 then setOffsetPos({intensity, 0, angleIntensity}) end
end

function setOffsetPos(posArray)
    offset.x = posArray[1]
    offset.y = posArray[2]
    offset.angle = posArray[3]
end

function onUpdate(elapsed)
    -- doing ts with setProperty cuz callMethod doesn't exist in 0.6.3

    setProperty('camGame.targetOffset.x', lerp(getProperty('camGame.targetOffset.x'), offset.x, elapsed * 2.4 * getProperty('cameraSpeed') * playbackRate))
    setProperty('camGame.targetOffset.y', lerp(getProperty('camGame.targetOffset.y'), offset.y, elapsed * 2.4 * getProperty('cameraSpeed') * playbackRate))
    setProperty('camGame.angle', lerp(getProperty('camGame.angle'), offset.angle, elapsed * 2.4 * getProperty('cameraSpeed') * playbackRate))

    if not stringStartsWith(getProperty((mustHitSection and "boyfriend" or "dad")..'.animation.curAnim.name'), "sing") then setOffsetPos({0, 0, 0}) end
end

function lerp(a, b, t) return a + (b - a) * t end

function boundTo(val, max) return val > max and max or val end