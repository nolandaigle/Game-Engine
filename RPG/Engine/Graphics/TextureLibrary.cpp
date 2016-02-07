//
//  TextureLibrary.cpp
//  RPG
//
//  Created by Nolan Daigle on 12/8/15.
//  Copyright (c) 2015 Nolan Daigle. All rights reserved.
//

#include "TextureLibrary.h"
#include "ResourcePath.hpp"
#include <iostream>

TextureLibrary *TextureLibrary::s_instance = NULL;

void TextureLibrary::AddTexture(std::string filename)
{
    if ( texture[filename] == NULL )
    {
        texture[filename] = new sf::Texture();
        if (!texture[filename]->loadFromFile(resourcePath()+filename))
        {
       //     std::cout<<"Failed to load "<<resourcePath()+filename<<std::endl;
        }
        else
        {
     //       std::cout<<"Added texture "<<filename<<" to texture library."<<std::endl;
        }
    }
  //  else
   //    std::cout<<"Texture "<<filename<<" already exists."<<std::endl;
}

void TextureLibrary::RemoveTexture(std::string filename)
{
    if ( texture[filename] != NULL )
    {
        delete texture[filename];
        texture.erase(filename);
        //std::cout<<"Removed texture "<<filename<<" from texture library."<<std::endl;
    }
}