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
    for (std::map<std::string, Sound*>::iterator it = sound.begin() ; it != sound.end(); ++it)
    {
        delete it->second;
        it->second = NULL;
    }
    sound.clear();
}

void SoundComponent::Play(std::string name)
{
    sound[name]->Play();
}

void SoundComponent::Stop(std::string name)
{
    sound[name]->Stop();
}

void SoundComponent::Load(std::string file, std::string name)
{
    sound[name] = new Sound();
    sound[name]->Load(file);
}

void SoundComponent::SetVolume(std::string name, int vol)
{
    sound[name]->SetVolume(vol);
}

void SoundComponent::SetLoop(std::string name, bool loop)
{
    sound[name]->SetLoop(loop);
}