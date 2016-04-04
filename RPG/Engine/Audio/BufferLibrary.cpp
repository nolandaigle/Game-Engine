//
//  BufferLibrary.cpp
//  RPG
//
//  Created by Nolan Daigle on 12/8/15.
//  Copyright (c) 2015 Nolan Daigle. All rights reserved.
//

#include "BufferLibrary.h"
#include "ResourcePath.hpp"
#include <iostream>

BufferLibrary *BufferLibrary::s_instance = NULL;

void BufferLibrary::AddBuffer(std::string filename)
{
    if ( buffer[filename] == NULL )
    {
        buffer[filename] = new sf::SoundBuffer();
        if (!buffer[filename]->loadFromFile(resourcePath()+filename))
        {
        }
        else
        {
        }
    }
    else
    {
     //   std::cout<<"Buffer "<<filename<<" already exists."<<std::endl;
    }
}

void BufferLibrary::RemoveBuffer(std::string filename)
{
    if ( buffer[filename] != NULL )
    {
        delete buffer[filename];
        buffer.erase(filename);
    }
} 