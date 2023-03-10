for _,v in pairs(game.CoreGui:GetChildren()) do
    if v.Name == "UILibrary" then
        v:Destroy()
    end
end

local UILibrary = Instance.new("ScreenGui")
UILibrary.Name = "UILibrary"
UILibrary.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
UILibrary.Parent = game.CoreGui

local Library = {}

local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local HTTPService = game:GetService("HttpService")

function Library:DraggingEnabled(frame, parent)
    parent = parent or frame
    
    local dragging = false
    local dragInput, mousePos, framePos

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            mousePos = input.Position
            framePos = parent.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - mousePos
            parent.Position  = UDim2.new(framePos.X.Scale, framePos.X.Offset + delta.X, framePos.Y.Scale, framePos.Y.Offset + delta.Y)
        end
    end)
end

function Library:Create(table)
    local windowName = table.Name

    local main = Instance.new("Frame")
    main.Name = "main"
    main.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
    main.Position = UDim2.fromScale(0.244, 0.292)
    main.Size = UDim2.fromOffset(0, 0)
    main.ClipsDescendants = true
    
    local title = Instance.new("TextLabel")
    title.Name = "title"
    title.Font = Enum.Font.Gotham
    title.Text = windowName
    title.TextColor3 = Color3.fromRGB(168, 168, 168)
    title.TextSize = 20
    title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    title.BackgroundTransparency = 1
    title.Position = UDim2.fromScale(0.41, 0.0543)
    title.Size = UDim2.fromOffset(83, 28)
    title.Parent = main

    local uICorner = Instance.new("UICorner")
    uICorner.Name = "uICorner"
    uICorner.Parent = main

    local tabContainer = Instance.new("Frame")
    tabContainer.Name = "tabContainer"
    tabContainer.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
    tabContainer.Position = UDim2.fromScale(0.0342, 0.188)
    tabContainer.Size = UDim2.fromOffset(454, 30)

    local uICorner1 = Instance.new("UICorner")
    uICorner1.Name = "uICorner1"
    uICorner1.CornerRadius = UDim.new(0, 6)
    uICorner1.Parent = tabContainer

    local uIListLayout = Instance.new("UIListLayout")
    uIListLayout.Name = "uIListLayout"
    uIListLayout.Padding = UDim.new(0, 8)
    uIListLayout.FillDirection = Enum.FillDirection.Horizontal
    uIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    uIListLayout.Parent = tabContainer

    local uIPadding = Instance.new("UIPadding")
    uIPadding.Name = "uIPadding"
    uIPadding.PaddingLeft = UDim.new(0, 7)
    uIPadding.PaddingTop = UDim.new(0, 4)
    uIPadding.Parent = tabContainer

    Library:DraggingEnabled(main, main)
    
    tabContainer.Parent = main
    main.Parent = UILibrary
    main.AnchorPoint = Vector2.new(0.5,0.5)
    main.Position = UDim2.new(0.5,0,0.5,0)

    game:GetService('TweenService'):Create(main, TweenInfo.new(0.5), {Size = UDim2.fromOffset(488, 299)}):Play()

    local tabHandler = {}

    function tabHandler:Exit()
        game:GetService('TweenService'):Create(main, TweenInfo.new(0.5), {Size = UDim2.fromOffset(0, 0)}):Play()
        wait(0.5)
        for _,v in pairs(main:GetChildren()) do
            if v:IsA("TextLabel") or v:IsA("TextButton") then
                v:Destroy()
            end
        end
        UILibrary:Destroy()
    end

    function tabHandler:Tab(name)
        local main1 = Instance.new("TextButton")
        main1.Name = name
        main1.Font = Enum.Font.Gotham
        main1.Text = name
        main1.TextColor3 = Color3.fromRGB(195, 195, 195)
        main1.TextSize = 13
        main1.TextTransparency = 0.5
        main1.AutomaticSize = Enum.AutomaticSize.X
        main1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        main1.BackgroundTransparency = 1
        main1.Size = UDim2.fromOffset(10, 24)
        main1.Parent = tabContainer

        local container = Instance.new("Frame")
        container.Name = "container"
        container.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
        container.Position = UDim2.fromScale(0.0342, 0.31)
        container.Size = UDim2.fromOffset(454, 183)
        
        local uICorner2 = Instance.new("UICorner")
        uICorner2.Name = "uICorner2"
        uICorner2.CornerRadius = UDim.new(0, 6)
        uICorner2.Parent = container
        
        local holder = Instance.new("ScrollingFrame")
        holder.Name = "holder"
        holder.ScrollBarImageColor3 = Color3.fromRGB(76, 76, 76)
        holder.ScrollBarThickness = 2
        holder.ScrollingDirection = Enum.ScrollingDirection.Y
        holder.Active = true
        holder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        holder.BackgroundTransparency = 1
        holder.BorderColor3 = Color3.fromRGB(33, 33, 33)
        holder.Position = UDim2.fromScale(0.0022, 0.00404)
        holder.Size = UDim2.fromOffset(452, 182)

        local uIPadding1 = Instance.new("UIPadding")
        uIPadding1.Name = "uIPadding1"
        uIPadding1.PaddingLeft = UDim.new(0, 5)
        uIPadding1.PaddingTop = UDim.new(0, 7)
        uIPadding1.Parent = holder

        local uIListLayout1 = Instance.new("UIListLayout")
        uIListLayout1.Name = "uIListLayout1"
        uIListLayout1.Padding = UDim.new(0, 3)
        uIListLayout1.SortOrder = Enum.SortOrder.LayoutOrder
        uIListLayout1.Parent = holder

        local uICorner11 = Instance.new("UICorner")
        uICorner11.Name = "uICorner11"
        uICorner11.CornerRadius = UDim.new(0, 6)
        uICorner11.Parent = holder

        holder.Parent = container
        container.Parent = main
        container.Visible = false

        uIListLayout1:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            holder.CanvasSize = UDim2.new(0,0,0,uIListLayout1.AbsoluteContentSize.Y + 15) 
        end)

        main1.MouseButton1Click:Connect(function()
            for _,v in pairs(game.CoreGui:FindFirstChild('UILibrary').main:GetChildren()) do
                if v.Name == "container" then
                    v.Visible = false
                end
            end
            for _,v in pairs(game.CoreGui['UILibrary'].main.tabContainer:GetChildren()) do
                if v:IsA('TextButton') then
                    game:GetService('TweenService'):Create(v, TweenInfo.new(0.3), {TextTransparency = 0.5}):Play()
                end
            end
            container.Visible = true
            game:GetService('TweenService'):Create(main1, TweenInfo.new(0.3), {TextTransparency = 0}):Play()
        end)

        local ElementHandler = {}
        
        function ElementHandler:Label(text)
            local label = Instance.new("Frame")
            label.Name = "label"
            label.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
            label.Size = UDim2.fromOffset(441, 32)
            label.Parent = holder
    
            local uICorner3 = Instance.new("UICorner")
            uICorner3.Name = "uICorner3"
            uICorner3.CornerRadius = UDim.new(0, 6)
            uICorner3.Parent = label

            local textLabel = Instance.new("TextLabel")
            textLabel.Name = "textLabel"
            textLabel.Font = Enum.Font.Gotham
            textLabel.Text = text
            textLabel.TextColor3 = Color3.fromRGB(195, 195, 195)
            textLabel.TextSize = 13
            textLabel.TextStrokeColor3 = Color3.fromRGB(195, 195, 195)
            textLabel.TextXAlignment = Enum.TextXAlignment.Left
            textLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            textLabel.BackgroundTransparency = 1
            textLabel.Position = UDim2.fromScale(0.0181, 0)
            textLabel.Size = UDim2.fromOffset(1, 32)
            textLabel.Parent = label
        end

        function ElementHandler:Button(text, callback)
            text = text or "Button"
            callback = callback or function() end

            local button = Instance.new("TextButton")
            button.Name = "button"
            button.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
            button.Position = UDim2.fromScale(0, 0.135)
            button.Size = UDim2.fromOffset(441, 32)
            button.Text = ""
            button.AutoButtonColor = false

            local uICorner12 = Instance.new("UICorner")
            uICorner12.Name = "uICorner12"
            uICorner12.CornerRadius = UDim.new(0, 6)
            uICorner12.Parent = button

            local textLabel5 = Instance.new("TextLabel")
            textLabel5.Name = "textLabel5"
            textLabel5.Font = Enum.Font.Gotham
            textLabel5.Text = text
            textLabel5.TextColor3 = Color3.fromRGB(195, 195, 195)
            textLabel5.TextSize = 13
            textLabel5.TextStrokeColor3 = Color3.fromRGB(195, 195, 195)
            textLabel5.TextXAlignment = Enum.TextXAlignment.Left
            textLabel5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            textLabel5.BackgroundTransparency = 1
            textLabel5.Position = UDim2.fromScale(0.0181, 0)
            textLabel5.Size = UDim2.fromOffset(1, 32)
            textLabel5.Parent = button

            local imageLabel = Instance.new("ImageLabel")
            imageLabel.Name = "imageLabel"
            imageLabel.Image = "http://www.roblox.com/asset/?id=9584292194"
            imageLabel.ImageColor3 = Color3.fromRGB(195, 195, 195)
            imageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            imageLabel.BackgroundTransparency = 1
            imageLabel.Position = UDim2.fromScale(0.943, 0.219)
            imageLabel.Size = UDim2.fromOffset(18, 18)
            imageLabel.Parent = button

            button.Parent = holder

            button.MouseEnter:Connect(function()
                game:GetService('TweenService'):Create(button, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(43,43,43)}):Play()
            end)

            button.MouseLeave:Connect(function()
                game:GetService('TweenService'):Create(button, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(38,38,38)}):Play()
            end)

            button.MouseButton1Click:Connect(function()
                callback()
            end)
        end

        function ElementHandler:Slider(text, default, min, max, callback) -- slider stuff mainly not made by me
            text = text or "Slider"
            callback = callback or function() end

            local slider = Instance.new("TextButton")
            slider.Name = "slider"
            slider.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
            slider.Size = UDim2.fromOffset(441, 32)
            slider.Text = ""
            slider.AutoButtonColor = false

            local uICorner4 = Instance.new("UICorner")
            uICorner4.Name = "uICorner4"
            uICorner4.CornerRadius = UDim.new(0, 6)
            uICorner4.Parent = slider

            local textLabel1 = Instance.new("TextLabel")
            textLabel1.Name = "textLabel1"
            textLabel1.Font = Enum.Font.Gotham
            textLabel1.Text = text
            textLabel1.TextColor3 = Color3.fromRGB(195, 195, 195)
            textLabel1.TextSize = 13
            textLabel1.TextStrokeColor3 = Color3.fromRGB(195, 195, 195)
            textLabel1.TextXAlignment = Enum.TextXAlignment.Left
            textLabel1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            textLabel1.BackgroundTransparency = 1
            textLabel1.Position = UDim2.fromScale(0.0181, 0)
            textLabel1.Size = UDim2.fromOffset(1, 32)
            textLabel1.Parent = slider

            local frame = Instance.new("Frame")
            frame.Name = "frame"
            frame.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
            frame.Position = UDim2.fromScale(0.753, 0.375)
            frame.Size = UDim2.fromOffset(102, 8)

            local uICorner5 = Instance.new("UICorner")
            uICorner5.Name = "uICorner5"
            uICorner5.CornerRadius = UDim.new(0, 3)
            uICorner5.Parent = frame

            local frame1 = Instance.new("Frame")
            frame1.Name = "frame1"
            frame1.BackgroundColor3 = Color3.fromRGB(32, 202, 106)
            frame1.Position = UDim2.fromScale(-0.00207, 0)
            frame1.Size = UDim2.fromOffset(44, 8)

            local uICorner6 = Instance.new("UICorner")
            uICorner6.Name = "uICorner6"
            uICorner6.CornerRadius = UDim.new(0, 3)
            uICorner6.Parent = frame1

            frame1.Parent = frame
            frame.Parent = slider

            local textLabel2 = Instance.new("TextLabel")
            textLabel2.Name = "textLabel2"
            textLabel2.Font = Enum.Font.Gotham
            textLabel2.Text = "7"
            textLabel2.TextColor3 = Color3.fromRGB(195, 195, 195)
            textLabel2.TextSize = 13
            textLabel2.TextStrokeColor3 = Color3.fromRGB(195, 195, 195)
            textLabel2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            textLabel2.BackgroundTransparency = 1
            textLabel2.Position = UDim2.fromScale(0.653, 0)
            textLabel2.Size = UDim2.fromOffset(44, 32)
            textLabel2.Parent = slider

            slider.Parent = holder
            textLabel2.Text = tostring(default)

            local hovered = false
            local down = false

            slider.MouseEnter:Connect(function()
                hovered = true
                game:GetService('TweenService'):Create(slider, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(43,43,43)}):Play()
            end)

            slider.MouseLeave:Connect(function()
                if not down then
                    game:GetService('TweenService'):Create(slider, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(38,38,38)}):Play()
                end
            end)
    
            game:GetService('UserInputService').InputEnded:connect(function(key)
                if key.UserInputType == Enum.UserInputType.MouseButton1 or key.UserInputType == Enum.UserInputType.Touch then
                    down = false
                    game:GetService('TweenService'):Create(slider, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(38,38,38)}):Play()
                end
            end)
    
            slider.MouseButton1Down:connect(function()
                game:GetService('TweenService'):Create(slider, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(47,47,47)}):Play()
                down = true
                while RunService.RenderStepped:wait() and down do
                    local percentage = math.clamp((Mouse.X - frame1.AbsolutePosition.X) / (frame1.AbsoluteSize.X), 0, 1)
                    local value = ((max - min) * percentage) + min
                    value = math.floor(value)
                    textLabel2.Text = value
                    local tween = game:GetService('TweenService'):Create(frame1, TweenInfo.new(0.06), {Size = UDim2.fromScale(percentage, 1)}):Play()
                    callback(value)
                end
            end)
        end

        function ElementHandler:Toggle(text, state, callback)
            text = text or "Toggle"
            callback = callback or function() end

            local toggle1 = Instance.new("TextButton")
            toggle1.Name = "toggle1"
            toggle1.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
            toggle1.Size = UDim2.fromOffset(441, 32)
            toggle1.Text = ""
            toggle1.AutoButtonColor = false

            local uICorner9 = Instance.new("UICorner")
            uICorner9.Name = "uICorner9"
            uICorner9.CornerRadius = UDim.new(0, 6)
            uICorner9.Parent = toggle1

            local textLabel4 = Instance.new("TextLabel")
            textLabel4.Name = "textLabel4"
            textLabel4.Font = Enum.Font.Gotham
            textLabel4.Text = text
            textLabel4.TextColor3 = Color3.fromRGB(195, 195, 195)
            textLabel4.TextSize = 13
            textLabel4.TextStrokeColor3 = Color3.fromRGB(195, 195, 195)
            textLabel4.TextXAlignment = Enum.TextXAlignment.Left
            textLabel4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            textLabel4.BackgroundTransparency = 1
            textLabel4.Position = UDim2.fromScale(0.0181, 0)
            textLabel4.Size = UDim2.fromOffset(1, 32)
            textLabel4.Parent = toggle1

            local frame3 = Instance.new("Frame")
            frame3.Name = "frame3"
            frame3.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            frame3.Position = UDim2.fromScale(0.943, 0.219)
            frame3.Size = UDim2.fromOffset(18, 18)

            local uICorner10 = Instance.new("UICorner")
            uICorner10.Name = "uICorner10"
            uICorner10.CornerRadius = UDim.new(0, 3)
            uICorner10.Parent = frame3

            local uIStroke1 = Instance.new("UIStroke")
            uIStroke1.Name = "uIStroke1"
            uIStroke1.Color = Color3.fromRGB(76, 76, 76)
            uIStroke1.Parent = frame3

            frame3.Parent = toggle1

            toggle1.Parent = holder

            local tog = state
            if tog then
                game:GetService('TweenService'):Create(frame3, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(23, 143, 75)}):Play()
                game:GetService('TweenService'):Create(uIStroke1, TweenInfo.new(0.2), {Color = Color3.fromRGB(32, 202, 106)}):Play()
                pcall(function()
                    callback(tog)
                end)
            end

            toggle1.MouseEnter:Connect(function()
                game:GetService('TweenService'):Create(toggle1, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(43,43,43)}):Play()
            end)

            toggle1.MouseLeave:Connect(function()
                game:GetService('TweenService'):Create(toggle1, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(38,38,38)}):Play()
            end)

            toggle1.MouseButton1Click:Connect(function()
                tog = not tog
                pcall(function()
                    callback(tog)
                end)
                if tog then
                    game:GetService('TweenService'):Create(frame3, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(23, 143, 75)}):Play()
                    game:GetService('TweenService'):Create(uIStroke1, TweenInfo.new(0.2), {Color = Color3.fromRGB(32, 202, 106)}):Play()
                else
                    game:GetService('TweenService'):Create(frame3, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}):Play()
                    game:GetService('TweenService'):Create(uIStroke1, TweenInfo.new(0.2), {Color = Color3.fromRGB(76, 76, 76)}):Play()
                end
            end)
        end

        function ElementHandler:Textbox(text, callback)
            text = text or "Textbox"
            callback = callback or function() end

            local textbox = Instance.new("Frame")
            textbox.Name = "textbox"
            textbox.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
            textbox.Size = UDim2.fromOffset(441, 32)

            local uICorner13 = Instance.new("UICorner")
            uICorner13.Name = "uICorner13"
            uICorner13.CornerRadius = UDim.new(0, 6)
            uICorner13.Parent = textbox

            local textLabel6 = Instance.new("TextLabel")
            textLabel6.Name = "textLabel6"
            textLabel6.Font = Enum.Font.Gotham
            textLabel6.Text = text
            textLabel6.TextColor3 = Color3.fromRGB(195, 195, 195)
            textLabel6.TextSize = 13
            textLabel6.TextStrokeColor3 = Color3.fromRGB(195, 195, 195)
            textLabel6.TextXAlignment = Enum.TextXAlignment.Left
            textLabel6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            textLabel6.BackgroundTransparency = 1
            textLabel6.Position = UDim2.fromScale(0.0181, 0)
            textLabel6.Size = UDim2.fromOffset(1, 32)
            textLabel6.Parent = textbox

            local textBox = Instance.new("TextBox")
            textBox.Name = "textBox"
            textBox.Font = Enum.Font.SourceSans
            textBox.Text = ""
            textBox.TextColor3 = Color3.fromRGB(195, 195, 195)
            textBox.TextSize = 12
            textBox.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
            textBox.Position = UDim2.fromScale(0.864, 0.188)
            textBox.Size = UDim2.fromOffset(52, 19)
            textBox.TextScaled = true

            local uICorner14 = Instance.new("UICorner")
            uICorner14.Name = "uICorner14"
            uICorner14.CornerRadius = UDim.new(0, 6)
            uICorner14.Parent = textBox

            textBox.Parent = textbox
            textbox.Parent = holder

            textbox.MouseEnter:Connect(function()
                game:GetService('TweenService'):Create(textbox, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(43,43,43)}):Play()
            end)

            textbox.MouseLeave:Connect(function()
                game:GetService('TweenService'):Create(textbox, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(38,38,38)}):Play()
            end)

            textBox.FocusLost:Connect(function()
                callback(textBox.Text)
                textBox.Text = ""
            end)
        end

        function ElementHandler:Dropdown(title, list, func)
                local lfunc = function() end
                local callback = func or lfunc
                
                local DropdownFunc = {}
                local dropped = false
                local Dropdown = Instance.new("Frame")
                local UICorner723 = Instance.new("UICorner")
                local UIListLayout_69 = Instance.new("UIListLayout")
                local Choose = Instance.new("TextButton")
                local UICorner = Instance.new("UICorner")
                local Title = Instance.new("TextLabel")
                local arrow = Instance.new("ImageButton")
                local OptionHolder = Instance.new("Frame")
                local UICorner_2 = Instance.new("UICorner")
                local OptionList = Instance.new("UIListLayout")
                local UIPadding = Instance.new("UIPadding")

                Dropdown.Name = "Dropdown"
                Dropdown.Parent = holder
                Dropdown.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Dropdown.BackgroundTransparency = 1.000
                Dropdown.BorderColor3 = Color3.fromRGB(27, 42, 53)
                Dropdown.BorderSizePixel = 0
                Dropdown.ClipsDescendants = true
                Dropdown.Size = UDim2.new(0, 441, 0, 32)

                UICorner723.CornerRadius = UDim.new(0, 6)
                UICorner723.Parent = Dropdown

                UIListLayout_69.Parent = Dropdown
                UIListLayout_69.HorizontalAlignment = Enum.HorizontalAlignment.Center
                UIListLayout_69.SortOrder = Enum.SortOrder.LayoutOrder
                UIListLayout_69.Padding = UDim.new(0, 5)

                Choose.Name = "Choose"
                Choose.Parent = Dropdown
                Choose.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
                Choose.BorderSizePixel = 0
                Choose.Text = ""
                Choose.Size = UDim2.new(1, 0, 0, 34)
                Choose.AutoButtonColor = false

                UICorner.CornerRadius = UDim.new(0, 6)
                UICorner.Parent = Choose

                Title.Name = "Title"
                Title.Parent = Choose
                Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Title.BackgroundTransparency = 1.000
                Title.Position = UDim2.fromScale(0.0181, 0)
                Title.Size = UDim2.new(1, -6, 1, 0)
                Title.Font = Enum.Font.Gotham
                Title.Text = title or "Dropdowm"
                Title.TextColor3 = Color3.fromRGB(195, 195, 195)
                Title.TextSize = 13.000
                Title.TextXAlignment = Enum.TextXAlignment.Left

                arrow.Name = "arrow"
                arrow.Parent = Choose
                arrow.AnchorPoint = Vector2.new(1, 0.5)
                arrow.BackgroundTransparency = 1.000
                arrow.LayoutOrder = 10
                arrow.Position = UDim2.new(1, -2, 0.5, 0)
                arrow.Size = UDim2.new(0, 28, 0, 28)
                arrow.ZIndex = 2
                arrow.Image = "rbxassetid://3926307971"
                arrow.ImageColor3 = Color3.fromRGB(195, 195, 195)
                arrow.ImageRectOffset = Vector2.new(324, 524)
                arrow.ImageRectSize = Vector2.new(36, 36)
                arrow.ScaleType = Enum.ScaleType.Crop

                OptionHolder.Name = "OptionHolder"
                OptionHolder.Parent = Dropdown
                OptionHolder.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
                OptionHolder.BorderSizePixel = 0
                OptionHolder.Size = UDim2.new(1, 0, 1, -38)

                UICorner_2.CornerRadius = UDim.new(0, 6)
                UICorner_2.Parent = OptionHolder

                OptionList.Name = "OptionList"
                OptionList.Parent = OptionHolder
                OptionList.HorizontalAlignment = Enum.HorizontalAlignment.Center
                OptionList.SortOrder = Enum.SortOrder.LayoutOrder
                OptionList.Padding = UDim.new(0, 5)

                UIPadding.Parent = OptionHolder
                UIPadding.PaddingTop = UDim.new(0, 8)
                
                Choose.MouseButton1Click:Connect(function()
                        if not dropped then
                            Dropdown:TweenSize(UDim2.new(0, 441, 0, UIListLayout_69.AbsoluteContentSize.Y), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, .15, true)
                            TweenService:Create(arrow, TweenInfo.new(.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Rotation = 180}, true):Play()
			                dropped = true
                        else
                            TweenService:Create(arrow, TweenInfo.new(.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Rotation = 0}, true):Play()
                            Dropdown:TweenSize(UDim2.new(0, 441, 0, 32), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, .12)
                            dropped = false 
                        end
                end)
                
                for i,v in next, list do
                    local Option = Instance.new("TextButton")
                    local UICorner = Instance.new("UICorner")

                    Option.Name = "Option"
                    Option.Parent = OptionHolder
                    Option.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
                    Option.BorderSizePixel = 0
                    Option.Size = UDim2.new(1, -16, 0, 30)
                    Option.AutoButtonColor = false
                    Option.Font = Enum.Font.Gotham
                    Option.Text = v
                    Option.TextColor3 = Color3.fromRGB(195, 195, 195)
                    Option.TextSize = 13.000

                    UICorner.CornerRadius = UDim.new(0, 6)
                    UICorner.Parent = Option

                    Option.MouseButton1Click:Connect(function()
                        pcall(callback, v)
                        dropped = false
                        TweenService:Create(arrow, TweenInfo.new(.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{Rotation = 0}):Play()
                        Dropdown:TweenSize(UDim2.new(0, 441, 0, 32), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .15, true)
                        Title.Text = title.." : "..v
                    end)
                    OptionHolder:TweenSize(UDim2.new(1, 0, 0, OptionList.AbsoluteContentSize.Y + 15), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .15, true)
            end

            function DropdownFunc:Clear(v)
                    for _,v  in next, OptionHolder:GetChildren() do
                      if v:IsA("TextButton") then
                        v:Destroy()
                      end
                    end
                    --TweenService:Create(Title, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {TextColor3 = Theme.Header}, true):Play()
                    Dropdown:TweenSize(UDim2.new(0, 441, 0, 32), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, .2)
                    OptionHolder:TweenSize(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, .2)
                    wait(.2)
                    --TweenService:Create(Title, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {TextColor3 = Theme.Text}, true):Play()
                    dropped = false
            end

            function DropdownFunc:Add(v)
                    local Option = Instance.new("TextButton")
                    local UICorner = Instance.new("UICorner")

                    Option.Name = "Option"
                    Option.Parent = OptionHolder
                    Option.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
                    Option.BorderSizePixel = 0
                    Option.Size = UDim2.new(1, -16, 0, 30)
                    Option.AutoButtonColor = false
                    Option.Font = Enum.Font.Gotham
                    Option.Text = v
                    Option.TextColor3 = Color3.fromRGB(195, 195, 195)
                    Option.TextSize = 13.000

                    UICorner.CornerRadius = UDim.new(0, 6)
                    UICorner.Parent = Option

                    Option.MouseButton1Click:Connect(function()
                        pcall(callback, v)
                        dropped = false
                        TweenService:Create(arrow, TweenInfo.new(.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{Rotation = 0}):Play()
                        Dropdown:TweenSize(UDim2.new(0, 441, 0, 32), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .15, true)
                        Title.Text = title.." : "..v
                    end)
                    OptionHolder:TweenSize(UDim2.new(1, 0, 0, OptionList.AbsoluteContentSize.Y + 15), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .15, true)
            end
            return DropdownFunc
        end
        function ElementHandler:Line()
	    local Seperator1 = Instance.new("Frame")
	    local Seperator2 = Instance.new("Frame")

	    Seperator1.Name = "Seperator1"
    	    Seperator1.Parent = holder
	    Seperator1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	    Seperator1.BackgroundTransparency = 1.000
	    Seperator1.Position = UDim2.new(0, 0, 0.350318581, 0)
            Seperator1.Size = UDim2.new(0, 100, 0, 8)

	    Seperator2.Name = "Seperator2"
	    Seperator2.Parent = Seperator1
	    Seperator2.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
	    Seperator2.BorderSizePixel = 0
	    Seperator2.Position = UDim2.new(0, 0, 0, 4)
	    Seperator2.Size = UDim2.new(0, 441, 0, 1)
        end
        return ElementHandler
    end
    return tabHandler
end
return Library
