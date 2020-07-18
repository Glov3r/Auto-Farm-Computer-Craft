if fs.exists("VALUES") == false then
        h = fs.open("VALUES", "w")
        h.writeLine(0) h.writeLine(0) h.writeLine(0) h.writeLine(1)
        h.writeLine(0) h.writeLine(0) h.writeLine(0) h.writeLine(0)
        h.writeLine(0) h.writeLine(0) h.writeLine(0) h.writeLine(0)
        h.writeLine(0) h.writeLine(0) h.writeLine(0) h.writeLine(0)
        h.writeLine(0) h.writeLine(0) h.writeLine(0) h.writeLine(0)
        h.writeLine(0) h.writeLine(0) h.writeLine(0) h.writeLine(0)
        h.writeLine(1)
        h.close()
end
h = fs.open("VALUES", "r")
x = (tonumber(h.readLine()*1))
y = (tonumber(h.readLine()*1))
z = (tonumber(h.readLine()*1))
f = (tonumber(h.readLine()*1))
tgtx = (tonumber(h.readLine()*1))
tgty = (tonumber(h.readLine()*1))
tgtz = (tonumber(h.readLine()*1))
tgtf = (tonumber(h.readLine()*1))
distance = (tonumber(h.readLine()*1))
slot = (tonumber(h.readLine()*1))
wallslot = (tonumber(h.readLine()*1))
wall = (tonumber(h.readLine()*1))
nextturn = (tonumber(h.readLine()*1))
ufmode = (tonumber(h.readLine()*1))
items = (tonumber(h.readLine()*1))
titems = (tonumber(h.readLine()*1))
tgtfuel = (tonumber(h.readLine()*1))
ichestside = (tonumber(h.readLine()*1))
fchestside = (tonumber(h.readLine()*1))
option = (tonumber(h.readLine()*1))
mfmode = (tonumber(h.readLine()*1))
delay = (tonumber(h.readLine()*1))
runlevel = (tonumber(h.readLine()*1))
remaining = (tonumber(h.readLine()*1))
step = (tonumber(h.readLine()*1))
h.close()
ls = {}
repeat
        slot = (slot + 1)
                ls[slot] = turtle.getItemCount(slot)
until slot == 16
function save()
        h = fs.open("VALUES", "w")
        h.writeLine(x) h.writeLine(y) h.writeLine(z) h.writeLine(f)
        h.writeLine(tgtx) h.writeLine(tgty) h.writeLine(tgtz) h.writeLine(tgtf)
        h.writeLine(distance) h.writeLine(slot) h.writeLine(wallslot) h.writeLine(wall)
        h.writeLine(nextturn) h.writeLine(ufmode) h.writeLine(items) h.writeLine(titems)
        h.writeLine(tgtfuel) h.writeLine(ichestside) h.writeLine(fchestside) h.writeLine(option)
        h.writeLine(mfmode) h.writeLine(delay) h.writeLine(runlevel) h.writeLine(remaining)
        h.writeLine(step)
        h.close()
end
function forward()
        if turtle.detect() == true then matching() if wall == 0 then turtle.dig() end end
        if turtle.forward() == true then
        distance = (distance + 1)
        if f == 1 then z = (z + 1)
        elseif f == 2 then x = (x + 1)
        elseif f == 3 then z = (z - 1)
        elseif f == 4 then x = (x - 1)
        end
        end
        save()
end
function right()
        turtle.turnRight()
        if f == 4 then f = 1 else f = (f + 1) end
        save()
end
function left()
        turtle.turnLeft()
        if f == 1 then f = 4 else f = (f - 1) end
        save()
end
function up()
        if turtle.up() == true then
        distance = (distance + 1)
        y = (y + 1)
        save()
        end
end
function down()
        if turtle.down()== true then
        distance = (distance + 1)
        y = (y - 1)
        end
        save()
end
function rotate(tgtf)
        if tgtf ~= f then
                if (tgtf - 3) == f then left()
                elseif (tgtf + 3) == f then right()
                elseif tgtf < f == true
                        then repeat left() until f == tgtf
                        else repeat right() until f == tgtf
                end
        end
        save()
end
function firstturn()
        if nextturn == 1
                then left()
                else right()
        end
end
function secondturn()
        forward()
        if nextturn == 1
                then left()
                nextturn = 0
                else right()
                nextturn = 1
        end
end
function setup(tgtfuel)
        slot = 0
                if ichestside == 2 then rotate(2)
                elseif ichestside == 5 then rotate(3)
                elseif ichestside == 4 then rotate(4)
                end
                titems = titems + (ls[1] + ls[2] + ls[3] + ls[4] +
                ls[5] + ls[6] + ls[7] + ls[8] + ls[9] +
                ls[10] + ls[11] + ls[12] + ls[13] + ls[14]+
                ls[15] + ls[16] - 1)
                repeat
                        slot = (slot + 1)
                        turtle.select(slot)
                        if slot ~= wallslot then
                                if ichestside == 1 then turtle.dropUp()
                                        elseif ichestside == 3 then turtle.dropDown()
                                        elseif ichestside == 2 or ichestside == 4 or ichestside == 5 then turtle.drop()
                                end
                        end
                until slot == 16
        if tgtfuel > 0 then
                if fchestside == 2 then rotate(2)
                elseif fchestside == 5 then rotate(3)
                elseif fchestside == 4 then rotate(4)
                end
                if turtle.getFuelLevel() == "unlimited" then ufmode = 1 else ufmode = 0 end
                if ufmode == 0 then
                        turtle.select(1)
                        repeat
                                if fchestside == 1 then turtle.suckUp()
                                elseif fchestside == 3 then turtle.suckDown()
                                elseif fchestside == 2 or fchestside == 4 or fchestside == 5 then turtle.suck()
                                end
                                repeat
                                        ls[1] = turtle.getItemCount(1)
                                        turtle.refuel(1)
                                        if ls[1] == turtle.getItemCount(1) then if wallslot < 16 then turtle.transferTo(wallslot + 1) else turtle.transferTo(wallslot - 1) end end
                                until turtle.getFuelLevel() > tgtfuel or turtle.getItemCount(1) == 0
                        until turtle.getFuelLevel() > tgtfuel
                end
                slot = 0
        repeat
                slot = (slot + 1)
                if slot ~= wallslot then
                        turtle.select(slot)
                        if ichestside == 1 then turtle.dropUp()
                        elseif ichestside == 3 then turtle.dropDown()
                        elseif ichestside == 2 or ichestside == 4 or ichestside == 5 then turtle.drop()
                        end
                end
        until slot == 16
        slot = 0
        turtle.select(1)
        end
        rotate(1)
end
function go(tgtx, tgty, tgtz, tgtf)
        if y ~= tgty then
                repeat
                        if x < 0 then rotate(2)
                        elseif x > 0 then rotate(4)
                        end
                        if turtle.detect() == false and x ~= 0 then repeat forward() until x == 0 or turtle.detect() == true end
                        if z < 0 then rotate(1)
                        elseif z > 0 then rotate(3)
                        end
                        if turtle.detect() == false and z ~= 0 then repeat forward() until z == 0 or turtle.detect() == true end
                        if y < tgty then if turtle.detectUp() == false then repeat up() until y == tgty or turtle.detectUp() == true end
                        elseif y > tgty then if turtle.detectDown() == false then repeat down() until y == tgty or turtle.detectDown() == true end
                        end
                until (x == 0) == true and (z == 0) == true and (y == tgty) == true
                repeat
                        if x < tgtx then rotate(2)
                        elseif x > tgtx then rotate(4)
                        end
                        if turtle.detect() == false and x ~= tgtx then repeat forward() until x == tgtx or turtle.detect() == true end
                        if z < tgtz then rotate(1)
                        elseif z > tgtz then rotate(3)
                        end
                        if turtle.detect() == false and z ~= tgtz then repeat forward() until z == tgtz or turtle.detect() == true end
                until (x == tgtx) == true and (z == tgtz) == true
        else
                repeat
                        if z < tgtz then rotate(1)
                        elseif z > tgtz then rotate(3)
                        end
                        if turtle.detect() == false and z ~= tgtz then repeat forward() until z == tgtz or turtle.detect() == true end
                        if x < tgtx then rotate(2)
                        elseif x > tgtx then rotate(4)
                        end
                        if turtle.detect() == false and x ~= tgtx then repeat forward() until x == tgtx or turtle.detect() == true end
                until (x == tgtx) == true and (z == tgtz) == true
        end
        rotate(tgtf)
end
function matching()
        turtle.select(wallslot)
        if turtle.compare() == true
                then wall = 1
                else wall = 0
        end
        turtle.select(1)
end
function core()
        ls = {}
        turtle.select(1)
        slot = 0
        if turtle.detectDown() == true
                then
                repeat
                        slot = (slot + 1)
                        ls[slot] = turtle.getItemCount(slot)
                until slot == 16
                turtle.digDown()
                slot = 0
                repeat
                        slot = (slot + 1)
                until ls[slot] ~= turtle.getItemCount(slot) or slot == 16
                if wallslot ~= slot then
                turtle.select(slot)
                turtle.placeDown()
                end
                if turtle.detectDown() == false and slot ~= 16
                        then
                        repeat
                                slot = (slot + 1)
                                turtle.select(slot)
                                if slot ~= wallslot then turtle.placeDown() end
                        until turtle.detectDown() == true or slot == 16
                end
                slot = 0
                turtle.select(1)
        end
        matching()
        if wall == 0 and turtle.detect() == true
                then
                turtle.dig()
                turtle.suck()
                turtle.suckUp()
                turtle.suckDown()
        end
end
function info()
        term.clear()
        term.setCursorPos(1,1)
        print("[                  LAST HARVEST INFO               ]")
        print("---------------------------------------")
        term.setCursorPos(1,3)
        print("Total blocks travelled:".. distance)
        term.setCursorPos(1,5)
        print("Total items harvested:".. titems)
        term.setCursorPos(1,12)
        print("---------------------------------------")
        term.setCursorPos(1,11)
        print("Press any key to exit")
        os.pullEvent("key")
end
function options()
        repeat
                repeat
                        term.clear()
                        term.setCursorPos(1,1)
                        print("[                   MFAS V2 OPTIONS                 ]")
                        print("---------------------------------------")
                        term.setCursorPos(1,3)
                        print("1-Multi floor mode")
                        term.setCursorPos(1,5)
                        print("2-Change sides of chests")
                        term.setCursorPos(1,7)
                        print("3-Change sleeping time")
                        term.setCursorPos(1,9)
                        print("4-Back to main menu")
                        term.setCursorPos(1,11)
                        print("Type the number and press enter")
                        term.setCursorPos(1,12)
                        print("---------------------------------------")
                        term.setCursorPos(1,13)
                        option = (io.read() * 1)
                until option == 1 or option == 2 or option == 3 or option == 4
                if option == 1 then
                repeat
                        term.clear()
                        term.setCursorPos(1,1)
                        print("[                   MULTIFLOOR MODE                 ]")
                        print("---------------------------------------")
                        term.setCursorPos(1,3)
                        print("1-Enable")
                        term.setCursorPos(1,5)
                        print("0-Disable")
                        term.setCursorPos(1,11)
                        print("Type the number and press enter")
                        term.setCursorPos(1,12)
                        print("---------------------------------------")
                        term.setCursorPos(1,13)
                        mfmode = (io.read() * 1)
                until mfmode == 1 or mfmode == 0
                elseif option == 2 then
                repeat
                        term.clear()
                        term.setCursorPos(1,1)
                        print("[                   FUEL CHEST SIDE                 ]")
                        print("---------------------------------------")
                        term.setCursorPos(1,3)
                        print("1-Up")
                        term.setCursorPos(1,4)
                        print("2-Right")
                        term.setCursorPos(1,5)
                        print("3-Bottom")
                        term.setCursorPos(1,6)
                        print("4-Left")
                        term.setCursorPos(1,7)
                        print("5-Back")
                        term.setCursorPos(1,11)
                        print("Type the number and press enter")
                        term.setCursorPos(1,12)
                        print("---------------------------------------")
                        term.setCursorPos(1,13)
                        fchestside = (io.read() * 1)
                until fchestside == 1 or fchestside == 2 or fchestside == 3 or fchestside == 4 or fchestside == 5
                repeat
                        term.clear()
                        term.setCursorPos(1,1)
                        print("[                   ITEM CHEST SIDE                 ]")
                        print("---------------------------------------")
                        term.setCursorPos(1,3)
                        print("1-Up")
                        term.setCursorPos(1,4)
                        print("2-Right")
                        term.setCursorPos(1,5)
                        print("3-Bottom")
                        term.setCursorPos(1,6)
                        print("4-Left")
                        term.setCursorPos(1,7)
                        print("5-Back")
                        term.setCursorPos(1,11)
                        print("Type the number and press enter")
                        term.setCursorPos(1,12)
                        print("---------------------------------------")
                        term.setCursorPos(1,13)
                        ichestside = (io.read() * 1)
                        until (ichestside == 1 or ichestside == 2 or ichestside == 3 or ichestside == 4 or ichestside == 5) == true and fchestside ~= ichestside
                elseif option == 3 then
                repeat
                        term.clear()
                        term.setCursorPos(1,1)
                        print("[                        SLEEPING TIME                   ]")
                        print("---------------------------------------")
                        print("Hours between harvests? Can be a decimal number using a dot.")
                        print("")
                        print("i.e 0.5 -> 30 minutes")
                        term.setCursorPos(1,13)
                        delay = (io.read() * 1)
                until delay >= 0
                end
        until option == 4
end
function gui()
        repeat
                term.clear()
                term.setCursorPos(1,1)
                print("[                           MFAS V2                         ]")
                print("---------------------------------------")
                term.setCursorPos(1,3)
                print("1-Run now")
                term.setCursorPos(1,5)
                print("2-Options")
                term.setCursorPos(1,7)  
                print("3-Last harvest info")
                term.setCursorPos(1,9)
                print("4-Close MFAS")
                term.setCursorPos(1,11)
                print("Type the number and press enter")
                term.setCursorPos(1,12)
                print("---------------------------------------")
                term.setCursorPos(1,13)
                repeat
                        term.setCursorPos(1,13)
                        option = io.read()*1
                until option == 1 or option == 2 or option == 3 or option == 4
                if option == 2 then
                        options()
                elseif option == 3 then
                        info()
                elseif option == 4 then
                        save()
                        term.clear()
                        term.setCursorPos(1,1)
                        print("Thanks for using MFAS - Mendoza")
                        sleep(3)
                        os.reboot()
                end
        until option == 1
        term.clear()
end
function main()
        turtle.dig()
        forward()
        rotate(4)
        matching()
        if turtle.detect() == true and wall == 1
                then
                nextturn = 0
                else
                nextturn = 1
        end     
        rotate(1)
        while true do
        save()
        core()
        if (turtle.getFuelLevel() == ((math.abs(x)) + (math.abs(y)) + (math.abs(z)) + 50) and ufmode == 0) == true then
                tgtx = x
                tgty = y
                tgtz = z
                tgtf = f
                go(0, 0, 0, 1)
                setup(1000)
                go(tgtx, tgty, tgtz, tgtf)
        elseif full() == true then
                tgtx = x
                tgty = y
                tgtz = z
                tgtf = f
                go(0, 0, 0, 1)
                setup(0)
                go(tgtx, tgty, tgtz, tgtf)
                end
        save()
        if turtle.detect() == false
                then
                forward()
                turtle.suckDown()
                else
                turtle.suckDown()
                firstturn()
                matching()
                if turtle.detect() == true and wall == 1
                then break
                else
                if wall == 0 and turtle.detect() == true
                then
                        turtle.dig()
                        turtle.suck()
                        turtle.suckUp()
                        turtle.suckDown()
                end
                secondturn()
                end
        end
        end
        go(0, y, 0, 1)
end
function wait()
        term.clear()
        if remaining <= 0 then remaining = (delay*3600) end
        repeat
                remaining = remaining - 1
                save()
                sleep(1)
        until remaining <= 0
        term.clear()
        step = 1
        save()
end
function full()
        if wallslot == 16 then
                if turtle.getItemCount(15) > 0 then return true
                else return false end
        elseif wallslot ~= 16 then
                if turtle.getItemCount(16) > 0 then return true
                else return false end
        end
end
save()
if runlevel == 0 then
term.clear()
term.setCursorPos(1,1)
print("[                           MFAS V2                         ]")
print("---------------------------------------")
term.setCursorPos(1,3)
print("Welcome to MFAS V2. Please, add to the inventory of the turtle the block which are made the walls of the farm, and press a key")
os.pullEvent("key")
        repeat
                wallslot = (wallslot + 1)
                turtle.select(wallslot)
        until turtle.getItemCount(wallslot) > 0
if wallslot == 1 then
        wallslot = 16
        turtle.select(1)
        turtle.transferTo(16)
        turtle.select(1)
end
turtle.select(1)
term.clear()
term.setCursorPos(1,1)
print("[                           MFAS V2                         ]")
print("---------------------------------------")
term.setCursorPos(1,3)
print("Before starting, set the options in the next page")
os.pullEvent("key")
repeat
        term.clear()
        term.setCursorPos(1,1)
        print("[                   MULTIFLOOR MODE                 ]")
        print("---------------------------------------")
        term.setCursorPos(1,3)
        print("1-Enable")
        term.setCursorPos(1,5)
        print("0-Disable")
        term.setCursorPos(1,11)
        print("Type the number and press enter")
        term.setCursorPos(1,12)
        print("---------------------------------------")
        term.setCursorPos(1,13)
        mfmode = (io.read() * 1)
until mfmode == 1 or mfmode == 0
save()
repeat
        term.clear()
        term.setCursorPos(1,1)
        print("[                   FUEL CHEST SIDE                 ]")
        print("---------------------------------------")
        term.setCursorPos(1,3)
        print("1-Up")
        term.setCursorPos(1,4)
        print("2-Right")
        term.setCursorPos(1,5)
        print("3-Bottom")
        term.setCursorPos(1,6)
        print("4-Left")
        term.setCursorPos(1,7)
        print("5-Back")
        term.setCursorPos(1,11)
        print("Type the number and press enter")
        term.setCursorPos(1,12)
        print("---------------------------------------")
        term.setCursorPos(1,13)
        fchestside = (io.read() * 1)
until fchestside == 1 or fchestside == 2 or fchestside == 3 or fchestside == 4 or fchestside == 5
save()
repeat
        term.clear()
        term.setCursorPos(1,1)
        print("[                   ITEM CHEST SIDE                 ]")
        print("---------------------------------------")
        term.setCursorPos(1,3)
        print("1-Up")
        term.setCursorPos(1,4)
        print("2-Right")
        term.setCursorPos(1,5)
        print("3-Bottom")
        term.setCursorPos(1,6)
        print("4-Left")
        term.setCursorPos(1,7)
        print("5-Back")
        term.setCursorPos(1,11)
        print("Type the number and press enter")
        term.setCursorPos(1,12)
        print("---------------------------------------")
        term.setCursorPos(1,13)
        ichestside = (io.read() * 1)
until (ichestside == 1 or ichestside == 2 or ichestside == 3 or ichestside == 4 or ichestside == 5) == true and fchestside ~= ichestside
save()
repeat
        term.clear()
        term.setCursorPos(1,1)
        print("[                        SLEEPING TIME                   ]")
        print("---------------------------------------")
        print("Hours between harvests? Can be a decimal number using a dot.")
        print("")
        print("i.e 0.5 -> 30 minutes")
        term.setCursorPos(1,13)
        delay = (io.read() * 1)
until delay >= 0
runlevel = 1
end
function wait()
        if remaining <= 0 and step == 2 then remaining = (delay*3600) end
        repeat
                remaining = remaining - 1
                sleep(1)
        until remaining <= 0
end
function redstone()
        os.pullEvent("redstone")
        term.clear()
end
save()
if step == 1 then gui() end
while true do
        if step == 1 then
                titems = 0
                if distance == 0 then setup(1000) else setup(distance) distance = 0 end
                if mfmode == 1 then
                        while turtle.detectDown() == false do
                                down()
                        end
                        main()
                        while turtle.detectUp() == false do
                                while turtle.detect() == false do
                                        up()
                                end
                                repeat
                                        up()
                                until turtle.detect() == false
                                main()
                        end
                        go(0, 0, 0, 1)
                else main() end
                repeat
                        slot = (slot + 1)
                        ls[slot] = turtle.getItemCount(slot)
                until slot == 16
                setup(0)
                save()
                step = 2
                save()
        else
        parallel.waitForAny(wait, redstone, gui)
        term.clear()
        step = 1
        save()
        end
end
[font=tahoma, geneva, sans-serif][size=5]
