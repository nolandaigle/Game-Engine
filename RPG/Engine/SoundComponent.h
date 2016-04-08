//
//  SoundComponent.h
//  RPG
//
//  Created by Nolan Daigle on 12/27/15.
//  Copyright (c) 2015 Nolan Daigle. All rights reserved.
//

#ifndef __RPG__SoundComponent__
#define __RPG__SoundComponent__

#include <string>
#include <map>
#include "Component.h"
#include "Sound.h"

class SoundComponent: public Component
{
private:
    std::map<std::string, Sound*> sound;
protected:
public:
    SoundComponent(System *_system);
    ~SoundComponent();
    
    void Load(std::string file, std::string name);
    void Play(std::string name);
    void Stop(std::string name);
    void SetVolume(std::string name, int vol);
    void SetLoop(std::string name, bool loop);
};

#endif /* defined(__RPG__SoundComponent__) */
