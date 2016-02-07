//
//  Entity.h
//  RPG
//
//  Created by Nolan Daigle on 12/9/15.
//  Copyright (c) 2015 Nolan Daigle. All rights reserved.
//

#ifndef __RPG__Entity__
#define __RPG__Entity__

#include <SFML/Graphics.hpp>
#include "System/System.h"
#include <map>
#include <string>
#include "luabridge/luabridge.h"
#include "GraphicComponent.h"
#include "SoundComponent.h"
#include "TransformComponent.h"
#include "MapComponent.h"
#include "CollisionComponent.h"
#include "DialogComponent.h"
#include "ScreenComponent.h"
#include "Map.h"


class Entity
{
private:
    //LUA Interatcion
    luabridge::lua_State* luaState;
    char *turnScrFile;
    
    //Entity INFO
    std::string name;
    std::string type;
    System *system;
    int layer;
    int x, y;
    bool updating;
    
    //Key INFO
    std::map<std::string,bool> key;
    
    //Components
    GraphicComponent *gc;
    TransformComponent *transform;
    MapComponent *mc;
    SoundComponent *sc;
    CollisionComponent *cc;
    DialogComponent *dc;
    ScreenComponent *scrC;
protected:
public:
    Entity(int _x, int _y, System *_system, bool _updating = true);
    ~Entity();
    
    virtual void Bang(std::string info = "");
    virtual void Turn();
    virtual void Display();
    virtual void Collapse();
    
    //INPUT
    void Input(sf::Event *event);
    void mInput();
    bool KeyPressed(std::string key);
    
    //SCRIPTING
    virtual void LoadScript(char* filename);
    bool RunScript(char* filename, luabridge::lua_State *s);
    
    //Set Functions
    void SetName(std::string _name);
    void SetType(std::string _type);
    void SetMap(Map *_map);
    void SetLayer(int l);
    void SetUpdate(bool update) { updating = update; }
    
    void AddComponent(std::string _component);
    
    //Get Functions
    bool Updating() { return updating; }
    std::string GetPath();
    int GetLayer() { return layer; }
    std::string GetName() { return name; }
    MapComponent *GetMap() { return mc; }
    SoundComponent *GetSC() { return sc; }
    CollisionComponent *GetCC() { return cc; }
    DialogComponent *GetDC() { return dc; }
    GraphicComponent *GetGC() { return gc; }
    TransformComponent *GetTransform() { return transform; }
    MapComponent *GetMC() { return mc; }
    float GetDeltaTime() { return system->DeltaTime(); }
    
    //Communication
    virtual void PrintMessage(std::string message);
    Entity* FindEntity(std::string name);
    void Signal( std::string signal );
    void RecieveSignal(std::string signal);
    void Message( std::string entity, std::string message );
    void RecieveMessage(std::string message);
    
    std::string Colliding();
};

#endif /* defined(__RPG__Entity__) */
