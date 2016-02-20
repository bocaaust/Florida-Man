-- Florida man
supportedOrientations(LANDSCAPE_ANY)
displayMode(FULLSCREEN_NO_BUTTONS)
function game1setup()
    enemy = vec2(WIDTH/2,0)
    person = vec2(WIDTH/4,HEIGHT/4)
end

-- Use this function to perform your initial setup

function setup()
    --person = vec2(WIDTH/4,HEIGHT/4)
    person = vec2(0,0)
    game = 3
    rectMode(CORNER)
    spriteMode(CORNER)
    touching = false
    time = ElapsedTime
    lives = 3
    enemy = vec2(0,0)
    enemy2 = vec2(0,0)
    if game == 1 then
        game1setup()
    end
    if game == 3 then
        game3setup()
    end
end

function game2setup()
   -- enemy2.x = enemy.x
    --enemy2.y = enemy.y
    enemy2.y = .4
    enemy.y = 0
    enemy2.x = WIDTH*2/3
    enemy.x = WIDTH/3
    person.x = WIDTH/4
end

function game3setup()

enemy.y = HEIGHT
enemy.x = WIDTH*3/4
person.x = WIDTH/8
person.y = HEIGHT/4
touching = false
end

-- This function gets called once every frame
function draw()
    -- This sets a dark background color 
    background(255, 255, 255, 255)
    for i = 1,3 do
        fontSize(90)
        fill(255, 0, 0, 175)
        if i <= lives then
        text("❤️",WIDTH/8,HEIGHT-i*HEIGHT/8)
            else
            text("💔",WIDTH/8,HEIGHT-i*HEIGHT/8)
            end
    end
    --bee game
    if game == 1 then
        sprite("Project:bees headline",0,0,WIDTH,HEIGHT/4)
        if CurrentTouch.state == ENDED then
            touching = false
        end
   -- rect(person.x,person.y,WIDTH/25,HEIGHT/8)
        sprite("Project:player",person.x,person.y,WIDTH/15,HEIGHT/8)
        if (CurrentTouch.x > person.x and CurrentTouch.state ~= ENDED) or touching then
            touching = true
            person.x = person.x + 1.25
        end
        if person.x >= WIDTH*7/8 then
            game = game + 1
            game2setup()
        end
        sprite("Project:honey",WIDTH*7/8,person.y)
        sprite("Project:bee",enemy.x,math.sin(enemy.y)*HEIGHT/4+HEIGHT/4,WIDTH/8)
            enemy.y = enemy.y + .01
        if (math.sin(enemy.y)*HEIGHT/4+HEIGHT/4) < (person.y+HEIGHT/8) and math.sin(enemy.y)*HEIGHT/4+HEIGHT/8+HEIGHT/4 > person.y and person.x > enemy.x and person.x+WIDTH/15 < enemy.x+WIDTH/8 then
            lives = lives - 1
            game = game + 1
            game2setup()
        end
        end
    
    if game == 2 then
        sprite("Project:bees headline",0,0,WIDTH,HEIGHT/4)
        if CurrentTouch.state == ENDED then
            touching = false
        end
        sprite("Project:player",person.x,person.y,WIDTH/15,HEIGHT/8)
        if (CurrentTouch.x > person.x and CurrentTouch.state ~= ENDED) or touching then
            touching = true
            person.x = person.x + 1.75
        end
        if person.x >= WIDTH*7/8 then
            game = game + 1
            game3setup()
        end
        sprite("Project:honey",WIDTH*7/8,person.y)
        sprite("Project:bee",enemy.x,math.sin(enemy.y)*HEIGHT/4+HEIGHT/4,WIDTH/8)
            enemy.y = enemy.y + .025
        if (math.sin(enemy.y)*HEIGHT/4+HEIGHT/4) < (person.y+HEIGHT/8) and math.sin(enemy.y)*HEIGHT/4+HEIGHT/8+HEIGHT/4 > person.y and person.x > enemy.x and person.x+WIDTH/15 < enemy.x+WIDTH/8 then
            lives = lives - 1
            game = game + 1
            game3setup()
        end
        
        
        sprite("Project:bee",enemy2.x,math.sin(enemy2.y)*HEIGHT/4+HEIGHT/4,WIDTH/8)
            enemy2.y = enemy2.y + .025
        if (math.sin(enemy2.y)*HEIGHT/4+HEIGHT/4) < (person.y+HEIGHT/12) and math.sin(enemy2.y)*HEIGHT/4+HEIGHT/8+HEIGHT/4 > person.y and person.x > enemy2.x and person.x+WIDTH/20 < enemy2.x+WIDTH/8 then
            lives = lives - 1
            game = game + 1
            game3setup()
        end
        end

    if game == 3 then
        --enemy = foot
        --player use sprite in wheelchair

        sprite("Project:scooter_chase", 0,0,WIDTH,HEIGHT/4)
        sprite("Project:Cannon",0,HEIGHT/4,WIDTH/6.5,HEIGHT/8)
        if CurrentTouch.state == BEGAN then
            touching = true
        end

        if touching then
            sprite("Project:player_chair",person.x,person.y,WIDTH/6.5,HEIGHT/6)
            person.y = person.y + 1
            person.x = person.x + 3.5
        end



    end
    
end
