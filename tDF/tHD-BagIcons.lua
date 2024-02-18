-- Iterate through each bag (0 is backpack, 1-4 are the bag slots)
for bag = 0, 4 do
    -- Get the number of slots in the bag
    local size = GetContainerNumSlots(bag)
    -- Iterate through each slot in the bag
    for slot = 1, size do
        -- Get the frame for the bag slot
        local frame = getglobal("ContainerFrame" .. bag+1 .. "Item" .. slot)
        if frame then
            -- Create a texture for the frame
            local texture = frame:CreateTexture(nil, "BACKGROUND")
            -- Set the texture to your custom image
            texture:SetTexture("Interface\\AddOns\\tDF\\img\\bagicons.tga")
            -- Set the size of the texture to match the size of the frame
            texture:SetWidth(frame:GetWidth())
            texture:SetHeight(frame:GetHeight())
            -- Position the texture to cover the entire frame
            texture:SetAllPoints(frame)
        end
    end
end