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

void ScreenComponent::SetPixelate( bool enabled, float cap, float increment )
{
    system->SetPixelate(enabled, cap, increment);
    
}

void ScreenComponent::ScreenShake( float time, float intensity )
{
    system->ScreenShake( time, intensity );
}

void ScreenComponent::SlowMo( float multiplyer )
{
    system->SlowMo(multiplyer);
}