//
//  Title_Scene.cpp
//  RPG
//
//  Created by Nolan Daigle on 12/9/15.
//  Copyright (c) 2015 Nolan Daigle. All rights reserved.
//

#include "Title_Scene.h"
#include "ResourcePath.hpp"

Title_Scene::Title_Scene(System *_system) : Scene(_system)
{
    eL->SetSystem(system);
    map = new Map(system);
}

void Title_Scene::Bang()
{
    map->Load(resourcePath()+"Resources/Maps/TestMap.json");
    eL->Sort("Layer");
    eL->SetMap(map);
}

void Title_Scene::Input(sf::Event *event)
{
    eL->Input(event);
    
    if ( event->type == sf::Event::KeyPressed )
    {
        if ( event->key.code == sf::Keyboard::Escape )
            system->GetWindow()->close();
    }
}

void Title_Scene::Turn()
{
  //  std::cout<<"FPS: "<<1/system->DeltaTime()<<std::endl;
    eL->Turn();
    
    std::cout<<eL->GetNextMap();
    if ( eL->GetNextMap() != "" )
    {
        ChangeMap("Resources/Maps/"+eL->GetNextMap() );
    }
}

void Title_Scene::Display()
{
    eL->Display();
    
    system->Display();
}

void Title_Scene::Collapse()
{
    eL->Clear();
    if ( map )
    {
        delete map;
        map = NULL;
    }
}

void Title_Scene::ChangeMap(std::string file)
{
    eL->nextMap = "";
    eL->Clear();
    map->Load(resourcePath()+file);
    eL->Sort("Layer");
}