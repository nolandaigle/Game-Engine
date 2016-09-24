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
    
    overlay = sf::RectangleShape(sf::Vector2f(system->GetWindow()->getSize().x,system->GetWindow()->getSize().y));
    fadein = 255;
    fadeout = 0;
    file = "";
}

void Game_Scene::Bang()
{
    //Load MAP
    map->Load(resourcePath()+"Resources/Maps/Logo.json");
    eL->Bang();
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
        }
    }
}

void Game_Scene::Display()
{
    //Entity Library display
    eL->Display();
    
    //Run System's Display functions
    system->Display();
    
    if ( leaving == true )
    {
        if ( fadeout < 255 )
        {
            fadeout = fadeout + 15;
            overlay.setFillColor(sf::Color(0, 0, 0, fadeout));
            system->GetWindow()->draw(overlay);
        }
        else
        {
            leaving = false;
            eL->SetNextMap("");
            eL->Clear();
            delete map;
            map = NULL;
            map = new Map(system);
            map->Load(resourcePath()+file);
            eL->Bang();
            eL->Sort("Layer");
            eL->SetMap(map);
            fadein = 255;
        }
    }
    
    if (fadein > 0 )
    {
        fadein = fadein - 15;
        overlay.setFillColor(sf::Color(0, 0, 0, fadein));
        system->GetWindow()->draw(overlay);
    }
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

void Game_Scene::ChangeMap(std::string _file)
{
    file = _file;
    if ( leaving == false )
    {
        leaving = true;
        fadeout = 0;
    }
}