//
//  Map.cpp
//  RPG
//
//  Created by Nolan Daigle on 12/14/15.
//  Copyright (c) 2015 Nolan Daigle. All rights reserved.
//

#include "Map.h"
#include "json/json.h"
#include <fstream>
#include <iostream>
#include "EntityLibrary.h"
#include "ResourcePath.hpp"

Map::Map(System *_system)
{
    system = _system;
    mapHeight = 0;
    mapWidth = 0;
    tileWidth = 16;
    tileHeight = 16;
}

Map::~Map()
{
    
}

void Map::Clear()
{
    
}

void Map::Load(std::string _filename )
{
    filename = _filename;
    
    std::ifstream in(filename);
    
    Json::Value mapValue;

    in>>mapValue;
    
    //TILES
    std::string tileimage;
    
    for (Json::Value::iterator it = mapValue["tilesets"].begin(); it != mapValue["tilesets"].end(); ++it)
    {
        tileWidth = (*it)["tilewidth"].asInt();
        tileHeight  = (*it)["tileheight"].asInt();
        tileimage = (*it)["image"].asString();
    }
    
    int layer = 0;
    
    mapWidth  = mapValue["width"].asInt();
    mapHeight  = mapValue["height"].asInt();
    
    for (Json::Value::iterator it = mapValue["layers"].begin(); it != mapValue["layers"].end(); ++it)
    {
        
        int tmtiles[100000];
        int cur = 0;
        
        int i = 0;
        if ( tileimage == "" )
            tileimage = "Tilesheet";
        
        for ( int y = 0; y < mapHeight; y++ )
        {
            for ( int x = 0; x < mapWidth; x++ )
            {
                int type = (*it)["data"][i].asInt();
                
                if ( type > 0 )
                {
                    Entity *e = EntityLibrary::instance()->AddEntity(x*tileWidth,y*tileHeight, "Tile", false, (*it)["data"][i].asString() );
                    e->SetLayer(layer);
                    tmtiles[x+(y*mapWidth)] = (*it)["data"][i].asInt();
                    
                }
                else
                {
                    tmtiles[x+(y*mapWidth)] = -1;
                }
                
                i++;
            }
        }
        
        for (Json::Value::iterator oit = (*it)["objects"].begin(); oit != (*it)["objects"].end(); ++oit)
        {
            EntityLibrary::instance()->AddEntity((*oit)["x"].asInt(),(int)(*oit)["y"].asInt(),(*oit)["name"].asString());
        }
        
        if (!tilemap[layer].load(resourcePath()+"Resources/Graphic/Tilesheet.png", sf::Vector2u(16, 16), tmtiles, mapWidth, mapHeight))
            return -1;
        
        layer += 1;
    }
    
    
    in.close();
}