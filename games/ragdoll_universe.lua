local PlayerUtilities = {} 

function PlayerUtilities:IsPlayerAlive(Player)
    local Character = Player.Character
    local Humanoid = (Character and Character:FindFirstChildWhichIsA("Humanoid"))

    if Character and Humanoid then
        if Humanoid.Health > 0 then
            return true
        end
    end

    return false
end

function PlayerUtilities:GetHealth(Player)
    local Character = Player.Character
    local Humanoid = (Character and Character:FindFirstChildWhichIsA("Humanoid"))

    if Character and Humanoid then
        return {
            CurrentHealth = Humanoid.Health,
            MaxHealth = Humanoid.MaxHealth
        }
    end
end

function PlayerUtilities:GetBodyParts(Player)
    local Character = Player.Character
    local Head = (Character and Character:FindFirstChild("Head"))
    local Torso = Character and (Character:FindFirstChild("LowerTorso") or Character:FindFirstChild("Torso"))
    local LeftArm = Character and (Character:FindFirstChild("LeftLowerArm") or Character:FindFirstChild("Left Arm"))
    local RightArm = Character and (Character:FindFirstChild("RightLowerArm") or Character:FindFirstChild("Right Arm"))
    local LeftLeg = Character and (Character:FindFirstChild("LeftLowerLeg") or Character:FindFirstChild("Left Leg"))
    local RightLeg = Character and (Character:FindFirstChild("RightLowerLeg") or Character:FindFirstChild("Right Leg"))

    if Character and (Head and Torso and LeftArm and RightArm and LeftLeg and RightLeg) then
        return {
            Character = Character,
            Head = Head,
            Torso = Torso,
            LeftArm = LeftArm,
            RightArm = RightArm,
            LeftLeg = LeftLeg,
            RightLeg = RightLeg
        }
    end
end

function PlayerUtilities:GetTeamColor(Player)
    return Player.TeamColor.Color
end

function PlayerUtilities:IsOnClientTeam(Player)
    if game.Players:GetService("Players").LocalPlayer.Team == Player.Team then
        return true
    end

    return false
end

function PlayerUtilities:GetDistanceFromClient(Position)
    return game.Players:GetService("Players").LocalPlayer:DistanceFromCharacter(Position)
end

function PlayerUtilities:GetClosestPlayer()
    local ClosestPlayer = nil
    local FarthestDistance = math.huge

    for Index, Player in pairs(Players:GetPlayers()) do
        if Player == game.Players:GetService("Players").LocalPlayer then continue end
    
        local PassedTeamCheck = true
        local IsPlayerAlive = PlayerUtilities:IsPlayerAlive(Player)
        local Health = PlayerUtilities:GetHealth(Player)
        local BodyParts = PlayerUtilities:GetBodyParts(Player)
        local IsOnClientTeam = PlayerUtilities:IsOnClientTeam(Player)
    
        if Library.flags["Aimbot Team Check"] and IsOnClientTeam then
            PassedTeamCheck = false
        end
    
        if IsPlayerAlive and Health and BodyParts and PassedTeamCheck then
            local ScreenPosition, OnScreen = Visuals:GetScreenPosition(BodyParts.Root.Position)

            if ScreenPosition and OnScreen then
                local MouseDistance = (ScreenPosition - UserInputService:GetMouseLocation()).Magnitude

                if MouseDistance < FarthestDistance then
                    if Library.flags["Aimbot Use FOV"] then
                        if MouseDistance <= Library.flags["Aimbot FOV Radius"] then
                            FarthestDistance = MouseDistance
                            ClosestPlayer = {
                                Player = Player,
                                BodyParts = BodyParts
                            }
                        end
                    else
                        FarthestDistance = MouseDistance
                        ClosestPlayer = {
                            Player = Player,
                            BodyParts = BodyParts
                        }
                    end
                end
            end
        end
    end

    return ClosestPlayer
end

function PlayerUtilities:AimAt(Position, Smoothing)
    local MouseLocation = UserInputService:GetMouseLocation()
    MoveMouse(((Position.X - MouseLocation.X) / Smoothing), ((Position.Y - MouseLocation.Y) / Smoothing))
end

return PlayerUtilities
