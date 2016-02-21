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
    gameMax = 11
    gsetups = {game1setup,game2setup,game3setup,game4setup,game5setup,game6setup,game7setup,game8setup,game9setup,game10setup,game11setup}
    test = 0
    sounds = {"Project:charlie","Project:dramatic-chipmunk","Project:john-cena","Project:let-you-finish","Project:nyan","Project:troll","Project:barrel-roll","Project:chocolate-rain","Project:dont-taze","Project:magnets","Project:spoon"}
    --person = vec2(WIDTH/4,HEIGHT/4)
    person = vec2(0,0)
    rectMode(CORNER)
    spriteMode(CORNER)
    touching = false
    time = ElapsedTime
    lives = 3
    enemy = vec2(0,0)
    enemy2 = vec2(0,0)
    released=false
    backwards=false
   -- game = 6
   -- game = math.random(1,gameMax)
    --gsetups[game]()
    nextMiniGame()
end

function nextMiniGame()
    game = math.random(1,gameMax)
    gsetups[game]()
end

function winMiniGame()
    points = points +1
    nextMiniGame()
    sound(sounds[math.random(1,11)])
end

function loseMiniGame()
    lives = lives - 1
    nextMiniGame()
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
    released = false
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
    if person.x == 3 and person.y == 0 and enemy.x == 1 then
    enemy.x = enemy.x +1
    end
    enemy.y = 0
end

function game7setup()
    enemy.x=math.random(math.ceil(WIDTH/6),math.ceil(WIDTH*7/8))
    person.x=math.random(math.ceil(WIDTH/6),math.ceil(WIDTH*7/8))
    person.y=HEIGHT*5/8
    enemy2.x=person.x
    enemy2.y=person.y
    touching=true
    released=false
    backwards=false
    time=ElapsedTime
    enemy.y=HEIGHT/5
end

function game8setup()
--enemy = position of red car
--person = player position, use surf, use sin for vertical jump
    touching = false
    enemy.y = HEIGHT/3
    enemy.x = WIDTH
    person.x = WIDTH/2
    person.y = HEIGHT/3
    enemy2.x = 0
    enemy2.y = 0
end

function game9setup()
    touching = false
    --person.x = #, y = 0 for row 1 for column
    --enemy.x = one missing
    --enemy2 = touch position
    enemy2.x = 0
    enemy2.y = 0

    person.x = math.random(1,3)
    person.y = math.random(1,3)
    enemy.x = math.random(1,3)
    enemy.y = math.random(1,3)
    released=false
end


function game10setup()
    person = vec2(WIDTH/5.1,HEIGHT/4)
    enemy = vec2(WIDTH/3.3,HEIGHT/4)
    touching = false
end

function game11setup()
    sound("Project:rickroll")
    touching = false
end

function drawLives()
    fontSize(90*WIDTH/1024)
    fill(255, 0, 0, 175)
    for i = 1,3 do
        if i <= lives then
            text("❤️",WIDTH/8,HEIGHT-i*HEIGHT/8)
        else
            text("💔",WIDTH/8,HEIGHT-i*HEIGHT/8)
        end
    end
end

-- This function gets called once every frame
function draw()
    if lives == 0 then
        lives = lives -1
        music("Project:sad-airhorn",true)
        touching = false
    end

    if lives < 0 then
        drawLives()
        fill(math.random(0,255),math.random(0,255),math.random(0,255),255)
        fontSize(75*WIDTH/1024)
        text("LMAO, You L0St",WIDTH/2,HEIGHT/2)
        fontSize(45*WIDTH/1024)
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
        drawLives()
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
                winMiniGame()
            end
            sprite("Project:honey",WIDTH*7/8,person.y)
            sprite("Project:bee",enemy.x,math.sin(enemy.y)*HEIGHT/4+HEIGHT/4,WIDTH/8)
            enemy.y = enemy.y + .01
            if (math.sin(enemy.y)*HEIGHT/4+HEIGHT/4) < (person.y+HEIGHT/8) and math.sin(enemy.y)*HEIGHT/4+HEIGHT/8+HEIGHT/4 > person.y and person.x > enemy.x and person.x+WIDTH/15 < enemy.x+WIDTH/8 then
                loseMiniGame()
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
                winMiniGame()
            end
            sprite("Project:honey",WIDTH*7/8,person.y)
            sprite("Project:bee",enemy.x,math.sin(enemy.y)*HEIGHT/4+HEIGHT/4,WIDTH/8)
            enemy.y = enemy.y + .025
            if (math.sin(enemy.y)*HEIGHT/4+HEIGHT/4) < (person.y+HEIGHT/8) and math.sin(enemy.y)*HEIGHT/4+HEIGHT/8+HEIGHT/4 > person.y and person.x > enemy.x and person.x+WIDTH/15 < enemy.x+WIDTH/8 then
                loseMiniGame()
            end
            
            
            sprite("Project:bee",enemy2.x,math.sin(enemy2.y)*HEIGHT/4+HEIGHT/4,WIDTH/8)
            enemy2.y = enemy2.y + .025
            if (math.sin(enemy2.y)*HEIGHT/4+HEIGHT/4) < (person.y+HEIGHT/12) and math.sin(enemy2.y)*HEIGHT/4+HEIGHT/8+HEIGHT/4 > person.y and person.x > enemy2.x and person.x+WIDTH/20 < enemy2.x+WIDTH/8 then
                loseMiniGame()
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
            
            if enemy.y <= 0 or person.x > WIDTH then
                loseMiniGame()
            end
            
            if person.x > WIDTH*7/8 and person.x < WIDTH and person.y >= enemy.y+WIDTH/20 and person.y < enemy.y+HEIGHT/6-WIDTH/20  then
                winMiniGame()
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
            if CurrentTouch.state == ENDED then
                released = true
            end
            
            if CurrentTouch.state == BEGAN and touching == false and released then
                test = CurrentTouch.x
                --Check which alligator touched
                if (test >= WIDTH/4*person.x and test <= WIDTH/4*person.x+WIDTH/6) then
                    touching = true
                    --Shoot up alligator
                    
                else
                    loseMiniGame()
                end
            end
            
            if touching and enemy.y < 0 then
                --Start bringing alligators up
                enemy.y = enemy.y + 3
            end
            if (enemy.y >= 0) then
                winMiniGame()
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
            winMiniGame()
        end
        if enemy.x >=WIDTH then
            loseMiniGame()
        end
    end
    
    if game == 6 then
        --person.x = #, y = 0 for row 1 for column
        --enemy.x = one missing, y = can draw 1, 0 can't
        --enemy2 = touch position
        fill(255,0,0,255)
        if CurrentTouch.state == ENDED then
            touching = true
        end
        if touching and CurrentTouch.state == BEGAN and enemy.y == 0 then
            enemy2.x = CurrentTouch.x
            enemy2.y = CurrentTouch.y
            enemy.y = 1
        end
        if enemy.y == 1 then
             sprite("Project:Tire",enemy2.x,enemy2.y,WIDTH/8)
        end
        sprite("Project:bingo_plate",WIDTH/5,HEIGHT/5,WIDTH/2,HEIGHT/5*4)
        spriteMode(CENTER)
        for i = 1,3 do
            if i ~= enemy.x then
                if person.y == 0 then
                   sprite("Project:Tire",WIDTH/9+WIDTH/5+(i-1)*WIDTH/7,HEIGHT/10+HEIGHT/4.75+(person.x-1)*HEIGHT/5,WIDTH/8,WIDTH/8)
                else
                    sprite("Project:Tire",WIDTH/9+WIDTH/5+(person.x-1)*WIDTH/7,HEIGHT/10+HEIGHT/4.75+(i-1)*HEIGHT/5,WIDTH/8,WIDTH/8)
                end
            elseif enemy.y == 1 then
                print(enemy2.x)
                print(WIDTH/9+WIDTH/5+(enemy.x-1)*WIDTH/7 - WIDTH/5)
                print(WIDTH/9+WIDTH/5+(enemy.x-1)*WIDTH/7 + WIDTH/6)
                print(enemy2.y)
                print(HEIGHT/10+HEIGHT/4.75+(enemy.x-1.1)*HEIGHT/5- WIDTH/6)
                print(HEIGHT/10+HEIGHT/4.75+(enemy.x-1.1)*HEIGHT/5 + WIDTH/5)
                if enemy2.x >= WIDTH/9+WIDTH/5+(enemy.x-1)*WIDTH/7 - WIDTH/5 and enemy2.x <= WIDTH/9+WIDTH/5+(enemy.x-1)*WIDTH/7 + WIDTH/6 and enemy2.y >= HEIGHT/10+HEIGHT/4.75+(enemy.x-1.1)*HEIGHT/5 - WIDTH/6 and enemy2.y <= HEIGHT/10+HEIGHT/4.75+(enemy.x-1.1)*HEIGHT/5 + WIDTH/5 then
                    winMiniGame()
                else

                    if (person.x == 1 and person.y == 0 and enemy.x == 3) or (person.x == 3 and y == 0 and enemy.x == 1) then
                        if enemy2.x < WIDTH/5+WIDTH/7 or enemy2.x > WIDTH/5+WIDTH/2-WIDTH/2.5 then
                            if enemy2.y < HEIGHT/4.75+WIDTH/8 or enemy2.y > HEIGHT*3/5 then
                                    winMiniGame()
                            else
                                loseMiniGame()
                            end
                        else
                            loseMiniGame()
                        end
                    else
                    loseMiniGame()
                    end
                end
            end
        end
        spriteMode(CORNER)
        sprite("Project:bingo",0,0,WIDTH,HEIGHT/5)
    end

    if game==7 then
        sprite("Project:pizza",0,0,WIDTH,HEIGHT/3)
        --rect(person.x,person.y,WIDTH/7,HEIGHT/8)
        sprite("Project:pizza-man",person.x,person.y,WIDTH/7)
        --rect(enemy.x,enemy.y,WIDTH/12,HEIGHT/8)
        sprite("Project:player",enemy.x,enemy.y,WIDTH/12)
        --on touch, release the pizza
        if CurrentTouch.state == ENDED then
            touching = true
        end

        if released and enemy2.y <= enemy.y then
            if enemy2.x >= enemy.x - (WIDTH/24) and enemy2.x<= enemy.x+(WIDTH/24) then
                winMiniGame()
            else
                loseMiniGame()
            end
        end

        if (CurrentTouch.x > person.x and CurrentTouch.state == BEGAN) and touching and released==false and os.difftime(math.ceil(ElapsedTime), math.ceil(time)) > 2 then
            --rect(enemy2.x,enemy2.y,WIDTH/12,HEIGHT/12)
            sprite("Project:pizza-slice",enemy2.x,enemy2.y,WIDTH/12)
            touching = false
            released=true
        end

        if(released==false) then
            enemy2.x=person.x
            enemy2.y=HEIGHT/2
        else
            --rect(enemy2.x,enemy2.y,WIDTH/12,HEIGHT/12)
            sprite("Project:pizza-slice",enemy2.x,enemy2.y,WIDTH/12)
            enemy2.y=enemy2.y-2
        end

        if(person.x>=WIDTH*7/8 and backwards==false) then
            backwards=true
        elseif(person.x<=WIDTH/6 and backwards) then
            backwards=false
        end

        if backwards then
            person.x = person.x - 2
        else
            person.x = person.x + 2
        end

    end

    if game == 8 then
        --enemy = position of red car
        --person = player position, use surf, use sin for vertical jump

        sprite("Project:surf",0,0,WIDTH,HEIGHT/4)
        sprite("Project:player_surf",person.x-WIDTH/11,person.y,WIDTH/5,HEIGHT/3)
        sprite("Project:red-car",enemy.x,enemy.y,WIDTH/4)
        enemy.x = enemy.x - 2.5
        if CurrentTouch.state == ENDED then
            touching = true
        end
        if touching and CurrentTouch.state == BEGAN then
            enemy2.x = 1
        end
        if enemy2.x == 1 and enemy2.y < 2.6 then
            person.y = math.sin(enemy2.y)*HEIGHT/3+HEIGHT/3
            enemy2.y = enemy2.y +.02
        end
        if enemy2.y >= 2.6 then
            if person.x > enemy.x and person.x < enemy.x + WIDTH/4 then
                winMiniGame()
            else
                loseMiniGame()
            end
        end
    end

    if game == 9 then
        sprite("Project:cop",0,0,WIDTH,HEIGHT/4)
        if CurrentTouch.state == ENDED then
            touching = true
        end
        if touching and CurrentTouch.state == BEGAN and released == false then
            enemy2.x = CurrentTouch.x
            enemy2.y = CurrentTouch.y
            touching = false
            released=true
        end
        for i = 1,3 do
            for j = 1,3 do
                if i ~= enemy.x or j ~= enemy.y then
                    --Draw regular car
                    sprite("Project:police-car",WIDTH/9+WIDTH/5+(i-1)*WIDTH/7, HEIGHT/10+HEIGHT/4.75+(j-1)*HEIGHT/5,WIDTH/8)
                    --rect(WIDTH/9+WIDTH/5+(i-1)*WIDTH/7, HEIGHT/10+HEIGHT/4.75+(j-1)*HEIGHT/5,WIDTH/8,WIDTH/10)
                end
                if (i == enemy.x and j == enemy.y) then
                    --Draw florida man car
                    --rect(WIDTH/9+WIDTH/5+(en-1)*WIDTH/7, HEIGHT/10+HEIGHT/4.75+(j-1)*HEIGHT/5,WIDTH/8,WIDTH/12)
                    --when sprite is implemented, change width/12 in y to width/10

                end
            end
        end
sprite("Project:florida-car",WIDTH/9+WIDTH/5+(enemy.x-1)*WIDTH/7, HEIGHT/10+HEIGHT/4.75+(enemy.y-1)*HEIGHT/5,WIDTH/8)


        --Check for touch
        if released then
            if enemy2.x >= WIDTH/9+WIDTH/5+(enemy.x-1)*WIDTH/7 and enemy2.x <= WIDTH/9+WIDTH/5+(enemy.x-1)*WIDTH/7 + WIDTH/8 and enemy2.y >= HEIGHT/10+HEIGHT/4.75+(enemy.y-1)*HEIGHT/5 and enemy2.y <= HEIGHT/10+HEIGHT/4.75+(enemy.y-1)*HEIGHT/5 + WIDTH/10 then
                winMiniGame()
            else
                loseMiniGame()
            end
        end



        end


    if game==10 then
        sprite("Project:naked_man",0,0,WIDTH,HEIGHT/4)
        sprite("Project:burglar",enemy.x,enemy.y,WIDTH/8,HEIGHT/6)

        if CurrentTouch.state == ENDED then
            touching = true
        end
        sprite("Project:player_XXX",person.x,person.y,WIDTH/8,HEIGHT/6)
        enemy.x = enemy.x + math.ceil(WIDTH/819)
        if (CurrentTouch.x > person.x and CurrentTouch.state == BEGAN) and touching then
            touching = false
            person.x = person.x + math.ceil(WIDTH/68)
        end
        if person.x > enemy.x then
            winMiniGame()
        end
        if enemy.x >=WIDTH then
            loseMiniGame()
        end
    end

    if game== 11 then
        sprite("Project:pepe_jeans",WIDTH/4,-80,WIDTH/2)
        if CurrentTouch.state == ENDED then
            touching = true
        end
        if touching and CurrentTouch.state == BEGAN then
            nextMiniGame()
        end
    end


    if lives < 0 then
        drawLives()
        fill(math.random(0,255),math.random(0,255),math.random(0,255),255)
        fontSize(75*WIDTH/1024)
        text("LMAO, You L0St",WIDTH/2,HEIGHT/2)
        fontSize(45*WIDTH/1024)
        text("tap to try again noob",WIDTH/2,HEIGHT/4)

    end




end