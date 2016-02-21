-- Florida man
supportedOrientations(LANDSCAPE_ANY)
displayMode(FULLSCREEN_NO_BUTTONS)

function game1setup()
    enemy = vec2(WIDTH/2,0)
    person = vec2(WIDTH/4,HEIGHT/4)
end

-- Use this function to perform your initial setup

function setup()
    music("Project:FloridaManBG",true)
    points = 0
    textMode(CENTER)
    gameMax = 4
    gsetups = {game1setup,game2setup,game3setup,game4setup,game5setup,game6setup}
    test = 0
    --person = vec2(WIDTH/4,HEIGHT/4)
    person = vec2(0,0)
    rectMode(CORNER)
    spriteMode(CORNER)
    touching = false
    time = ElapsedTime
    lives = 3
    enemy = vec2(0,0)
    enemy2 = vec2(0,0)
    
    
    --game = math.random(1,gameMax)
    game = 6
    gsetups[game]()
end

function game2setup()
    -- enemy2.x = enemy.x
    --enemy2.y = enemy.y
    enemy2 = vec2(0,0)
    enemy2.y = .4
    enemy.y = 0
    enemy2.x = WIDTH*2/3
    enemy.x = WIDTH/3
    person.x = WIDTH/4
    person.y = HEIGHT/4
end

function game3setup()
    
    enemy.y = HEIGHT
    enemy.x = WIDTH*7/8
    person.x = WIDTH/8
    person.y = HEIGHT/4
    touching = false
    enemy2.x = 1
end


function game4setup()
    person.x = math.random(1,3)
    enemy.y = -WIDTH/4
    enemy.x = WIDTH/4
    enemy2.x = person.x*WIDTH/4+WIDTH/16
    enemy2.y = HEIGHT/2
    touching = false
end

function game5setup()
    person = vec2(WIDTH/5,HEIGHT/4)
    enemy = vec2(WIDTH/3.4,HEIGHT/4)
    touching = false
end

function game6setup()
    touching = false
    --person.x = #, y = 0 for row 1 for column
    --enemy.x = one missing
    --enemy2 = touch position
    enemy2.x = 0
    enemy2.y = 0
    
    person.x = math.random(1,3)
    person.y = math.random(0,1)
    enemy.x = math.random(1,3)
    
end

-- This function gets called once every frame
function draw()
    if lives == 0 then
        lives = lives -1
        music("Project:sad-airhorn",true)
        touching = false
    end
    if lives < 0 then
        fill(math.random(0,255),math.random(0,255),math.random(0,255),255)
        fontSize(75)
        text("LMAO, You L0St",WIDTH/2,HEIGHT/2)
        fontSize(45)
        text("tap to try again noob",WIDTH/2,HEIGHT/4)
        if CurrentTouch.state == ENDED then
            touching = true
        end
        if CurrentTouch.state == BEGAN and touching then
            setup()
        end
    else
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
        fill(0)
        text(points,WIDTH*6/8,HEIGHT*7/8)
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
                game = math.random(1,gameMax)
                points = points +1
                currentgame = gsetups[game]
                currentgame()
            end
            sprite("Project:honey",WIDTH*7/8,person.y)
            sprite("Project:bee",enemy.x,math.sin(enemy.y)*HEIGHT/4+HEIGHT/4,WIDTH/8)
            enemy.y = enemy.y + .01
            if (math.sin(enemy.y)*HEIGHT/4+HEIGHT/4) < (person.y+HEIGHT/8) and math.sin(enemy.y)*HEIGHT/4+HEIGHT/8+HEIGHT/4 > person.y and person.x > enemy.x and person.x+WIDTH/15 < enemy.x+WIDTH/8 then
                lives = lives - 1
                game = math.random(1,gameMax)
                currentgame = gsetups[game]
                currentgame()
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
                points = points +1
                game = math.random(1,gameMax)
                currentgame = gsetups[game]
                currentgame()
            end
            sprite("Project:honey",WIDTH*7/8,person.y)
            sprite("Project:bee",enemy.x,math.sin(enemy.y)*HEIGHT/4+HEIGHT/4,WIDTH/8)
            enemy.y = enemy.y + .025
            if (math.sin(enemy.y)*HEIGHT/4+HEIGHT/4) < (person.y+HEIGHT/8) and math.sin(enemy.y)*HEIGHT/4+HEIGHT/8+HEIGHT/4 > person.y and person.x > enemy.x and person.x+WIDTH/15 < enemy.x+WIDTH/8 then
                lives = lives - 1
                game = math.random(1,gameMax)
                currentgame = gsetups[game]
                currentgame()
            end
            
            
            sprite("Project:bee",enemy2.x,math.sin(enemy2.y)*HEIGHT/4+HEIGHT/4,WIDTH/8)
            enemy2.y = enemy2.y + .025
            if (math.sin(enemy2.y)*HEIGHT/4+HEIGHT/4) < (person.y+HEIGHT/12) and math.sin(enemy2.y)*HEIGHT/4+HEIGHT/8+HEIGHT/4 > person.y and person.x > enemy2.x and person.x+WIDTH/20 < enemy2.x+WIDTH/8 then
                lives = lives - 1
                game = math.random(1,gameMax)
                currentgame = gsetups[game]
                currentgame()
            end
        end
        
        if game == 3 then
            --enemy = foot
            --player use sprite in wheelchair
            if CurrentTouch.state == ENDED then
                enemy2.x = 0
            end
            sprite("Project:scooter_chase", 0,0,WIDTH,HEIGHT/4)
            sprite("Project:Cannon",0,HEIGHT/4,WIDTH/6.5,HEIGHT/8)
            if CurrentTouch.state == BEGAN and enemy2.x == 0 then
                touching = true
            end
            
            if touching then
                sprite("Project:player_chair",person.x,person.y,WIDTH/6.5,HEIGHT/6)
                person.y = person.y + .85
                person.x = person.x + 5
            end
            
            sprite("Project:bullseye",WIDTH*7/8,HEIGHT*2.8/4,WIDTH/8,WIDTH/8)
            
            sprite("Project:foot",enemy.x,enemy.y,WIDTH/8,HEIGHT/6)
            
            enemy.y = enemy.y - 2
            
            if enemy.y <= 0 then
                lives= lives -1
                game = math.random(1,gameMax)
                currentgame = gsetups[game]
                currentgame()
            end
            
            if person.x > WIDTH*7/8 and person.y >= enemy.y+WIDTH/20 and person.y < enemy.y+HEIGHT/6-WIDTH/20  then
                game = math.random(1,gameMax)
                points = points +1
                currentgame = gsetups[game]
                currentgame()
            end
            
            
        end
        
        if game == 4 then
            --enemy will be alligators position
            --enemy2 will be position of mushroom
            --assign mushroom through math.random(1,3)
            sprite("Project:mushrooms",WIDTH/4,HEIGHT*3/4,WIDTH*3/4)
            for i = 1,3 do
                sprite("Project:Alligator",enemy.x*i,enemy.y,WIDTH/4,HEIGHT/2)
                --rect(enemy.x*i,enemy.y,WIDTH/6,HEIGHT/2)
            end
            
            --Draw magic mushroom
            sprite("Project:magic-mushroom",enemy2.x, enemy2.y, WIDTH/14)
            --rect(enemy2.x, enemy2.y, WIDTH/16, WIDTH/16)
            
            
            if CurrentTouch.state == BEGAN and touching == false then
                test = CurrentTouch.x
                --Check which alligator touched
                if (test >= WIDTH/4*person.x and test <= WIDTH/4*person.x+WIDTH/6) then
                    touching = true
                    --Shoot up alligator
                    
                else
                    lives = lives - 1
                    game = math.random(1,gameMax)
                    currentgame = gsetups[game]
                    currentgame()
                end
            end
            
            if touching and enemy.y < 0 then
                --Start bringing alligators up
                enemy.y = enemy.y + 3
            end
            if (enemy.y >= 0) then
                points = points +1
                game = math.random(1,gameMax)
                currentgame = gsetups[game]
                currentgame()
            end
            
        end
        
    end
    
    if game == 5 then
        sprite("Project:naked_man",0,0,WIDTH,HEIGHT/4)
        sprite("Project:burglar",enemy.x,enemy.y,WIDTH/8,HEIGHT/6)
        
        if CurrentTouch.state == ENDED then
            touching = true
        end
        sprite("Project:player_XXX",person.x,person.y,WIDTH/8,HEIGHT/6)
        enemy.x = enemy.x + 1.25
        if (CurrentTouch.x > person.x and CurrentTouch.state == BEGAN) and touching then
            touching = false
            person.x = person.x + 20
        end
        if person.x > enemy.x then
            game = math.random(1,gameMax)
            points = points +1
            currentgame = gsetups[game]
            currentgame()
        end
        if enemy.x >=WIDTH then
            lives = lives - 1
            game = math.random(1,gameMax)
            currentgame = gsetups[game]
            currentgame()
        end
    end
    
    if game == 6 then
        --person.x = #, y = 0 for row 1 for column
        --enemy.x = one missing
        --enemy2 = touch position
        fill(255,0,0,255)
        if CurrentTouch.state == ENDED then
            touching = true
        end
        sprite("Project:bingo_plate",WIDTH/5,HEIGHT/5,WIDTH/2,HEIGHT/5*4)
        for i = 1,3 do
            if i ~= enemy.x then
                if person.y == 0 then
                    ellipse(WIDTH/9+WIDTH/5+(i-1)*WIDTH/7,HEIGHT/10+HEIGHT/4.75+(person.x-1)*HEIGHT/5,WIDTH/8)
                else
                    ellipse(WIDTH/9+WIDTH/5+(person.x-1)*WIDTH/7,HEIGHT/10+HEIGHT/4.75+(i-1)*HEIGHT/5,WIDTH/8)
                end
            end
        end
        sprite("Project:bingo",0,0,WIDTH,HEIGHT/5)
    end

end