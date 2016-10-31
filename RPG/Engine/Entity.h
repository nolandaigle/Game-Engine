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
#include <math.h>
#include <string>
#include "luabridge/luabridge.h"
#include "GraphicComponent.h"
#include "GUIComponent.h"
#include "SoundComponent.h"
#include "TransformComponent.h"
#include "MapComponent.h"
#include "CollisionComponent.h"
#include "DialogComponent.h"
#include "ScreenComponent.h"
#include "FileComponent.h"
#include "Map.h"


class Entity
{
private:
    //LUA Interatcion
    luabridge::lua_State* luaState;
    char *turnScrFile;
    
    /* --- Entity INFO --- */
    std::string name;
    std::string type;
    System *system;
    int layer;
    int x, y;
    bool updating;
    bool displaying;
    /* --- --- --- */
    
    //Key INFO
    std::map<std::string,bool> key;
    
    /* --- Component pointerse --- */
    GraphicComponent *gc;
    GUIComponent *GUIComp;
    TransformComponent *transform;
    MapComponent *mc;
    SoundComponent *sc;
    CollisionComponent *cc;
    DialogComponent *dc;
    ScreenComponent *scrC;
    FileComponent *fC;
    /* --- --- --- */
protected:
public:
    Entity(int _x, int _y, System *_system, bool _updating = true);
    ~Entity();
    
    //Usual structure functions
    virtual void Bang(std::string info = "");
    virtual void Turn();
    virtual void LateTurn();
    virtual void Display();
    virtual void Collapse();
    
    //INPUT
    void Input(sf::Event *event);
    void mInput();
    bool KeyPressed(std::string key);
    
    //SCRIPTING
    void LoadScript(char* filename);
    bool RunScript(char* filename, luabridge::lua_State *s);
    
    //Set Functions
    void SetName(std::string _name);
    void SetType(std::string _type);
    void SetMap(Map *_map);
    void SetLayer(int l);
    void SetUpdate(bool update) { updating = update; }
    void SetDisplay(bool display) { displaying = display; }

    
    
    void AddComponent(std::string _component);
    
    //Get Functions
    bool Updating() { return updating; }
    bool Displaying() { return displaying; }
    std::string GetPath();
    int GetLayer() { return layer; }
    std::string GetName() { return name; }
    
    MapComponent *GetMap() { return mc; }
    SoundComponent *GetSC() { return sc; }
    CollisionComponent *GetCC() { return cc; }
    DialogComponent *GetDC() { return dc; }
    GraphicComponent *GetGC() { return gc; }
    GUIComponent *GetGUI() { return GUIComp; }
    TransformComponent *GetTransform() { return transform; }
    MapComponent *GetMC() { return mc; }
    ScreenComponent *GetScreen() { return scrC; }
    FileComponent *GetFC() { return fC; }
    float GetDeltaTime() { return system->DeltaTime(); }
    
    //Communication
    virtual void PrintMessage(std::string message);
    Entity* GetEntity(std::string name);
    void Signal( std::string signal );
    void RecieveSignal(std::string signal);
    void Message( std::string entity, std::string message );
    void RecieveMessage(std::string message);
    void RemoveEntity(std::string e);
    std::string CreateEntity(int _x, int _y, std::string _name, std::string info);
    void Sleep(float time) { system->SetSleep(time); }
    void SetScreenColor( int r, int g, int b ) { system->SetScreenColor( r, g, b ); }
    
    int Round( float num ) { return round(num); }
    float Lerp(float num, float target, float ramp) { return system->Lerp(num, target, ramp); }
    
    std::string BangInfo;
};

#endif /* defined(__RPG__Entity__) */
