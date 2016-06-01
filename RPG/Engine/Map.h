//
//  Map.h
//  RPG
//
//  Created by Nolan Daigle on 12/14/15.
//  Copyright (c) 2015 Nolan Daigle. All rights reserved.
//

#ifndef __RPG__Map__
#define __RPG__Map__

#include "TransformComponent.h"
#include <string>

class Entity;

class Map
{
private:
    std::string filename;
    System *system;
    int mapWidth, mapHeight;
    int tileWidth, tileHeight;
public:
    Map(System *_system);
    ~Map();
    
    std::vector<Entity*> tiles;
    
    void Load(std::string _filename);
    void Clear();
    int GetWidth() { return mapWidth; }
    int GetHeight() { return mapHeight; }
    int GetTileWidth() { return tileWidth; }
    int GetTileHeight() { return tileHeight; }
    std::string GetName() { return filename; }
};

#endif /* defined(__RPG__Map__) */
