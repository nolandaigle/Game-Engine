//
//  MapComponent.h
//  RPG
//
//  Created by Nolan Daigle on 12/18/15.
//  Copyright (c) 2015 Nolan Daigle. All rights reserved.
//

#ifndef __RPG__MapComponent__
#define __RPG__MapComponent__

#include <string>
#include "Component.h"
#include "Map.h"
#include "TransformComponent.h"

class MapComponent: public Component
{
private:
    Map *map;
    float multiplication;
protected:
public:
    MapComponent(System *_system);
    ~MapComponent();
    void SetMap(Map *_map);
    int GetWidth();
    int GetHeight();
    void Multiply();
    
    int x, y, w, h;
};

#endif /* defined(__RPG__MapComponent__) */
