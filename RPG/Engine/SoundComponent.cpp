//
//  SoundComponent.cpp
//  RPG
//
//  Created by Nolan Daigle on 12/27/15.
//  Copyright (c) 2015 Nolan Daigle. All rights reserved.
//

#include "SoundComponent.h"

SoundComponent::SoundComponent(System *_system) : Component(_system)
{
    system = _system;
    name = "SoundComponent";
}

SoundComponent::~SoundComponent()
{
}

void SoundComponent::Play()
{
    sound.Play();
}

void SoundComponent::Stop()
{
    sound.Stop();
}

void SoundComponent::Load(std::string file)
{
    sound.Load(file);
}

void SoundComponent::SetVolume(int vol)
{
    sound.SetVolume(vol);
}