//
//  BufferLibrary.h
//  RPG
//
//  Created by Nolan Daigle on 12/8/15.
//  Copyright (c) 2015 Nolan Daigle. All rights reserved.
//

#ifndef __RPG__BufferLibrary__
#define __RPG__BufferLibrary__

#include <SFML/Audio.hpp>
#include <map>

class BufferLibrary
{
    static BufferLibrary *s_instance;
    
    std::map<std::string,sf::SoundBuffer*> buffer;
public:
    void AddBuffer(std::string filename);
    void RemoveBuffer(std::string filename);
    sf::SoundBuffer *GetBuffer(std::string filename) { return buffer[filename]; }
    static BufferLibrary *instance()
    {
        if (!s_instance)
            s_instance = new BufferLibrary;
        return s_instance;
    }
};

#endif /* defined(__RPG__BufferLibrary__) */
