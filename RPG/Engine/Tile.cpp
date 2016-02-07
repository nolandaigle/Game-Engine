//
//  Tile.cpp
//  RPG
//
//  Created by Nolan Daigle on 12/14/15.
//  Copyright (c) 2015 Nolan Daigle. All rights reserved.
//

#include "Tile.h"
#include <iostream>

Tile::Tile( int _x, int _y, int _type, int _layer )
{
    type = _type;
    layer = _layer;
    x = _x;
    y = _y;
    w = 16;
    h = 16;
    graphic = new Graphic;
    graphic->Load("Resources/Graphic/CityTileset.png");
    
    int width = 128/16;
    int height = 128/16;
    int bx = type;
    int by = 0;
    
    while ( bx >= width )
    {
        bx -= width;
        by += 1;
    }
    
    graphic->SetPosition(x, y);
    graphic->SetBox(bx*16, by*16, 16, 16);
}

Tile::~Tile()
{
    if (graphic)
        delete graphic;
}

void Tile::Display(System *system)
{
    graphic->SetPosition(x, y);
    system->GetWindow()->draw(*graphic->GetSprite());
}

int Tile::GetLayer()
{
    return layer;
}