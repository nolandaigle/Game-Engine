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
    //Instance of the Entity Library, a singleton class
    static EntityLibrary *s_instance;
    
    //An STL map where we hold the Entities, accessed using their name as the key
    std::map<std::string,Entity*> entities;
    //A pointer to the system
    System *system;
    //Has the entity list changed recently?
    bool changed;
    //A function to determine if an Entity's transform is within the screen bounds
    bool OnScreen( TransformComponent *e );
    //Map to be switched to
    std::string nextMap;
    
    float fpsTimer;
    float fps;

public:
    EntityLibrary();
    //Pass a pointer to the System class to the Entity Library
    void SetSystem(System *_system) { system =  _system; }
    //Add an Entity to the library
    Entity *AddEntity( int x, int y, std::string name, bool updating = true, std::string info = "" );
    //Remove an Entity from the library
    void RemoveEntity(std::string name);
    //Clear Entities
    void Clear();
    //Pass a pointer to map to each Entity in the library
    void SetMap(Map *map);
    
    void Slow(float frameTime ) { fps = frameTime; }
    
    //Basic structure functions
    void Bang();
    void Input(sf::Event *event);
    void Turn();
    void Display();
    //Sorts Entities into the Display and Collider Lists
    void Sort(std::string sortby);
    //Sends a signal to all entities in the library
    void Signal(std::string signal);
    //Messages a specific entity by name
     void Message(std::string entity, std::string message);
    //Returns an entity in the library by name
    Entity *GetEntity(std::string name) { if ( entities[name] ) {return entities[name]; } else { return NULL; } }
    //Gets the upcoming map to switch to
    std::string GetNextMap() { return nextMap; }
    //Set the nextmap
    void SetNextMap(std::string nm) { nextMap = nm; }
    //A list of all entities with collision components
    std::vector<CollisionComponent*> cList;
    //Access the entity class singleton
    static EntityLibrary *instance()
    {
        if (!s_instance)
            s_instance = new EntityLibrary;
        return s_instance;
    }
};

#endif /* defined(__RPG__EntityLibrary__) */
