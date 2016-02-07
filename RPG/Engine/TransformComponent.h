//
//  TransformComponent.h
//  RPG
//
//  Created by Nolan Daigle on 12/13/15.
//  Copyright (c) 2015 Nolan Daigle. All rights reserved.
//

#ifndef __RPG__TransformComponent__
#define __RPG__TransformComponent__

#include <string>
#include "Component.h"
#include "Graphic.h"

class TransformComponent: public Component
{
private:
protected:
public:
    TransformComponent(System *_system);
    ~TransformComponent();
    void CenterView();
    void SetSize( int w, int h );
    
    int x, y, w, h;
    sf::Vector2f hCPoint[4];
    sf::Vector2f vCPoint[4];
};

#endif /* defined(__RPG__TransformComponent__) */
