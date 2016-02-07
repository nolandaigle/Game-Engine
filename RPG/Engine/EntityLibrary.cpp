//
//  EntityLibrary.cpp
//  RPG
//
//  Created by Nolan Daigle on 12/27/15.
//  Copyright (c) 2015 Nolan Daigle. All rights reserved.
//

#include "EntityLibrary.h"

EntityLibrary *EntityLibrary::s_instance = NULL;


Entity *EntityLibrary::AddEntity(int x, int y, std::string name, bool updating, std::string info)
{
    if ( system )
    {
        if ( entities[name] == NULL )
        {
            entities[name] = new Entity(x, y, system, updating);
            entities[name]->SetName(name);
            entities[name]->SetType(name);
            entities[name]->Bang(info);
            return entities[name];
        }
        else
        {
            
            int num = 0;
            std::string type = name;
            
            std::ostringstream oss;
            oss<<name;
            
            while ( entities[oss.str()] )
            {
                oss.str("");
                oss<<name<<"_"<<num;
                num += 1;
            }
            entities[oss.str()] = new Entity(x, y, system, updating);
            entities[oss.str()]->SetType(type);
            entities[oss.str()]->SetName(oss.str());
            entities[oss.str()]->Bang(info);
            return entities[oss.str()];
        }
        std::cout<<"Added Entity "<<name<<std::endl;
    }
    return NULL;
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
    for (std::vector<Entity*>::iterator it = uList.begin() ; it != uList.end(); ++it)
    {
        if ( (*it)->GetTransform() )
        {
            if ( (*it)->GetTransform()->x > system->GetView()->getCenter().x -system->size*1024/2 && (*it)->GetTransform()->y > system->GetView()->getCenter().y -system->size*1024/2 && (*it)->GetTransform()->x < system->GetView()->getCenter().x +system->size*1024/2 && (*it)->GetTransform()->y < system->GetView()->getCenter().y+system->size*1024/2 )
                (*it)->Input(event);
        }
        else
            (*it)->Input(event);
    }
}

Entity *EntityLibrary::FindEntity(std::string name)
{
    return entities[name];
}

void EntityLibrary::Turn()
{
    for (std::vector<Entity*>::iterator it = uList.begin() ; it != uList.end(); ++it)
    {
        if ( (*it)->GetTransform() )
        {
            if ( (*it)->GetTransform()->x > system->GetView()->getCenter().x -system->size*1024/2 && (*it)->GetTransform()->y > system->GetView()->getCenter().y -system->size*1024/2 && (*it)->GetTransform()->x < system->GetView()->getCenter().x +system->size*1024/2 && (*it)->GetTransform()->y < system->GetView()->getCenter().y+system->size*1024/2 )
                (*it)->Turn();
        }
        else
        {
            (*it)->Turn();
        }
    }
}

void EntityLibrary::Display()
{
    for (std::vector<Entity*>::iterator it = dList.begin() ; it != dList.end(); ++it)
    {
        if ( (*it)->GetTransform() )
        {
            if ( (*it)->GetTransform()->x+(*it)->GetTransform()->w > system->GetView()->getCenter().x -system->size*1024/2 && (*it)->GetTransform()->y+(*it)->GetTransform()->h > system->GetView()->getCenter().y -system->size*1024/2 && (*it)->GetTransform()->x < system->GetView()->getCenter().x +system->size*1024/2 && (*it)->GetTransform()->y < system->GetView()->getCenter().y+system->size*1024/2 )
                (*it)->Display();
        }
        else
            (*it)->Display();
    }
}

void EntityLibrary::RemoveEntity(std::string name)
{
    if ( entities[name] != NULL )
    {
        delete entities[name];
        entities[name] = NULL;
        entities.erase(name);
    }
}

void EntityLibrary::Clear()
{
    for (std::map<std::string, Entity*>::iterator it = entities.begin() ; it != entities.end(); ++it)
    {
        delete it->second;
        it->second = NULL;
    }
    entities.clear();
}

void EntityLibrary::Signal(std::string signal)
{
    for (std::vector<Entity*>::iterator it = uList.begin() ; it != uList.end(); ++it)
    {
        (*it)->RecieveSignal(signal);
    }
}

void EntityLibrary::Message(std::string entity, std::string message)
{
    if ( entity == "Map" )
        nextMap = message;
    else
        entities[entity]->RecieveMessage(message);
}

void EntityLibrary::Sort(std::string sortby)
{
    uList.clear();
    dList.clear();
    cList.clear();
    if ( sortby == "Layer" )
    {
        for ( int f = 0; f < 3; f++ )
        {
            for (std::map<std::string, Entity*>::iterator it = entities.begin() ; it != entities.end(); ++it)
            {
                if ( it->second->GetLayer() == f )
                {
                    if ( it->second->Updating())
                        uList.push_back(it->second);
                    if ( it->second->GetGC())
                        dList.push_back(it->second);
                    if ( it->second->GetCC() )
                        cList.push_back(it->second->GetCC());
                }
            }
        }
        
    }
}