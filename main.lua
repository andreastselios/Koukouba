-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Create objects

-- Background
local background = display.newImageRect( "background2.jpg", 360, 570 )
background.x = display.contentCenterX
background.y = display.contentCenterY
-- Platform
local platform = display.newImageRect( "platform.png", 300, 30 )
platform.x = display.contentCenterX
platform.y = display.contentHeight-25
-- Ballon Object (e.g. SHMA)
local balloon = display.newImageRect( "logo.png", 98, 98 )
balloon.x = display.contentCenterX
balloon.y = display.contentCenterY
balloon.alpha = 0.8

-- Add physics
local physics = require( "physics" )
physics.start()

physics.addBody( platform, "static" )
physics.addBody( balloon, "dynamic", { radius=50, bounce=0.4 } )

-- Current Score
local tapCount = 0
local tapText = display.newText( tapCount, display.contentCenterX, 20, native.systemFontBold, 50 )

-- High Score Text
local hiScoreLabel = "Best Score: "
local hiScoreLabelText = display.newText( hiScoreLabel, 0, 0, native.systemFontBold, 15 )
hiScoreLabelText:setFillColor( 0.9, 0.9, 0.9 )
hiScoreLabelText.anchorX = 0
hiScoreLabelText.x = 10
hiScoreLabelText.y = -05
local hiScore = 0
local hiScoreText = display.newText( hiScore, 0, 0, native.systemFontBold, 15 )
hiScoreText:setFillColor( 0.9, 0.9, 0.9 )
hiScoreText.anchorX = 0
hiScoreText.x = 100
hiScoreText.y = -05

-- Total Hit Score Text

local optionsTotal = {
   text = "Total Hits: ",
   x = 230,
   y = -05,
   fontSize = 15,
   font = native.systemFontBold,
   width = 100,
   height = 0,
   align = "right"  
}
local totalScoreLabelText = display.newText( optionsTotal )
totalScoreLabelText:setFillColor( 0.9, 0.9, 0.9 )


local totalScore = 0
local totalScoreText = display.newText( totalScore, 0, 0, native.systemFontBold, 15 )
totalScoreText:setFillColor( 0.9, 0.9, 0.9 )
totalScoreText.anchorX = 0
totalScoreText.x = 280
totalScoreText.y = -05


local function pushBalloon()
    balloon:applyLinearImpulse( 0, -0.75, balloon.x, balloon.y )
    tapCount = tapCount + 1
    tapText.text = tapCount
end
balloon:addEventListener( "tap", pushBalloon )


-- Check for collision
local function onLocalCollision( self, event )

    if ( event.phase == "began" ) then
		
		if ( tapCount > hiScore ) then
			hiScore = tapCount
			totalScore = tapCount + totalScore
			tapCount = 0
			tapText.text = tapCount
			hiScoreText.text = hiScore
			totalScoreText.text = totalScore	
		else
			totalScore = totalScore + tapCount
			tapCount = 0
			tapText.text = tapCount
			totalScoreText.text = totalScore
		end
		
    end
end

balloon.collision = onLocalCollision
balloon:addEventListener( "collision" )


