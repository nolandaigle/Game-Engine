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
#include "Component.h"
#include "Sound.h"

class SoundComponent: public Component
{
private:
    Sound sound;
protected:
public:
    SoundComponent(System *_system);
    ~SoundComponent();
    
    void Load(std::string file);
    void Play();
    void Stop();
    void SetVolume(int vol);
};

#endif /* defined(__RPG__SoundComponent__) */
