//
//  MapComponent.cpp
//  RPG
//
//  Created by Nolan Daigle on 12/18/15.
//  Copyright (c) 2015 Nolan Daigle. All rights reserved.
//

#include "MapComponent.h"
#include "Entity.h"
#include "EntityLibrary.h"

MapComponent::MapComponent(System *_system) : Component(_system)
{
    system = _system;
    name = "MapComponent";
    
    x = 0;
    y = 0;
    w = 16;
    h = 16;
    
    multiplication = 1.0;
}

MapComponent::~MapComponent()
{
}

void MapComponent::SetMap(Map *_map)
{
    if ( _map )
    {
        map = _map;
    }
}

void MapComponent::Multiply()
{
    EntityLibrary::instance()->Sort("Layer");
    for (std::vector<Entity*>::iterator it = map->tiles.begin() ; it != map->tiles.end(); ++it)
    {
        if ( (*it)->GetTransform() )
        {
            if (!(*it)->Updating())
                (*it)->SetUpdate(true);
            else
                (*it)->SetUpdate(false);
        }
    }
}

int MapComponent::GetWidth()
{
    if ( map )
        return map->GetWidth()*map->GetTileWidth();
    else
        return -1;
}

int MapComponent::GetHeight()
{
    if (map)
        return map->GetHeight()*map->GetTileHeight();
    else
        return -1;
}