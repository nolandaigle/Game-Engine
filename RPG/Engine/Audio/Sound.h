//
//  Sound.h
//  RPG
//
//  Created by Nolan Daigle on 12/8/15.
//  Copyright (c) 2015 Nolan Daigle. All rights reserved.
//

#ifndef __RPG__Sound__
#define __RPG__Sound__

#include <SFML/Audio.hpp>

class Sound
{
private:
    sf::SoundBuffer *buffer;
    sf::Sound sound;
public:
    Sound();
    ~Sound();
    void Play();
    void Stop();
    void Load(std::string _file);
    void SetVolume(int vol);
};

#endif /* defined(__RPG__Sound__) */
