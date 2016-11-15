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
    fC = NULL;
    transform = NULL;
    luaState = NULL;
    layer = 0;
    BangInfo = "";
    
    x = _x;
    y = _y;
    
    updating = _updating;
    displaying = true;
    
    recieveSignal = NULL;
    recieveMessage = NULL;
    update = NULL;
    lateUpdate = NULL;
    display = NULL;
    onKeyPress = NULL;
    onKeyRelease = NULL;
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
    RunScript(turnScrFile);
    
    if (bang) {
        try{
            (*bang)(this, BangInfo);
        }
        catch (luabridge::LuaException const& e) {
           // //std::cout << "LuaException: " << e.what() << std::endl;
        }
    }
}

void Entity::Turn()
{
    //Sets all the variables for keypresses
    mInput();
    
    //Runs the Update function in the entity's lua script
    if (update) {
        try{
            (*update)(this);
        }
        catch (luabridge::LuaException const& e) {
            //std::cout << "LuaException: " << e.what() << std::endl;
        }
    }
}

void Entity::LateTurn()
{
    //Runs the Update function in the entity's lua script
    if (lateUpdate) {
        try{
            (*lateUpdate)(this);
        }
        catch (luabridge::LuaException const& e) {
           // //std::cout << "LuaException: " << e.what() << std::endl;
        }
    }
}

void Entity::Display()
{
    //If the entity is displaying, run its lua script
    if (Displaying())
    {
        if (display) {
            try{
                (*display)(this);
            }
            catch (luabridge::LuaException const& e) {
            //     //std::cout << "LuaException: " << e.what() << std::endl;
            }
        }
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
    if (fC)
        delete fC;
    fC = NULL;
    if (transform)
        delete transform;
    transform = NULL;
    
    delete bang;
    delete recieveSignal;
    delete recieveMessage;
    delete update;
    delete lateUpdate;
    delete display;
    delete onKeyPress;
    delete onKeyRelease;
    
    lua_close(luaState);
}

void Entity::Input(sf::Event *event)
{
    if ( event->type == sf::Event::KeyPressed )
    {
        if ( onKeyPress )
        {
            if ( event->key.code == sf::Keyboard::A )
            {
                if (onKeyPress) {
                    try{
                        (*onKeyPress)(this, "a");
                    }
                    catch (luabridge::LuaException const& e) {
                  //      //std::cout << "LuaException: " << e.what() << std::endl;
                    }
                }
            }
            if ( event->key.code == sf::Keyboard::B )
            {
                if (onKeyPress) {
                    try{
                        (*onKeyPress)(this, "b");
                    }
                    catch (luabridge::LuaException const& e) {
                    //    //std::cout << "LuaException: " << e.what() << std::endl;
                    }
                }
            }
            if ( event->key.code == sf::Keyboard::C )
            {
                if (onKeyPress) {
                    try{
                        (*onKeyPress)(this, "c");
                    }
                    catch (luabridge::LuaException const& e) {
                       // //std::cout << "LuaException: " << e.what() << std::endl;
                    }
                }
            }
            if ( event->key.code == sf::Keyboard::D )
            {
                if (onKeyPress) {
                    try{
                        (*onKeyPress)(this, "d");
                    }
                    catch (luabridge::LuaException const& e) {
                      //  //std::cout << "LuaException: " << e.what() << std::endl;
                    }
                }
            }
            if ( event->key.code == sf::Keyboard::E )
            {
                if (onKeyPress) {
                    try{
                        (*onKeyPress)(this, "e");
                    }
                    catch (luabridge::LuaException const& e) {
                        //std::cout << "LuaException: " << e.what() << std::endl;
                    }
                }
            }
            if ( event->key.code == sf::Keyboard::F )
            {
                if (onKeyPress) {
                    try{
                        (*onKeyPress)(this, "f");
                    }
                    catch (luabridge::LuaException const& e) {
                        //std::cout << "LuaException: " << e.what() << std::endl;
                    }
                }
            }
            if ( event->key.code == sf::Keyboard::G )
            {
                if (onKeyPress) {
                    try{
                        (*onKeyPress)(this, "g");
                    }
                    catch (luabridge::LuaException const& e) {
                        //std::cout << "LuaException: " << e.what() << std::endl;
                    }
                }
            }
            if ( event->key.code == sf::Keyboard::H )
            {
                if (onKeyPress) {
                    try{
                        (*onKeyPress)(this, "h");
                    }
                    catch (luabridge::LuaException const& e) {
                        //std::cout << "LuaException: " << e.what() << std::endl;
                    }
                }
            }
            if ( event->key.code == sf::Keyboard::I )
            {
                if (onKeyPress) {
                    try{
                        (*onKeyPress)(this, "i");
                    }
                    catch (luabridge::LuaException const& e) {
                        //std::cout << "LuaException: " << e.what() << std::endl;
                    }
                }
            }
            if ( event->key.code == sf::Keyboard::J )
            {
                if (onKeyPress) {
                    try{
                        (*onKeyPress)(this, "j");
                    }
                    catch (luabridge::LuaException const& e) {
                        //std::cout << "LuaException: " << e.what() << std::endl;
                    }
                }
            }
            if ( event->key.code == sf::Keyboard::K )
            {
                if (onKeyPress) {
                    try{
                        (*onKeyPress)(this, "k");
                    }
                    catch (luabridge::LuaException const& e) {
                        //std::cout << "LuaException: " << e.what() << std::endl;
                    }
                }
            }
            if ( event->key.code == sf::Keyboard::L )
            {
                if (onKeyPress) {
                    try{
                        (*onKeyPress)(this, "l");
                    }
                    catch (luabridge::LuaException const& e) {
                        //std::cout << "LuaException: " << e.what() << std::endl;
                    }
                }
            }
            if ( event->key.code == sf::Keyboard::M )
            {
                if (onKeyPress) {
                    try{
                        (*onKeyPress)(this, "m");
                    }
                    catch (luabridge::LuaException const& e) {
                        //std::cout << "LuaException: " << e.what() << std::endl;
                    }
                }
            }
            if ( event->key.code == sf::Keyboard::N )
            {
                if (onKeyPress) {
                    try{
                        (*onKeyPress)(this, "n");
                    }
                    catch (luabridge::LuaException const& e) {
                        //std::cout << "LuaException: " << e.what() << std::endl;
                    }
                }
            }
            if ( event->key.code == sf::Keyboard::O )
            {
                if (onKeyPress) {
                    try{
                        (*onKeyPress)(this, "o");
                    }
                    catch (luabridge::LuaException const& e) {
                        //std::cout << "LuaException: " << e.what() << std::endl;
                    }
                }
            }
            if ( event->key.code == sf::Keyboard::P )
            {
                if (onKeyPress) {
                    try{
                        (*onKeyPress)(this, "p");
                    }
                    catch (luabridge::LuaException const& e) {
                        //std::cout << "LuaException: " << e.what() << std::endl;
                    }
                }
            }
            if ( event->key.code == sf::Keyboard::Q )
            {
                if (onKeyPress) {
                    try{
                        (*onKeyPress)(this, "q");
                    }
                    catch (luabridge::LuaException const& e) {
                        //std::cout << "LuaException: " << e.what() << std::endl;
                    }
                }
            }
            if ( event->key.code == sf::Keyboard::R )
            {
                if (onKeyPress) {
                    try{
                        (*onKeyPress)(this, "r");
                    }
                    catch (luabridge::LuaException const& e) {
                        //std::cout << "LuaException: " << e.what() << std::endl;
                    }
                }
            }
            if ( event->key.code == sf::Keyboard::S )
            {
                if (onKeyPress) {
                    try{
                        (*onKeyPress)(this, "s");
                    }
                    catch (luabridge::LuaException const& e) {
                        //std::cout << "LuaException: " << e.what() << std::endl;
                    }
                }
            }
            if ( event->key.code == sf::Keyboard::T )
            {
                if (onKeyPress) {
                    try{
                        (*onKeyPress)(this, "t");
                    }
                    catch (luabridge::LuaException const& e) {
                        //std::cout << "LuaException: " << e.what() << std::endl;
                    }
                }
            }
            if ( event->key.code == sf::Keyboard::U )
            {
                if (onKeyPress) {
                    try{
                        (*onKeyPress)(this, "u");
                    }
                    catch (luabridge::LuaException const& e) {
                        //std::cout << "LuaException: " << e.what() << std::endl;
                    }
                }
            }
            if ( event->key.code == sf::Keyboard::V )
            {
                if (onKeyPress) {
                    try{
                        (*onKeyPress)(this, "v");
                    }
                    catch (luabridge::LuaException const& e) {
                        //std::cout << "LuaException: " << e.what() << std::endl;
                    }
                }
            }
            if ( event->key.code == sf::Keyboard::W )
            {
                if (onKeyPress) {
                    try{
                        (*onKeyPress)(this, "w");
                    }
                    catch (luabridge::LuaException const& e) {
                        //std::cout << "LuaException: " << e.what() << std::endl;
                    }
                }
            }
            if ( event->key.code == sf::Keyboard::X )
            {
                if (onKeyPress) {
                    try{
                        (*onKeyPress)(this, "x");
                    }
                    catch (luabridge::LuaException const& e) {
                        //std::cout << "LuaException: " << e.what() << std::endl;
                    }
                }
            }
            if ( event->key.code == sf::Keyboard::Y )
            {
                if (onKeyPress) {
                    try{
                        (*onKeyPress)(this, "y");
                    }
                    catch (luabridge::LuaException const& e) {
                        //std::cout << "LuaException: " << e.what() << std::endl;
                    }
                }
            }
            if ( event->key.code == sf::Keyboard::Z )
            {
                if (onKeyPress) {
                    try{
                        (*onKeyPress)(this, "z");
                    }
                    catch (luabridge::LuaException const& e) {
                        //std::cout << "LuaException: " << e.what() << std::endl;
                    }
                }
            }
            if ( event->key.code == sf::Keyboard::Up )
            {
                if (onKeyPress) {
                    try{
                        (*onKeyPress)(this, "up");
                    }
                    catch (luabridge::LuaException const& e) {
                        //std::cout << "LuaException: " << e.what() << std::endl;
                    }
                }
            }
            if ( event->key.code == sf::Keyboard::Down )
            {
                if (onKeyPress) {
                    try{
                        (*onKeyPress)(this, "down");
                    }
                    catch (luabridge::LuaException const& e) {
                        //std::cout << "LuaException: " << e.what() << std::endl;
                    }
                }
            }
            if ( event->key.code == sf::Keyboard::Left )
            {
                if (onKeyPress) {
                    try{
                        (*onKeyPress)(this, "left");
                    }
                    catch (luabridge::LuaException const& e) {
                        //std::cout << "LuaException: " << e.what() << std::endl;
                    }
                }
            }
            if ( event->key.code == sf::Keyboard::Right )
            {
                if (onKeyPress) {
                    try{
                        (*onKeyPress)(this, "right");
                    }
                    catch (luabridge::LuaException const& e) {
                        //std::cout << "LuaException: " << e.what() << std::endl;
                    }
                }
            }
        }
    }
    if ( event->type == sf::Event::KeyReleased )
    {
        if ( onKeyRelease )
        {
            if ( event->key.code == sf::Keyboard::A )
            {
                if (onKeyRelease) {
                    try{
                        (*onKeyRelease)(this, "a");
                    }
                    catch (luabridge::LuaException const& e) {
                        //std::cout << "LuaException: " << e.what() << std::endl;
                    }
                }
            }
            if ( event->key.code == sf::Keyboard::B )
            {
                if (onKeyRelease) {
                    try{
                        (*onKeyRelease)(this, "b");
                    }
                    catch (luabridge::LuaException const& e) {
                        //std::cout << "LuaException: " << e.what() << std::endl;
                    }
                }
            }
            if ( event->key.code == sf::Keyboard::C )
            {
                if (onKeyRelease) {
                    try{
                        (*onKeyRelease)(this, "c");
                    }
                    catch (luabridge::LuaException const& e) {
                        //std::cout << "LuaException: " << e.what() << std::endl;
                    }
                }
            }
            if ( event->key.code == sf::Keyboard::D )
            {
                if (onKeyRelease) {
                    try{
                        (*onKeyRelease)(this, "d");
                    }
                    catch (luabridge::LuaException const& e) {
                        //std::cout << "LuaException: " << e.what() << std::endl;
                    }
                }
            }
            if ( event->key.code == sf::Keyboard::E )
            {
                if (onKeyRelease) {
                    try{
                        (*onKeyRelease)(this, "e");
                    }
                    catch (luabridge::LuaException const& e) {
                        //std::cout << "LuaException: " << e.what() << std::endl;
                    }
                }
            }
            if ( event->key.code == sf::Keyboard::F )
            {
                if (onKeyRelease) {
                    try{
                        (*onKeyRelease)(this, "f");
                    }
                    catch (luabridge::LuaException const& e) {
                        //std::cout << "LuaException: " << e.what() << std::endl;
                    }
                }
            }
            if ( event->key.code == sf::Keyboard::G )
            {
                if (onKeyRelease) {
                    try{
                        (*onKeyRelease)(this, "g");
                    }
                    catch (luabridge::LuaException const& e) {
                        //std::cout << "LuaException: " << e.what() << std::endl;
                    }
                }
            }
            if ( event->key.code == sf::Keyboard::H )
            {
                if (onKeyRelease) {
                    try{
                        (*onKeyRelease)(this, "h");
                    }
                    catch (luabridge::LuaException const& e) {
                        //std::cout << "LuaException: " << e.what() << std::endl;
                    }
                }
            }
            if ( event->key.code == sf::Keyboard::I )
            {
                if (onKeyRelease) {
                    try{
                        (*onKeyRelease)(this, "i");
                    }
                    catch (luabridge::LuaException const& e) {
                        //std::cout << "LuaException: " << e.what() << std::endl;
                    }
                }
            }
            if ( event->key.code == sf::Keyboard::J )
            {
                if (onKeyRelease) {
                    try{
                        (*onKeyRelease)(this, "j");
                    }
                    catch (luabridge::LuaException const& e) {
                        //std::cout << "LuaException: " << e.what() << std::endl;
                    }
                }
            }
            if ( event->key.code == sf::Keyboard::K )
            {
                if (onKeyRelease) {
                    try{
                        (*onKeyRelease)(this, "k");
                    }
                    catch (luabridge::LuaException const& e) {
                        //std::cout << "LuaException: " << e.what() << std::endl;
                    }
                }
            }
            if ( event->key.code == sf::Keyboard::L )
            {
                if (onKeyRelease) {
                    try{
                        (*onKeyRelease)(this, "l");
                    }
                    catch (luabridge::LuaException const& e) {
                        //std::cout << "LuaException: " << e.what() << std::endl;
                    }
                }
            }
            if ( event->key.code == sf::Keyboard::M )
            {
                if (onKeyRelease) {
                    try{
                        (*onKeyRelease)(this, "m");
                    }
                    catch (luabridge::LuaException const& e) {
                        //std::cout << "LuaException: " << e.what() << std::endl;
                    }
                }
            }
            if ( event->key.code == sf::Keyboard::N )
            {
                if (onKeyRelease) {
                    try{
                        (*onKeyRelease)(this, "n");
                    }
                    catch (luabridge::LuaException const& e) {
                        //std::cout << "LuaException: " << e.what() << std::endl;
                    }
                }
            }
            if ( event->key.code == sf::Keyboard::O )
            {
                if (onKeyRelease) {
                    try{
                        (*onKeyRelease)(this, "o");
                    }
                    catch (luabridge::LuaException const& e) {
                        //std::cout << "LuaException: " << e.what() << std::endl;
                    }
                }
            }
            if ( event->key.code == sf::Keyboard::P )
            {
                if (onKeyRelease) {
                    try{
                        (*onKeyRelease)(this, "p");
                    }
                    catch (luabridge::LuaException const& e) {
                        //std::cout << "LuaException: " << e.what() << std::endl;
                    }
                }
            }
            if ( event->key.code == sf::Keyboard::Q )
            {
                if (onKeyRelease) {
                    try{
                        (*onKeyRelease)(this, "q");
                    }
                    catch (luabridge::LuaException const& e) {
                        //std::cout << "LuaException: " << e.what() << std::endl;
                    }
                }
            }
            if ( event->key.code == sf::Keyboard::R )
            {
                if (onKeyRelease) {
                    try{
                        (*onKeyRelease)(this, "r");
                    }
                    catch (luabridge::LuaException const& e) {
                        //std::cout << "LuaException: " << e.what() << std::endl;
                    }
                }
            }
            if ( event->key.code == sf::Keyboard::S )
            {
                if (onKeyRelease) {
                    try{
                        (*onKeyRelease)(this, "s");
                    }
                    catch (luabridge::LuaException const& e) {
                        //std::cout << "LuaException: " << e.what() << std::endl;
                    }
                }
            }
            if ( event->key.code == sf::Keyboard::T )
            {
                if (onKeyRelease) {
                    try{
                        (*onKeyRelease)(this, "t");
                    }
                    catch (luabridge::LuaException const& e) {
                        //std::cout << "LuaException: " << e.what() << std::endl;
                    }
                }
            }
            if ( event->key.code == sf::Keyboard::U )
            {
                if (onKeyRelease) {
                    try{
                        (*onKeyRelease)(this, "u");
                    }
                    catch (luabridge::LuaException const& e) {
                        //std::cout << "LuaException: " << e.what() << std::endl;
                    }
                }
            }
            if ( event->key.code == sf::Keyboard::V )
            {
                if (onKeyRelease) {
                    try{
                        (*onKeyRelease)(this, "v");
                    }
                    catch (luabridge::LuaException const& e) {
                        //std::cout << "LuaException: " << e.what() << std::endl;
                    }
                }
            }
            if ( event->key.code == sf::Keyboard::W )
            {
                if (onKeyRelease) {
                    try{
                        (*onKeyRelease)(this, "w");
                    }
                    catch (luabridge::LuaException const& e) {
                        //std::cout << "LuaException: " << e.what() << std::endl;
                    }
                }
            }
            if ( event->key.code == sf::Keyboard::X )
            {
                if (onKeyRelease) {
                    try{
                        (*onKeyRelease)(this, "x");
                    }
                    catch (luabridge::LuaException const& e) {
                        //std::cout << "LuaException: " << e.what() << std::endl;
                    }
                }
            }
            if ( event->key.code == sf::Keyboard::Y )
            {
                if (onKeyRelease) {
                    try{
                        (*onKeyRelease)(this, "y");
                    }
                    catch (luabridge::LuaException const& e) {
                        //std::cout << "LuaException: " << e.what() << std::endl;
                    }
                }
            }
            if ( event->key.code == sf::Keyboard::Z )
            {
                if (onKeyRelease) {
                    try{
                        (*onKeyRelease)(this, "z");
                    }
                    catch (luabridge::LuaException const& e) {
                        //std::cout << "LuaException: " << e.what() << std::endl;
                    }
                }
            }
            if ( event->key.code == sf::Keyboard::Up )
            {
                if (onKeyRelease) {
                    try{
                        (*onKeyRelease)(this, "up");
                    }
                    catch (luabridge::LuaException const& e) {
                        //std::cout << "LuaException: " << e.what() << std::endl;
                    }
                }
            }
            if ( event->key.code == sf::Keyboard::Down )
            {
                if (onKeyRelease) {
                    try{
                        (*onKeyRelease)(this, "down");
                    }
                    catch (luabridge::LuaException const& e) {
                        //std::cout << "LuaException: " << e.what() << std::endl;
                    }
                }
            }
            if ( event->key.code == sf::Keyboard::Left )
            {
                if (onKeyRelease) {
                    try{
                        (*onKeyRelease)(this, "left");
                    }
                    catch (luabridge::LuaException const& e) {
                        //std::cout << "LuaException: " << e.what() << std::endl;
                    }
                }
            }
            if ( event->key.code == sf::Keyboard::Right )
            {
                if (onKeyRelease) {
                    try{
                        (*onKeyRelease)(this, "right");
                    }
                    catch (luabridge::LuaException const& e) {
                        //std::cout << "LuaException: " << e.what() << std::endl;
                    }
                }
            }
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
    .addFunction("Display", &TransformComponent::Display )
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
    .addFunction("CollidingTTN", &CollisionComponent::CollidingTTN)
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
    .addFunction("SetColor", &MapComponent::SetColor)
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
    .addFunction("SetDisplay", &Entity::SetDisplay )
    .addFunction("Sleep", &Entity::Sleep )
    .addFunction("Round", &Entity::Round )
    .addFunction("Lerp", &Entity::Lerp)
    
    .addData("x", &Entity::x)
    .addData("y", &Entity::y)
    .endClass();
}

bool Entity::RunScript(char* filename)
{
    if ( luaState )
    {
        if (luaL_loadfile(luaState, filename) ||
            lua_pcall(luaState, 0, 0, 0)) {
            std::cout<<"Couldn't load file for "<<name<<std::endl;
            return false;
        }
        else
        {
            bang = new LuaRef(getGlobal(luaState, "bang"));
            update = new LuaRef(getGlobal(luaState, "update"));
            lateUpdate = new LuaRef(getGlobal(luaState, "lateUpdate"));
            onKeyPress = new LuaRef(getGlobal(luaState, "onKeyPress"));
            onKeyRelease = new LuaRef(getGlobal(luaState, "onKeyRelease"));
            display = new LuaRef(getGlobal(luaState, "display"));
            recieveSignal = new LuaRef(getGlobal(luaState, "recieveSignal"));
            recieveMessage = new LuaRef(getGlobal(luaState, "recieveMessage"));


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
    if (recieveSignal) {
        try{
            (*recieveSignal)(this, signal);
        }
        catch (luabridge::LuaException const& e) {
            //std::cout << "LuaException: " << e.what() << std::endl;
        }
    }
}

void Entity::Message(std::string entity, std::string message)
{
    EntityLibrary::instance()->Message(entity, message);
}

void Entity::RecieveMessage(std::string message)
{
    if (recieveMessage) {
        try{
            (*recieveMessage)(this, message);
        }
        catch (luabridge::LuaException const& e) {
          //  //std::cout << "LuaException: " << e.what() << std::endl;
        }
    }
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
