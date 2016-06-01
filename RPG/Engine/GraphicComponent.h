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
    sf::RenderStates state;
    Graphic graphic;
    bool showing;
    bool bypassCulling;
    bool expanding;
    int scale;
    float transparency;
    float targetTran;
protected:
public:
    GraphicComponent(System *_system);
    ~GraphicComponent();
    
    
    sf::RenderStates *GetRenderState() { return &state; }
    bool shader;
    
    void Display(int x, int y);
    void SetImage(std::string _file);
    void SetColor( int r, int g, int b );
    void SetScale(int x, int y );
    void SetFrameSize( int w, int h );
    void SetRotation(int rot );
    void AddFrame(std::string anim, int x, int y);
    void Play(std::string anim);
    void PlayLoop(std::string anim, bool loop);
    void Stop();
    void SetAnimation(std::string anim);
    void SetFPS(int fps );
    bool Playing();
    bool IsBypassCulling() { return true; }
    void BypassCulling(bool enable) { bypassCulling = enable; }
    void Show(bool show) { showing = show; }
    void Disappear();
    void FadeTo(int fade);
    void SetFade( int fade );
    std::string GetCurrentAnimation() { return graphic.GetCurrentAnimation(); }
};

#endif /* defined(__RPG__GraphicComponent__) */
