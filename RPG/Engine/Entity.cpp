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
    //Initialize all Entity variables.
    system = _system;
    name = "Entity";
    type = "Entity";
    gc = NULL;
    GUIComp = NULL;
    mc = NULL;
    cc = NULL;
    dc = NULL;
    sc = NULL;
    scrC = NULL;
    transform = NULL;
    luaState = NULL;
    layer = 0;
    BangInfo = "";
    
    x = _x;
    y = _y;
    
    updating = _updating;
}

Entity::~Entity()
{
}

void Entity::Bang(std::string info )
{
    if ( BangInfo != "" )
        info = BangInfo;
    //Gets the filepath this to entity's corresponding script, by type.
    GetPath();
    //Loads that script
    LoadScript(turnScrFile);
    RunScript(turnScrFile, luaState);
    LuaRef bang = getGlobal(luaState, "bang");
    if ( bang )
        bang(this, info);
}

void Entity::Turn()
{
    //Sets all the variables for keypresses
    mInput();
    
    //Runs the Update function in the entity's lua script
    LuaRef update = getGlobal(luaState, "update");
    if ( update )
        update(this);
}

void Entity::LateTurn()
{
    //Runs the Update function in the entity's lua script
    LuaRef lateUpdate = getGlobal(luaState, "lateUpdate");
    if ( lateUpdate )
        lateUpdate(this);
}

void Entity::Display()
{
    //If the entity is updating, run its lua script
    if (Updating())
    {
        LuaRef display = getGlobal(luaState, "display");
        if ( display )
            display(this);
    }
    else if (GetGC() != NULL && GetTransform() != NULL )
    {
        GetGC()->Display( GetTransform()->x, GetTransform()->y);
    }
}

void Entity::Collapse()
{
    //Delete all entity components
    if (gc)
        delete gc;
    gc = NULL;
    if (GUIComp)
        delete GUIComp;
    GUIComp = NULL;
    if (mc)
        delete mc;
    mc = NULL;
    if (cc)
        delete cc;
    cc = NULL;
    if (dc)
        delete dc;
    dc = NULL;
    if (sc)
        delete sc;
    sc = NULL;
    if (scrC)
        delete scrC;
    scrC = NULL;
    if (transform)
        delete transform;
    transform = NULL;
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
    if ( event->type == sf::Event::KeyReleased )
    {
        LuaRef onKeyRelease = getGlobal(luaState, "onKeyRelease");
        if ( onKeyRelease )
        {
            if ( event->key.code == sf::Keyboard::A )
                onKeyRelease(this,"a");
            if ( event->key.code == sf::Keyboard::B )
                onKeyRelease(this,"b");
            if ( event->key.code == sf::Keyboard::C )
                onKeyRelease(this,"c");
            if ( event->key.code == sf::Keyboard::D )
                onKeyRelease(this,"d");
            if ( event->key.code == sf::Keyboard::E )
                onKeyRelease(this,"e");
            if ( event->key.code == sf::Keyboard::F )
                onKeyRelease(this,"f");
            if ( event->key.code == sf::Keyboard::G )
                onKeyRelease(this,"g");
            if ( event->key.code == sf::Keyboard::H )
                onKeyRelease(this,"h");
            if ( event->key.code == sf::Keyboard::I )
                onKeyRelease(this,"i");
            if ( event->key.code == sf::Keyboard::J )
                onKeyRelease(this,"j");
            if ( event->key.code == sf::Keyboard::K )
                onKeyRelease(this,"k");
            if ( event->key.code == sf::Keyboard::L )
                onKeyRelease(this,"l");
            if ( event->key.code == sf::Keyboard::M )
                onKeyRelease(this,"m");
            if ( event->key.code == sf::Keyboard::N )
                onKeyRelease(this,"n");
            if ( event->key.code == sf::Keyboard::O )
                onKeyRelease(this,"o");
            if ( event->key.code == sf::Keyboard::P )
                onKeyRelease(this,"p");
            if ( event->key.code == sf::Keyboard::Q )
                onKeyRelease(this,"q");
            if ( event->key.code == sf::Keyboard::R )
                onKeyRelease(this,"r");
            if ( event->key.code == sf::Keyboard::S )
                onKeyRelease(this,"s");
            if ( event->key.code == sf::Keyboard::T )
                onKeyRelease(this,"t");
            if ( event->key.code == sf::Keyboard::U )
                onKeyRelease(this,"u");
            if ( event->key.code == sf::Keyboard::V )
                onKeyRelease(this,"v");
            if ( event->key.code == sf::Keyboard::W )
                onKeyRelease(this,"w");
            if ( event->key.code == sf::Keyboard::X )
                onKeyRelease(this,"x");
            if ( event->key.code == sf::Keyboard::Y )
                onKeyRelease(this,"y");
            if ( event->key.code == sf::Keyboard::Z )
                onKeyRelease(this,"z");
            if ( event->key.code == sf::Keyboard::Up )
                onKeyRelease(this,"up");
            if ( event->key.code == sf::Keyboard::Down )
                onKeyRelease(this,"down");
            if ( event->key.code == sf::Keyboard::Left )
                onKeyRelease(this,"left");
            if ( event->key.code == sf::Keyboard::Right )
                onKeyRelease(this,"right");
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
    .addFunction("GetEntityName", &Component::GetEntityName)
    .endClass()
    
    //    TransformComponent
    .beginClass<TransformComponent>("TransformComponent")
    .addConstructor<void(*) (System*)>()
    .addFunction("GetEntityName", &Component::GetEntityName)
    .addFunction("CenterView", &TransformComponent::CenterView)
    .addFunction("SetSize", &TransformComponent::SetSize )
    
    .addData("x", &TransformComponent::x)
    .addData("y", &TransformComponent::y)
    .endClass()
    
    //    CollisionComponent
    .beginClass<CollisionComponent>("CollisionComponent")
    .addConstructor<void(*) (System*,TransformComponent*)>()
    .addFunction("GetEntityName", &Component::GetEntityName)
    .addFunction("SetType", &CollisionComponent::SetType)
    .addFunction("GetType", &CollisionComponent::GetType)
    .addFunction("SetTransform", &CollisionComponent::SetTransform)
    .addFunction("CollidingType", &CollisionComponent::CollidingType)
    .addFunction("CollidingName", &CollisionComponent::CollidingName)
    .endClass()
    
    //GraphicComponent
    .beginClass<GraphicComponent>("GraphicComponent")
    .addConstructor<void(*) (System*)>()
    .addFunction("GetEntityName", &Component::GetEntityName)
    .addFunction("GetName", &GraphicComponent::GetName)
    .addFunction("GetCurrentAnimation", &GraphicComponent::GetCurrentAnimation)
    .addFunction("Display", &GraphicComponent::Display)
    .addFunction("SetImage", &GraphicComponent::SetImage)
    .addFunction("SetRotation", &GraphicComponent::SetRotation)
    .addFunction("SetAnimation", &GraphicComponent::SetAnimation)
    .addFunction("SetColor", &GraphicComponent::SetColor)
    .addFunction("SetFPS", &GraphicComponent::SetFPS)
    .addFunction("SetScale", &GraphicComponent::SetScale )
    .addFunction("SetFrameSize", &GraphicComponent::SetFrameSize )
    .addFunction("AddFrame", &GraphicComponent::AddFrame)
    .addFunction("Play", &GraphicComponent::Play)
    .addFunction("PlayLoop", &GraphicComponent::PlayLoop)
    .addFunction("Playing", &GraphicComponent::Playing)
    .addFunction("Show", &GraphicComponent::Show )
    .addFunction("Disappear", &GraphicComponent::Disappear)
    .addFunction("SetFade", &GraphicComponent::SetFade)
    .addFunction("FadeTo", &GraphicComponent::FadeTo)
    .addFunction("BypassCulling", &GraphicComponent::BypassCulling)
    .addFunction("IsBypassCulling", &GraphicComponent::IsBypassCulling)
    .addFunction("Stop", &GraphicComponent::Stop)
    .endClass()
    
    //GUIComponent
    .beginClass<GUIComponent>("GUIComponent")
    .addConstructor<void(*) (int,int,System*)>()
    .addFunction("Display", &GUIComponent::Display)
    .addFunction("SetString", &GUIComponent::SetString)
    .addFunction("SetColor", &GUIComponent::SetColor)
    .addFunction("AddSelector", &GUIComponent::AddSelector)
    .addFunction("AddOption", &GUIComponent::AddOption)
    .addFunction("Swipe", &GUIComponent::Swipe)
    .addFunction("Select", &GUIComponent::Select)
    .addFunction("GetSelected", &GUIComponent::GetSelected)
    .endClass()

    
    //SoundComponent
    .beginClass<SoundComponent>("SoundComponent")
    .addConstructor<void(*) (System*)>()
    .addFunction("GetEntityName", &Component::GetEntityName)
    .addFunction("Load", &SoundComponent::Load)
    .addFunction("Play", &SoundComponent::Play)
    .addFunction("Stop", &SoundComponent::Stop)
    .addFunction("SetVolume", &SoundComponent::SetVolume)
    .addFunction("SetLoop", &SoundComponent::SetLoop)
    .endClass()
    
    
    //Dialog Component
    .beginClass<DialogComponent>("DialogComponent")
    .addConstructor<void(*) (System*)>()
    .addFunction("GetEntityName", &Component::GetEntityName)
    .addFunction("PushMessage", &DialogComponent::PushMessage)
    .addFunction("OpenDialogue", &DialogComponent::OpenDialogue)
    .addFunction("HideBox", &DialogComponent::HideBox)
    .addFunction("Clear", &DialogComponent::Clear)
    .addFunction("SetGraphic", &DialogComponent::SetGraphic)
    .addFunction("SetVoice", &DialogComponent::SetVoice)
    .addFunction("ShowGraphic", &DialogComponent::ShowGraphic)
    .endClass()
    
    //    MapComponent
    .beginClass<MapComponent>("MapComponent")
    .addConstructor<void(*) (System*)>()
    .addFunction("GetEntityName", &Component::GetEntityName)
    .addFunction("GetWidth", &MapComponent::GetWidth)
    .addFunction("GetHeight", &MapComponent::GetHeight)
    .addFunction("GetName", &MapComponent::GetName)
    .addFunction("Multiply", &MapComponent::Multiply)
    .endClass()
    
    //    ScreenComponent
    .beginClass<ScreenComponent>("ScreenComponent")
    .addConstructor<void(*) (System*)>()
    .addFunction("GetEntityName", &Component::GetEntityName)
    .addFunction("SetPixelate", &ScreenComponent::SetPixelate)
    .addFunction("ScreenShake", &ScreenComponent::ScreenShake)
    .addFunction("SlowMo", &ScreenComponent::SlowMo)
    .addFunction("Zoom", &ScreenComponent::Zoom)
    .addFunction("GetWidth", &ScreenComponent::GetWidth)
    .addFunction("GetHeight", &ScreenComponent::GetHeight)
    .addFunction("Reset", &ScreenComponent::Reset)
    .endClass()
    
    //    FileComponent
    .beginClass<FileComponent>("FileComponent")
    .addConstructor<void(*) (System*)>()
    .addFunction("GetEntityName", &Component::GetEntityName)
    .addFunction("OpenFile", &FileComponent::OpenFile)
    .addFunction("GetVariable", &FileComponent::GetVariable)
    .addFunction("SetVariable", &FileComponent::SetVariable)
    .addFunction("WriteFile", &FileComponent::WriteFile)
    .endClass()
    
    //Entity
    .beginClass<Entity>("Entity")
    .addConstructor<void(*)(int,int,System*)>()
    .addFunction("AddComponent", &Entity::AddComponent)
    .addFunction("CreateEntity", &Entity::CreateEntity)
    .addFunction("RemoveEntity", &Entity::RemoveEntity)
    .addFunction("SetScreenColor", &Entity::SetScreenColor)
    .addFunction("GetMap", &Entity::GetMap)
    .addFunction("GetName", &Entity::GetName)
    .addFunction("SetLayer", &Entity::SetLayer)
    .addFunction("GetLayer", &Entity::GetLayer)
    .addFunction("PrintMessage", &Entity::PrintMessage)
    .addFunction("KeyPressed", &Entity::KeyPressed)
    .addFunction("Signal", &Entity::Signal)
    .addFunction("Message", &Entity::Message)
    .addFunction("GetEntity", &Entity::GetEntity)
    .addFunction("GetGC", &Entity::GetGC)
    .addFunction("GetGUI", &Entity::GetGUI)
    .addFunction("GetSC", &Entity::GetSC)
    .addFunction("GetCC", &Entity::GetCC)
    .addFunction("GetDC", &Entity::GetDC)
    .addFunction("GetFC", &Entity::GetFC)
    .addFunction("GetScreen", &Entity::GetScreen)
    .addFunction("GetDeltaTime", &Entity::GetDeltaTime)
    .addFunction("GetTransform", &Entity::GetTransform)
    .addFunction("Updating", &Entity::Updating)
    .addFunction("SetUpdate", &Entity::SetUpdate )
    .addFunction("Sleep", &Entity::Sleep )
    .addFunction("Round", &Entity::Round )
    .addFunction("Lerp", &Entity::Lerp)
    
    .addData("x", &Entity::x)
    .addData("y", &Entity::y)
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
    name = _name;
    
}

void Entity::SetType(std::string _type)
{
    type = _type;
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
    {
        gc = new GraphicComponent(system);
        gc->SetEntityName(GetName());
    }
    if ( _component == "GUIComponent")
    {
        GUIComp = new GUIComponent( x, y, system);
        GUIComp->SetEntityName(GetName());
    }
    if ( _component == "TransformComponent")
    {
        transform = new TransformComponent(system);
        transform->x = x;
        transform->y = y;
        transform->SetEntityName(GetName());
    }
    if ( _component == "MapComponent")
    {
        mc = new MapComponent(system);
        mc->SetEntityName(GetName());
    }
    if ( _component == "SoundComponent")
    {
        sc = new SoundComponent(system);
        sc->SetEntityName(GetName());
    }
    if ( _component == "DialogComponent")
    {
        dc = new DialogComponent(system);
        dc->SetEntityName(GetName());
    }
    if ( _component == "ScreenComponent")
    {
        scrC = new ScreenComponent(system);
        scrC->SetEntityName(GetName());
    }
    if ( _component == "FileComponent")
    {
        fC = new FileComponent(system);
        fC->SetEntityName(GetName());
    }
    if ( _component == "CollisionComponent")
    {
        if ( transform == NULL )
        {
            transform = new TransformComponent(system);
            transform->x = x;
            transform->y = y;
            transform->SetEntityName(GetName());
        }
        
        if ( transform )
        {
            cc = new CollisionComponent(system, transform);
            cc->SetEntityName(GetName());
        }
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

Entity *Entity::GetEntity(std::string name)
{
    if ( EntityLibrary::instance()->GetEntity(name) )
        return EntityLibrary::instance()->GetEntity(name);
    else
        return NULL;
}

void Entity::Signal(std::string signal)
{
    EntityLibrary::instance()->Signal(signal);
}

void Entity::RecieveSignal(std::string signal)
{
    LuaRef recieveSignal = getGlobal(luaState, "recieveSignal");
    if ( recieveSignal )
        recieveSignal(this, signal);
}

void Entity::Message(std::string entity, std::string message)
{
    EntityLibrary::instance()->Message(entity, message);
}

void Entity::RecieveMessage(std::string message)
{
    LuaRef recieveMessage = getGlobal(luaState, "recieveMessage");
    if ( recieveMessage )
        recieveMessage(this, message);
}

void Entity::RemoveEntity(std::string e)
{
    EntityLibrary::instance()->RemoveEntity(e);
}

std::string Entity::CreateEntity( int _x, int _y, std::string _name, std::string info="" )
{
    Entity *e;
    e = EntityLibrary::instance()->AddEntity(_x, _y, _name, true, info);
    e->Bang(info);
    if ( mc != NULL )
        e->SetMap(mc->GetMap());
    EntityLibrary::instance()->Sort("Layer");
    return e->GetName();
}
