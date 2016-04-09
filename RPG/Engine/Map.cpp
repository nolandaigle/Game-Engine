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

Map::Map(System *_system)
{
    system = _system;
    mapHeight = 0;
    mapWidth = 0;
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
    Json::Reader reader;

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
        
        int i = 0;
        if ( tileimage == "" )
            tileimage = "CityTileset.png";
        
        for ( int y = 0; y < mapHeight; y++ )
        {
            for ( int x = 0; x < mapWidth; x++ )
            {
                int type = (*it)["data"][i].asInt();
                
                if ( type > 0 )
                {
                    int bx = type;
                    int by = 0;
                    
                    while ( bx >= 128/16 )
                    {
                        bx -= tileWidth;
                        by += 1;
                    }
                    
                    Entity *e = EntityLibrary::instance()->AddEntity(x*tileWidth,y*tileHeight, "Tile", false, (*it)["data"][i].asString() );
//                    tiles.push_back(e);
                    e->SetLayer(layer);
                    e->GetGC()->SetImage(tileimage);
                    
                    if ( layer == 1 )
                    {
                        e->AddComponent("CollisionComponent");
                        e->GetCC()->SetTransform(e->GetTransform());
                        e->GetCC()->SetType("Block");
                    }
                    
                    
                }
                i++;
            }
        }
        
        for (Json::Value::iterator oit = (*it)["objects"].begin(); oit != (*it)["objects"].end(); ++oit)
        {
            EntityLibrary::instance()->AddEntity((*oit)["x"].asInt(),(int)(*oit)["y"].asInt(),(*oit)["name"].asString());
        }
        
        layer += 1;
    }
    
    
    in.close();
}