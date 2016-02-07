//
//  EntityLibrary.h
//  RPG
//
//  Created by Nolan Daigle on 12/27/15.
//  Copyright (c) 2015 Nolan Daigle. All rights reserved.
//

#ifndef __RPG__EntityLibrary__
#define __RPG__EntityLibrary__

#include <map>
#include "Entity.h"
#include "System/System.h"

class EntityLibrary
{
    static EntityLibrary *s_instance;
    
    std::vector<Entity*> uList;
    std::vector<Entity*> dList;
    std::map<std::string,Entity*> entities;
    System *system;
    
public:
    void SetSystem(System *_system) { system =  _system; }
    Entity *AddEntity( int x, int y, std::string name, bool updating = true, std::string info = "" );
    void RemoveEntity(std::string name);
    void Clear();
    void SetMap(Map *map);
    void Bang();
    void Input(sf::Event *event);
    void Turn();
    void Display();
    void Sort(std::string sortby);
    void Signal(std::string signal);
    Entity *FindEntity(std::string name);
    void Message(std::string entity, std::string message);
    Entity *GetEntity(std::string name) { return entities[name]; }
    std::string GetNextMap() { return nextMap; }
    std::vector<CollisionComponent*> cList;
    static EntityLibrary *instance()
    {
        if (!s_instance)
            s_instance = new EntityLibrary;
        return s_instance;
    }
    
    std::string nextMap;
};

#endif /* defined(__RPG__EntityLibrary__) */
