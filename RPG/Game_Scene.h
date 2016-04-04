//
//  Title_Scene.h
//  RPG
//
//  Created by Nolan Daigle on 12/9/15.
//  Copyright (c) 2015 Nolan Daigle. All rights reserved.
//

#ifndef __RPG__Title_Scene__
#define __RPG__Title_Scene__

#include "Engine/Scene.h"
#include "Engine/Entity.h"
#include "Map.h"

class Game_Scene: public Scene
{
private:
    Map *map;
    float fps;
public:
    Game_Scene(System *_system);
    virtual void Bang();
    virtual void Input(sf::Event *event);
    virtual void Turn();
    virtual void Display();
    virtual void Collapse();
    
    void ChangeMap(std::string file);
};

#endif /* defined(__RPG__Title_Scene__) */
