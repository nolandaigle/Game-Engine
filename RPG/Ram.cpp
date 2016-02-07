//
//  Ram.cpp
//  RPG
//
//  Created by Nolan Daigle on 12/7/15.
//  Copyright (c) 2015 Nolan Daigle. All rights reserved.
//

#include "Ram.h"
#include "Title_Scene.h"

Ram::Ram()
{
}

Ram::~Ram()
{
    
}

void Ram::Bang()
{
    system.Load();
    
    system.GetWindow()->setKeyRepeatEnabled(false);
}

void Ram::Turn()
{
    Title_Scene *s = new Title_Scene(&system);
    s->Bang();
    
    while ( system.GetWindow()->isOpen() )
    {
        while ( system.GetWindow()->pollEvent( *system.GetEvent() ) )
        {
            s->Input(system.GetEvent());
        }
        
        s->Turn();
        
        system.GetWindow()->setView(*system.GetView());
        system.GetWindow()->clear();
        s->Display();
        system.GetWindow()->display();
    }
}

void Ram::Collapse()
{
    
}