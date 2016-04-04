//
//  Ram.cpp
//  RPG
//
//  Created by Nolan Daigle on 12/7/15.
//  Copyright (c) 2015 Nolan Daigle. All rights reserved.
//

#include "Ram.h"
#include "Game_Scene.h"

Ram::Ram()
{
}

Ram::~Ram()
{
    
}

void Ram::Bang()
{
    //If system loads correctly
    system.Load();
    system.GetWindow()->setKeyRepeatEnabled(false);
}

void Ram::Turn()
{
    //Create new game scene, initialize and load it
    Game_Scene *s = new Game_Scene(&system);
    s->Bang();
    
    //Main game loop that will run as long as the window is open
    while ( system.GetWindow()->isOpen() )
    {
        //If user gives any input, run input code
        while ( system.GetWindow()->pollEvent( *system.GetEvent() ) )
        {
            s->Input(system.GetEvent());
        }
        
        //Update the game scene
        s->Turn();
        
        //Clear window, display game scene, update window
        system.GetWindow()->clear(system.GetScreenColor());
        s->Display();
        system.GetWindow()->display();
    }
    //Delete the Game Scene
    delete s;
}

void Ram::Collapse()
{
    
}