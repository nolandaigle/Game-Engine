//
//  Tile.h
//  RPG
//
//  Created by Nolan Daigle on 12/14/15.
//  Copyright (c) 2015 Nolan Daigle. All rights reserved.
//

#ifndef __RPG__Tile__
#define __RPG__Tile__
#include "Graphics/Graphic.h"
#include "System/System.h"

class Tile
{
private:
    int x, y, w, h;
    int type;
    int layer;
public:
    Tile( int x, int y, int _type, int _layer );
    ~Tile();
    Graphic *graphic;
    void Display(System *system);
    int GetLayer();
    
    void SetPosition(int _x, int _y) { x = _x; y = _y; }
    
    int GetX() { return x; }
    int GetY() { return y; }
    int GetW() { return w; }
    int GetH() { return h; }
};

#endif /* defined(__RPG__Tile__) */