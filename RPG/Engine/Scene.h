//
//  Scene.h
//  RPG
//
//  Created by Nolan Daigle on 12/9/15.
//  Copyright (c) 2015 Nolan Daigle. All rights reserved.
//

#ifndef __RPG__Scene__
#define __RPG__Scene__

#include "System/System.h"
#include "Graphics/graphic.h"
#include "EntityLibrary.h"

class Scene
{
protected:
    System *system;
    EntityLibrary *eL;
public:
    Scene(System *_system);
    ~Scene();
    virtual void Bang();
    virtual void Collapse();
    virtual void Input(sf::Event *event);
    virtual void Turn();
    virtual void Display();
};

#endif /* defined(__RPG__Scene__) */
