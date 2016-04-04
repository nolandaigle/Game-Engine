//
//  Title_Scene.cpp
//  RPG
//
//  Created by Nolan Daigle on 12/9/15.
//  Copyright (c) 2015 Nolan Daigle. All rights reserved.
//

#include "Game_Scene.h"
#include "ResourcePath.hpp"

Game_Scene::Game_Scene(System *_system) : Scene(_system)
{
    map = new Map(system);
    eL->SetSystem(system);
}

void Game_Scene::Bang()
{
    //Load MAP
    map->Load(resourcePath()+"Resources/Maps/Intro.json");
    //Sort entities by layer
    eL->Sort("Layer");
    //Give the entity library a pointer to the loaded map
    eL->SetMap(map);
}

void Game_Scene::Input(sf::Event *event)
{
    //Run each entity's input function
    eL->Input(event);
    
    //If the esc key is pressed, close the window
    if ( event->type == sf::Event::KeyPressed )
    {
        if ( event->key.code == sf::Keyboard::Escape )
            system->GetWindow()->close();
    }
}

void Game_Scene::Turn()
{
    if ( system->GetSleep() > 0 )
    {
        system->Sleep();
    }
    else
    {
        //Run each entity in the Entity List's turn function
        eL->Turn();
        
        //If any of the entities have changed the map, change the map
        if ( eL->GetNextMap() != "" )
        {
            ChangeMap("Resources/Maps/"+eL->GetNextMap() );
            eL->SetMap(map);
        }
    }
    
    std::cout<<"FPS: "<<system->GetFPS()<<std::endl;
}

void Game_Scene::Display()
{
    //Entity Library display
    eL->Display();
    
    //Run System's Display functions
    system->Display();
}

void Game_Scene::Collapse()
{
    //Clear the entity library
    eL->Clear();
    
    //If there is still a map loaded, delete it
    if ( map )
    {
        delete map;
        map = NULL;
    }
}

void Game_Scene::ChangeMap(std::string file)
{
    eL->SetNextMap("");
    eL->Clear();
    map->Load(resourcePath()+file);
    eL->Sort("Layer");
}