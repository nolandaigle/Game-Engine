//
//  Entity.cpp
//  RPG
//
//  Created by Nolan Daigle on 12/9/15.
//  Copyright (c) 2015 Nolan Daigle. All rights reserved.
//

#include "Entity.h"
#include <iostream>
#include <string.h>
#include <fstream>
#include "Luabridge/luabridge.h"
#include "Resourcepath.hpp"
#include "EntityLibrary.h"

extern "C" {
# include "lua.h"
# include "lauxlib.h"
# include "lualib.h"
}

using namespace luabridge;

Entity::Entity(int _x, int _y, System *_system, bool _updating )
{
    system = _system;
    name = "Entity";
    type = "Entity";
    gc = NULL;
    mc = NULL;
    cc = NULL;
    dc = NULL;
    sc = NULL;
    scrC = NULL;
    transform = NULL;
    luaState = NULL;
    layer = 0;
    
    x = _x;
    y = _y;
    
    updating = _updating;
}

Entity::~Entity()
{
    
}

void Entity::Bang(std::string info )
{
    GetPath();
    LoadScript(turnScrFile);
    RunScript(turnScrFile, luaState);
    LuaRef bang = getGlobal(luaState, "bang");
    std::cout<<GetName();
    if ( bang )
        bang(this, info);
     std::cout<<"LAYER IS "<<layer<<std::endl;
}

void Entity::Turn()
{
    mInput();
    
    LuaRef update = getGlobal(luaState, "update");
    if ( update )
        update(this);
}

void Entity::Display()
{
    if ( Updating() )
    {
        LuaRef display = getGlobal(luaState, "display");
        if ( display )
            display(this);
    }
    else
    {
        if ( GetGC() && GetTransform() )
        {
            GetGC()->Display(GetTransform()->x, GetTransform()->y);
        }
    }
}

void Entity::Collapse()
{
    if ( gc )
        delete gc;
}

void Entity::Input(sf::Event *event)
{
    if ( event->type == sf::Event::KeyPressed )
    {
        
        LuaRef onKeyPress = getGlobal(luaState, "onKeyPress");
        if ( onKeyPress )
        {
            if ( event->key.code == sf::Keyboard::A )
                onKeyPress(this,"a");
            if ( event->key.code == sf::Keyboard::B )
                onKeyPress(this,"b");
            if ( event->key.code == sf::Keyboard::C )
                onKeyPress(this,"c");
            if ( event->key.code == sf::Keyboard::D )
                onKeyPress(this,"d");
            if ( event->key.code == sf::Keyboard::E )
                onKeyPress(this,"e");
            if ( event->key.code == sf::Keyboard::F )
                onKeyPress(this,"f");
            if ( event->key.code == sf::Keyboard::G )
                onKeyPress(this,"g");
            if ( event->key.code == sf::Keyboard::H )
                onKeyPress(this,"h");
            if ( event->key.code == sf::Keyboard::I )
                onKeyPress(this,"i");
            if ( event->key.code == sf::Keyboard::J )
                onKeyPress(this,"j");
            if ( event->key.code == sf::Keyboard::K )
                onKeyPress(this,"k");
            if ( event->key.code == sf::Keyboard::L )
                onKeyPress(this,"l");
            if ( event->key.code == sf::Keyboard::M )
                onKeyPress(this,"m");
            if ( event->key.code == sf::Keyboard::N )
                onKeyPress(this,"n");
            if ( event->key.code == sf::Keyboard::O )
                onKeyPress(this,"o");
            if ( event->key.code == sf::Keyboard::P )
                onKeyPress(this,"p");
            if ( event->key.code == sf::Keyboard::Q )
                onKeyPress(this,"q");
            if ( event->key.code == sf::Keyboard::R )
                onKeyPress(this,"r");
            if ( event->key.code == sf::Keyboard::S )
                onKeyPress(this,"s");
            if ( event->key.code == sf::Keyboard::T )
                onKeyPress(this,"t");
            if ( event->key.code == sf::Keyboard::U )
                onKeyPress(this,"u");
            if ( event->key.code == sf::Keyboard::V )
                onKeyPress(this,"v");
            if ( event->key.code == sf::Keyboard::W )
                onKeyPress(this,"w");
            if ( event->key.code == sf::Keyboard::X )
                onKeyPress(this,"x");
            if ( event->key.code == sf::Keyboard::Y )
                onKeyPress(this,"y");
            if ( event->key.code == sf::Keyboard::Z )
                onKeyPress(this,"z");
            if ( event->key.code == sf::Keyboard::Up )
                onKeyPress(this,"up");
            if ( event->key.code == sf::Keyboard::Down )
                onKeyPress(this,"down");
            if ( event->key.code == sf::Keyboard::Left )
                onKeyPress(this,"left");
            if ( event->key.code == sf::Keyboard::Right )
                onKeyPress(this,"right");
        }
    }
}

void Entity::mInput()
{
    if ( sf::Keyboard::isKeyPressed(sf::Keyboard::A) )
        key["a"] = true;
    else
        key["a"] = false;
    if ( sf::Keyboard::isKeyPressed(sf::Keyboard::B) )
        key["b"] = true;
    else
        key["b"] = false;
    if ( sf::Keyboard::isKeyPressed(sf::Keyboard::C) )
        key["c"] = true;
    else
        key["c"] = false;
    if ( sf::Keyboard::isKeyPressed(sf::Keyboard::D) )
        key["d"] = true;
    else
        key["d"] = false;
    if ( sf::Keyboard::isKeyPressed(sf::Keyboard::E) )
        key["e"] = true;
    else
        key["e"] = false;
    if ( sf::Keyboard::isKeyPressed(sf::Keyboard::F) )
        key["f"] = true;
    else
        key["f"] = false;
    if ( sf::Keyboard::isKeyPressed(sf::Keyboard::G) )
        key["g"] = true;
    else
        key["g"] = false;
    if ( sf::Keyboard::isKeyPressed(sf::Keyboard::H) )
        key["h"] = true;
    else
        key["h"] = false;
    if ( sf::Keyboard::isKeyPressed(sf::Keyboard::I) )
        key["i"] = true;
    else
        key["i"] = false;
    if ( sf::Keyboard::isKeyPressed(sf::Keyboard::J) )
        key["j"] = true;
    else
        key["j"] = false;
    if ( sf::Keyboard::isKeyPressed(sf::Keyboard::K) )
        key["k"] = true;
    else
        key["k"] = false;
    if ( sf::Keyboard::isKeyPressed(sf::Keyboard::L) )
        key["l"] = true;
    else
        key["l"] = false;
    if ( sf::Keyboard::isKeyPressed(sf::Keyboard::M) )
        key["m"] = true;
    else
        key["m"] = false;
    if ( sf::Keyboard::isKeyPressed(sf::Keyboard::N) )
        key["n"] = true;
    else
        key["n"] = false;
    if ( sf::Keyboard::isKeyPressed(sf::Keyboard::O) )
        key["o"] = true;
    else
        key["o"] = false;
    if ( sf::Keyboard::isKeyPressed(sf::Keyboard::P) )
        key["p"] = true;
    else
        key["p"] = false;
    if ( sf::Keyboard::isKeyPressed(sf::Keyboard::Q) )
        key["q"] = true;
    else
        key["q"] = false;
    if ( sf::Keyboard::isKeyPressed(sf::Keyboard::R) )
        key["r"] = true;
    else
        key["r"] = false;
    if ( sf::Keyboard::isKeyPressed(sf::Keyboard::S) )
        key["s"] = true;
    else
        key["s"] = false;
    if ( sf::Keyboard::isKeyPressed(sf::Keyboard::T) )
        key["t"] = true;
    else
        key["t"] = false;
    if ( sf::Keyboard::isKeyPressed(sf::Keyboard::U) )
        key["u"] = true;
    else
        key["u"] = false;
    if ( sf::Keyboard::isKeyPressed(sf::Keyboard::V) )
        key["v"] = true;
    else
        key["v"] = false;
    if ( sf::Keyboard::isKeyPressed(sf::Keyboard::W) )
        key["w"] = true;
    else
        key["w"] = false;
    if ( sf::Keyboard::isKeyPressed(sf::Keyboard::X) )
        key["x"] = true;
    else
        key["x"] = false;
    if ( sf::Keyboard::isKeyPressed(sf::Keyboard::Y) )
        key["y"] = true;
    else
        key["y"] = false;
    if ( sf::Keyboard::isKeyPressed(sf::Keyboard::Z) )
        key["z"] = true;
    else
        key["z"] = false;
    if ( sf::Keyboard::isKeyPressed(sf::Keyboard::Up) )
        key["up"] = true;
    else
        key["up"] = false;
    if ( sf::Keyboard::isKeyPressed(sf::Keyboard::Down) )
        key["down"] = true;
    else
        key["down"] = false;
    if ( sf::Keyboard::isKeyPressed(sf::Keyboard::Left) )
        key["left"] = true;
    else
        key["left"] = false;
    if ( sf::Keyboard::isKeyPressed(sf::Keyboard::Right) )
        key["right"] = true;
    else
        key["right"] = false;
}

bool Entity::KeyPressed(std::string _key)
{
    return key[_key];
}

void Entity::LoadScript(char* filename)
{
    luaState = luaL_newstate();
    luaL_openlibs(luaState);
    getGlobalNamespace(luaState)
    
    //Component
    .beginClass<Component>("Component")
    .addConstructor<void(*) (System*)>()
    .addFunction("GetName", &Component::GetName)
    .addFunction("Display", &Component::Display)
    .endClass()
    
    //    TransformComponent
    .beginClass<TransformComponent>("TransformComponent")
    .addConstructor<void(*) (System*)>()
    .addFunction("CenterView", &TransformComponent::CenterView)
    .addFunction("SetSize", &TransformComponent::SetSize )
    .addData("x", &TransformComponent::x)
    .addData("y", &TransformComponent::y)
    .endClass()
    
    //    CollisionComponent
    .beginClass<CollisionComponent>("CollisionComponent")
    .addConstructor<void(*) (System*,TransformComponent*)>()
    .addFunction("SetType", &CollisionComponent::SetType)
    .addFunction("GetType", &CollisionComponent::GetType)
    .addFunction("SetTransform", &CollisionComponent::SetTransform)
    .addFunction("Colliding", &CollisionComponent::Colliding)
    .endClass()
    
    //GraphicComponent
    .beginClass<GraphicComponent>("GraphicComponent")
    .addConstructor<void(*) (System*)>()
    .addFunction("GetName", &GraphicComponent::GetName)
    .addFunction("Display", &GraphicComponent::Display)
    .addFunction("SetImage", &GraphicComponent::SetImage)
    .addFunction("SetRotation", &GraphicComponent::SetRotation)
    .addFunction("SetAnimation", &GraphicComponent::SetAnimation)
    .addFunction("SetFPS", &GraphicComponent::SetFPS)
    .addFunction("SetScale", &GraphicComponent::SetScale )
    .addFunction("SetFrameSize", &GraphicComponent::SetFrameSize )
    .addFunction("AddFrame", &GraphicComponent::AddFrame)
    .addFunction("Play", &GraphicComponent::Play)
    .addFunction("Playing", &GraphicComponent::Playing)
    .addFunction("Stop", &GraphicComponent::Stop)
    .endClass()
    
    //SoundComponent
    .beginClass<SoundComponent>("SoundComponent")
    .addConstructor<void(*) (System*)>()
    .addFunction("Load", &SoundComponent::Load)
    .addFunction("Play", &SoundComponent::Play)
    .addFunction("Stop", &SoundComponent::Stop)
    .addFunction("SetVolume", &SoundComponent::SetVolume)
    .endClass()
    
    
    //Dialog Component
    .beginClass<DialogComponent>("DialogComponent")
    .addConstructor<void(*) (System*)>()
    .addFunction("PushMessage", &DialogComponent::PushMessage)
    .addFunction("OpenDialogue", &DialogComponent::OpenDialogue)
    .addFunction("HideBox", &DialogComponent::HideBox)
    .addFunction("SetGraphic", &DialogComponent::SetGraphic)
    .addFunction("SetVoice", &DialogComponent::SetVoice)
    .endClass()
    
    //    MapComponent
    .beginClass<MapComponent>("MapComponent")
    .addConstructor<void(*) (System*)>()
    .addFunction("SetMap", &MapComponent::SetMap)
    .addFunction("Multiply", &MapComponent::Multiply)
    .endClass()
    
    //Entity
    .beginClass<Entity>("Entity")
    .addConstructor<void(*)(int,int,System*)>()
    .addFunction("AddComponent", &Entity::AddComponent)
    .addFunction("GetMap", &Entity::GetMap)
    .addFunction("SetLayer", &Entity::SetLayer)
    .addFunction("GetLayer", &Entity::GetLayer)
    .addFunction("PrintMessage", &Entity::PrintMessage)
    .addFunction("KeyPressed", &Entity::KeyPressed)
    .addFunction("Colliding", &Entity::Colliding)
    .addFunction("Signal", &Entity::Signal)
    .addFunction("Message", &Entity::Message)
    .addFunction("FindEntity", &Entity::FindEntity)
    .addFunction("GetGC", &Entity::GetGC)
    .addFunction("GetSC", &Entity::GetSC)
    .addFunction("GetCC", &Entity::GetCC)
    .addFunction("GetDC", &Entity::GetDC)
    .addFunction("GetDeltaTime", &Entity::GetDeltaTime)
    .addFunction("GetTransform", &Entity::GetTransform)
    .addFunction("Updating", &Entity::Updating)
    .addFunction("SetUpdate", &Entity::SetUpdate )
    .endClass();
}

bool Entity::RunScript(char* filename, lua_State *s)
{
    if ( s )
    {
        if (luaL_loadfile(s, filename) ||
            lua_pcall(s, 0, 0, 0)) {
            std::cout<<"Couldn't load file for "<<name<<std::endl;
            return false;
        }
        else
        {
            return true;
        }
    }
}

//              SET FUNCTIONS

void Entity::SetName(std::string _name)
{
    std::cout<<name<<" renamed to "<<_name<<std::endl;
    name = _name;
    
}

void Entity::SetType(std::string _type)
{
    type = _type;
    std::cout<<name<<" retyped to "<<type<<std::endl;
}

void Entity::SetMap(Map *_map)
{
    if ( mc != NULL )
        mc->SetMap(_map);
}

void Entity::SetLayer(int l)
{
    layer = l;
}

void Entity::AddComponent(std::string _component)
{
    if ( _component == "GraphicComponent")
        gc = new GraphicComponent(system);
    if ( _component == "TransformComponent")
    {
        transform = new TransformComponent(system);
        transform->x = x;
        transform->y = y;
    }
    if ( _component == "MapComponent")
        mc = new MapComponent(system);
    if ( _component == "SoundComponent")
        sc = new SoundComponent(system);
    if ( _component == "DialogComponent")
        dc = new DialogComponent(system);
    if ( _component == "CollisionComponent")
    {
        if ( transform == NULL )
        {
            transform = new TransformComponent(system);
            transform->x = x;
            transform->y = y;
        }
        
        if ( transform )
            cc = new CollisionComponent(system, transform);
        else
            std::cout<<"Couldn't add Collision, no transform."<<std::endl;
    }
}

//              GET FUNCTIONS

std::string Entity::GetPath()
{
    std::string temp = resourcePath()+"Resources/Scripts/"+type+".lua";
    turnScrFile = NULL;
    turnScrFile  = new char[temp.length()+1];
    std::strcpy(turnScrFile, temp.c_str());
    return turnScrFile;
}

//              COMMUNICATION FUNCTIONS

void Entity::PrintMessage(std::string message)
{
    std::cout<<message<<std::endl;
}

Entity *Entity::FindEntity(std::string name)
{
    return EntityLibrary::instance()->FindEntity(name);
}

void Entity::Signal(std::string signal)
{
    system->Signal(signal);
}

void Entity::RecieveSignal(std::string signal)
{
    LuaRef recieveSignal = getGlobal(luaState, "recieveSignal");
    if ( recieveSignal )
        recieveSignal(this, signal);
}

void Entity::Message(std::string entity, std::string message)
{
    system->Message(entity, message);
}

void Entity::RecieveMessage(std::string message)
{
    LuaRef recieveMessage = getGlobal(luaState, "recieveMessage");
    if ( recieveMessage )
        recieveMessage(this, message);
}

std::string Entity::Colliding()
{
}