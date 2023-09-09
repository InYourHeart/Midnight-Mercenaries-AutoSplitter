//PS: Code structure is for readability 

state("Midnight Mercenaries")
{
    int roomNumber: 0x6561E0;
    int inSetup: 0x443D44, 0xF70, 0xCC;
    int fadeValue: 0x445C40, 0x60, 0x10, 0x9AC, 0x4E4;
}

startup 
{
    settings.Add("isIndividualLevel", true, "Individual Level");
}

start
{
    //Individual level start
    if (settings["isIndividualLevel"]){
        //Training room
        if (current.roomNumber == 14 && old.roomNumber == 1){
            return true;
        }

        //All other levels (fadeValue used to not trigger when using restart on death)
        if (current.inSetup == 0 && old.inSetup != 0 && current.fadeValue == 0){
            return true;
        }
    } 
    
    //Full game start
    if (!settings["isIndividualLevel"]){
        //Training room transition
        if (current.roomNumber == 14 && old.roomNumber == 1){
            return true;
        }
    }
}

split
{
    //Individual levels
    if (settings["isIndividualLevel"]){
        //Training Room
        if (current.roomNumber == 4 && old.roomNumber == 14){
            return true;
        }

        //All other levels
        if (current.roomNumber == 5 && old.roomNumber != 5){
            return true;
        }
    }

    //Full game
    if (!settings["isIndividualLevel"]){
        //Training room split (first split) (no performance report in this level)
        if (current.roomNumber == 4 && old.roomNumber == 14){
            return true;
        }

        //Performance report split (Except Sunrise)
        if (current.roomNumber == 5 && old.roomNumber != 5 && old.roomNumber != 127){
            return true;
        }

        //Sunrise split (last split)
        if (current.roomNumber == 6 && old.roomNumber == 11){
            return true;
        }
    }
}

reset
{
    //Individual level
    if (settings["isIndividualLevel"]){
        //Restart
        if (current.inSetup != 0 && old.fadeValue != 0 &&
            (current.roomNumber == 17 ||
            current.roomNumber == 20 ||
            current.roomNumber == 22 ||
            current.roomNumber == 25 ||
            current.roomNumber == 27 ||
            current.roomNumber == 29 ||
            current.roomNumber == 33 ||
            current.roomNumber == 35 ||
            current.roomNumber == 38 ||
            current.roomNumber == 41 ||
            current.roomNumber == 45 ||
            current.roomNumber == 47 ||
            current.roomNumber == 52 ||
            current.roomNumber == 57 ||
            current.roomNumber == 60 ||
            current.roomNumber == 64 ||
            current.roomNumber == 68 ||
            current.roomNumber == 73 ||
            current.roomNumber == 80 ||
            current.roomNumber == 85 ||
            current.roomNumber == 91 ||
            current.roomNumber == 94 ||
            current.roomNumber == 97 ||
            current.roomNumber == 107 ||
            current.roomNumber == 115)){
            return true;
        }
    }

    //Exiting to main menu
    if (current.roomNumber == 1 && old.roomNumber != 1){
        return true;
    }
}
