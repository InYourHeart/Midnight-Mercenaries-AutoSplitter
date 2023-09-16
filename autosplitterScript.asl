//PS: Code structure is for readability 

state("Midnight Mercenaries")
{
    int roomNumber: 0x6561E0;
    int inSetup: 0x02984BD0, 0x280, 0xC, 0xD8;
    int selectedMercenary: 0x445C40, 0x60, 0x10, 0x25C, 0x444;
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

        //All other levels (check for setup flag and mercenary selection)
        if (current.inSetup == 0 && old.inSetup != 0 && current.selectedMercenary != 0 && old.selectedMercenary == 0){
            //In Sunrise, ignore it if we are not in the first level (Sniper)
            if (current.roomNumber == 117 ||
                current.roomNumber == 118 ||
                current.roomNumber == 119 ||
                current.roomNumber == 121 ||
                current.roomNumber == 122 ||
                current.roomNumber == 125 ||
                current.roomNumber == 126) {
                return false;
            }

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
        if (current.inSetup != 0 && current.selectedMercenary == 0 && old.selectedMercenary != 0)){
            return true;
        }
    }

    //Exiting to main menu
    if (current.roomNumber == 1 && old.roomNumber != 1){
        return true;
    }
}
