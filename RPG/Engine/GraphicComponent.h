//
//  GraphicComponent.h
//  RPG
//
//  Created by Nolan Daigle on 12/11/15.
//  Copyright (c) 2015 Nolan Daigle. All rights reserved.
//

#ifndef __RPG__GraphicComponent__
#define __RPG__GraphicComponent__

#include <string>
#include "Component.h"
#include "Graphic.h"

class GraphicComponent: public Component
{
private:
    Graphic graphic;
protected:
public:
    GraphicComponent(System *_system);
    ~GraphicComponent();
    
    void Display(int x, int y);
    void SetImage(std::string _file);
    void SetScale(float x, float y );
    void SetFrameSize( int w, int h );
    void SetRotation(int rot );
    void AddFrame(std::string anim, int x, int y);
    void Play(std::string anim);
    void Stop();
    void SetAnimation(std::string anim);
    void SetFPS(int fps );
    bool Playing();
};

#endif /* defined(__RPG__GraphicComponent__) */
