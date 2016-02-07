//
//  TextureLibrary.h
//  RPG
//
//  Created by Nolan Daigle on 12/8/15.
//  Copyright (c) 2015 Nolan Daigle. All rights reserved.
//

#ifndef __RPG__TextureLibrary__
#define __RPG__TextureLibrary__

#include <SFML/Graphics.hpp>

class TextureLibrary
{
    static TextureLibrary *s_instance;
    
    std::map<std::string,sf::Texture*> texture;
    
public:
    void AddTexture(std::string filename);
    void RemoveTexture(std::string filename);
    sf::Texture *GetTexture(std::string filename) { return texture[filename]; }
    static TextureLibrary *instance()
    {
        if (!s_instance)
            s_instance = new TextureLibrary;
        return s_instance;
    }
};

#endif /* defined(__RPG__TextureLibrary__) */
