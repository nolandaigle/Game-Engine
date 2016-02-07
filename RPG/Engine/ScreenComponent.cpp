//
//  ScreenComponent.cpp
//  Game
//
//  Created by Nolan Daigle on 1/28/16.
//  Copyright (c) 2016 Nolan Daigle. All rights reserved.
//

#include "ScreenComponent.h"

ScreenComponent::ScreenComponent(System *_system) : Component(_system)
{
    name = "ScreenComponent";
    system = _system;
}

ScreenComponent::~ScreenComponent()
{
    
}