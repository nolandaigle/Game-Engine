//
//  EntityLibrary.cpp
//  RPG
//
//  Created by Nolan Daigle on 12/27/15.
//  Copyright (c) 2015 Nolan Daigle. All rights reserved.
//

#include "EntityLibrary.h"

//global singleton
EntityLibrary *EntityLibrary::s_instance = NULL;

Entity *EntityLibrary::AddEntity(int x, int y, std::string name, bool updating, std::string info)
{
    //The entity has been changed
    changed = true;
    if ( system )
    {
        //If an entity with this name already exists
        if ( entities[name] )
        {
            //the number of entities of this type
            int num = 0;
            //Sets the type of the entity to its name
            std::string type = name;
            
            /* --- Check how many entities share the same type in the library and add that number to the end of its name -- */
            std::ostringstream oss;
            oss<<name;
            
            while ( entities[oss.str()] )
            {
                oss.str("");
                oss<<name<<"_"<<num;
                num += 1;
            }
            /* --- --- -- */
            
            //Create a new Entity with that name and the given type, x, y, and whether or not the entity is updated every frame (some entities, like tiles, are for the most part static and do not need updating every frame)
            entities[oss.str()] = new Entity(x, y, system, updating);
            entities[oss.str()]->SetType(type);
            entities[oss.str()]->SetName(oss.str());
            entities[oss.str()]->BangInfo = info;
            //Return a pointer to the newly created entity
            return entities[oss.str()];
        }
        else //Otherwise...
        {
            //Create a new Entity the given name, type, x, y, and whether or not the entity is updated every frame
            entities[name] = new Entity(x, y, system, updating);
            entities[name]->SetName(name);
            entities[name]->SetType(name);
            entities[name]->BangInfo = info;
            //Return a pointer to the newly created entity
            return entities[name];
        }
    }
    return NULL;
}

EntityLibrary::EntityLibrary()
{
    fpsTimer = 0;
    fps = 0;
}

void EntityLibrary::SetMap(Map *map)
{
    for (std::map<std::string, Entity*>::iterator it = entities.begin() ; it != entities.end(); ++it)
    {
        if ( map )
            it->second->SetMap(map);
    }
}


void EntityLibrary::Bang()
{    
    for (std::map<std::string, Entity*>::iterator it = entities.begin() ; it != entities.end(); ++it)
    {
        it->second->Bang();
    }
}

void EntityLibrary::Input(sf::Event *event)
{
    for (std::map<std::string, Entity*>::iterator it = entities.begin() ; it != entities.end(); ++it)
    {
        if ( it->second->Updating() )
            it->second->Input(event);
    }
}

void EntityLibrary::Turn()
{
    fpsTimer += system->DeltaTime();
    if ( fpsTimer > fps )
    {
        fpsTimer = 0;
        for (std::map<std::string, Entity*>::iterator it = entities.begin() ; it != entities.end(); ++it)
        {
            if (it->second->Updating())
            {
                it->second->Turn();
            }
        }
        for (std::map<std::string, Entity*>::iterator it = entities.begin() ; it != entities.end(); ++it)
        {
            if (it->second->Updating())
            {
                it->second->LateTurn();
            }
        }
    }
}

void EntityLibrary::Display()
{
    //Loops through each draw layer
    for ( int i = 0; i <= 3; i++ )
    {
        //loops through all entities
        for (std::map<std::string, Entity*>::iterator it = entities.begin() ; it != entities.end(); ++it)
        {
            //If the entity has a Graphic Component and it is on the current layer
            if ( ( it->second->GetGC() || it->second->GetGUI() ) && it->second->GetLayer() == i )
            {
                //If it has a transform, check if transform is within screen limits
                if ( it->second->GetTransform() )
                {
                    if ( OnScreen(it->second->GetTransform()) == true || it->second->GetGC()->IsBypassCulling() == true )
                        it->second->Display();
                }
                else //Otherwise just display
                    it->second->Display();
            }
        }
        //If the entity list has been changed, update the collider list and reset changed variable
        if ( changed == true )
        {
            Sort("Layer");
            changed = false;
        }
    }
}

void EntityLibrary::RemoveEntity(std::string name)
{
    //Entity list has been changed
    changed = true;
    //If there is an entity of that name, deconstruct, delete, and remove it from the library
    if ( entities[name] != NULL )
    {
        entities[name]->Collapse();
        delete entities[name];
        entities[name] = NULL;
        entities.erase(name);
    }
}

void EntityLibrary::Clear()
{
    for (std::map<std::string, Entity*>::iterator it = entities.begin() ; it != entities.end(); ++it)
    {
        it->second->Collapse();
        delete it->second;
        it->second = NULL;
    }
    entities.clear();
}

void EntityLibrary::Signal(std::string signal)
{
    for (std::map<std::string, Entity*>::iterator it = entities.begin() ; it != entities.end(); ++it)
    {
        it->second->RecieveSignal(signal);
    }
}

void EntityLibrary::Message(std::string entity, std::string message)
{
    //If you send a message to the entity "Map" then the message will be interpreted as the map you would like to change to
    if ( entity == "Map" )
        nextMap = message;
    else if ( entity == "MapColor" )
    {
        if ( message == "White" )
        {
            system->SetScreenFillColor(255,255,255,0);
        }
        else if ( message == "Blue" )
        {
            system->SetScreenFillColor(0,0,255,100);
        }
        else if ( message == "Red" )
        {
            system->SetScreenFillColor(255,0,0,100);
        }
    }
    else if ( entity == "Pause" )
        system->Pause();
    else if ( entity == "Music" )
    {
        if ( message == "Play" )
            system->PlayMusic();
        else if ( message == "Stop" )
            system->StopMusic();
        else if ( message == "Loop" )
            system->SetMusicLoop(true);
        else if ( message == "Unloop" )
            system->SetMusicLoop(false);
        else
            system->SetMusic(message);
    }
    else //Otherwise, send the message to the specified entity
    {
        if ( entities[entity] != NULL)
            entities[entity]->RecieveMessage(message);
        else
        {
            std::cout<<"Could not find entity '"<<entity<<"'"<<std::endl;
        }
    }
}

void EntityLibrary::Sort(std::string sortby)
{
    //Basically just sorts the collider list now. Originally also sorted entities by display order, but that is now obsolete.
    cList.clear();
    for (std::map<std::string, Entity*>::iterator it = entities.begin() ; it != entities.end(); ++it)
    {
        if ( it->second->GetCC() )
        {
            cList.push_back(it->second->GetCC());
        }
    }
}

bool EntityLibrary::OnScreen(TransformComponent *t)
{
    sf::Vector2f viewCenter = system->GetView()->getCenter();
    sf::Vector2f halfExtents = system->GetView()->getSize() / 2.0f;
    sf::Vector2f translation = viewCenter - halfExtents;
    
    int rx = static_cast<int>(translation.x);
    int ry = static_cast<int>(translation.y);
    
    if ( t->x > rx+system->resolution_w )
        return false;
    if ( t->x+t->w < rx )
        return false;
    if ( t->y > ry+system->resolution_h )
        return false;
    if ( t->y+t->h < ry )
        return false;
    
    return true;
}
