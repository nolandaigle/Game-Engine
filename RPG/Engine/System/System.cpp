//
//  System.cpp
//  RPG
//
//  Created by Nolan Daigle on 12/7/15.
//  Copyright (c) 2015 Nolan Daigle. All rights reserved.
//

#include "System.h"
#include "EntityLibrary.h"
void System::Load()
{
    window = new sf::RenderWindow( sf::VideoMode(768, 720), "*_*" );
    view = new sf::View(sf::FloatRect(0, 0, 256, 240));
    window->setView(*view);
}

System::System()
{
    size = 1;
    dt = 0;
}

System::~System()
{
    if ( window != NULL )
        delete window;
    if ( view != NULL )
        delete view;
}

void System::Display()
{
    GetView()->setSize(size*256, size*240);
    textbox.Update( GetView()->getCenter().x - 160,GetView()->getCenter().y - 120, DeltaTime() );
    textbox.Display(GetWindow());
    
    dt = frameTimer.getElapsedTime().asSeconds();
    frameTimer.restart();
}

void System::Signal(std::string signal)
{
    EntityLibrary::instance()->Signal(signal);
}

void System::Message(std::string entity, std::string message)
{
    EntityLibrary::instance()->Message(entity, message);
}