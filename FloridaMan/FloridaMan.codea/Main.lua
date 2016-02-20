-- Florida man

-- Use this function to perform your initial setup
function setup()
    person = vec2(WIDTH/4,HEIGHT/4)
    game = 1
    rectMode(CORNER)
    spriteMode(CORNER)
    touching = false
    time = ElapsedTime
    lives = 3
    enemy = vec2(WIDTH/2,0)
end

-- This function gets called once every frame
function draw()
    -- This sets a dark background color 
    background(255, 255, 255, 255)
    for i = 1,3 do
        fontSize(90)
        if i <= lives then
        text("❤️",WIDTH/8,HEIGHT-i*HEIGHT/8)
            else
            text("💔",WIDTH/8,HEIGHT-i*HEIGHT/8)
            end
    end
    if game == 1 then
        sprite("Project:bees headline",0,HEIGHT/7.5,WIDTH)
        fill(255, 0, 0, 255)
        if CurrentTouch.state == ENDED then
            touching = false
        end
   -- rect(person.x,person.y,WIDTH/25,HEIGHT/8)
        sprite("Project:player",person.x,person.y,WIDTH/20,HEIGHT/12)
        if (CurrentTouch.x > person.x and CurrentTouch.state ~= ENDED) or touching then
            touching = true
            person.x = person.x + 1.25
        end
        if person.x >= WIDTH*7/8 then
            game = game + 1
        end
        sprite("Project:honey",WIDTH*7/8,person.y)
        sprite("Project:bee",enemy.x,math.sin(enemy.y)*HEIGHT/4+HEIGHT/8,HEIGHT/8)
            enemy.y = enemy.y + .01
        if (math.sin(enemy.y)*HEIGHT/4+HEIGHT/8) < (person.y+HEIGHT/12) and math.sin(enemy.y)*HEIGHT/4+HEIGHT/4 > person.y and person.x > enemy.x and person.x+WIDTH/20 < enemy.x+HEIGHT/8 then
            lives = lives - 1
            game = game + 1
        end
        end
    -- This sets the line thickness

    -- Do your drawing here
    
end

