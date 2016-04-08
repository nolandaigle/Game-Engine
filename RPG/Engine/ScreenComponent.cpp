//
//  ScreenComponent.cpp
//  Game
//
//  Created by Nolan Daigle on 1/28/16.
//  Copyright (c) 2016 Nolan Daigle. All rights reserved.
//

#include "ScreenComponent.h"
#include <cmath>

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

void ScreenComponent::Zoom(float zoom)
{
    system->GetView()->zoom(zoom);
}

void ScreenComponent::Reset()
{
    system->GetView()->setSize(std::floor(system->resolution_w), std::floor(system->resolution_h));
}

float ScreenComponent::GetWidth()
{
    return system->GetView()->getSize().x*system->resolution_w;
}

float ScreenComponent::GetHeight()
{
    return system->GetView()->getSize().y*system->resolution_h;

}