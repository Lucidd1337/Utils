local PlayerUtilities = {}

function PlayerUtilities:IsPlayerAlive(Player)
    local Humanoid = Player.Character:FindFirstChildOfClass("Humanoid")
    local Health = (Humanoid and Humanoid.Health)
    if Humanoid and Health then
        if Health.Value > 0 then
            return true
        end
    end

    return false
end

function PlayerUtilities:GetHealth(Player)
    local Humanoid = Player.Character:FindFirstChildOfClass("Humanoid")
    local Health, MaxHealth = (Humanoid and Humanoid.Health), (Humanoid and Humanoid.MaxHealth)

    if Humanoid and Health and MaxHealth then
        return {
            CurrentHealth = Health.Value,
            MaxHealth = MaxHealth.Value
        }
    end
end

return PlayerUtilities
