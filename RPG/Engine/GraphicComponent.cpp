//
//  GraphicComponent.cpp
//  RPG
//
//  Created by Nolan Daigle on 12/11/15.
//  Copyright (c) 2015 Nolan Daigle. All rights reserved.
//

#include "GraphicComponent.h"

GraphicComponent::GraphicComponent(System *_system) : Component(_system)
{
    system = _system;
    name = "GraphicComponent";
    graphic.Load("Resources/Graphic/Sprite.png");
    bypassCulling = false;
    
    expanding = false;
    scale = 1;
    showing = true;
    
    transparency = 255;
    targetTran = transparency;
}

GraphicComponent::~GraphicComponent()
{
}

void GraphicComponent::Display(int x, int y)
{
        graphic.Update();
        graphic.SetPosition(x, y);
    
    if ( transparency > targetTran )
        transparency -= 1;
    else if ( transparency < targetTran )
        transparency += 1;
    
        if ( expanding )
        {
            scale += system->Lerp(scale, 2.75, .35 );
            graphic.SetScale(scale, scale);
            
            if ( scale > 2.5 )
            {
                graphic.SetScale(1, 1);
                scale = 1;
                showing = false;
                expanding = false;
            }
        }
        else
        {
            scale = 1;
        }
    
    if  ( showing )
    {
        graphic.SetColor( 255, 255, 255, transparency );
        system->GetWindow()->draw(*graphic.GetSprite(), system->GetShader());
    }
}

void GraphicComponent::SetImage(std::string _file)
{
    graphic.Load("Resources/Graphic/"+_file);
}

void GraphicComponent::AddFrame(std::string anim, int x, int y)
{
    graphic.AddFrame(anim, sf::Vector2f(x,y));
}

void GraphicComponent::Play(std::string anim)
{
    graphic.Play(anim, true);
}

void GraphicComponent::Stop()
{
    graphic.Stop();
}

void GraphicComponent::SetFrameSize(int w, int h)
{
    graphic.SetFrameSize(w,h);
}

void GraphicComponent::SetScale(float x, float y)
{
    graphic.SetScale(x,y);
}

void GraphicComponent::SetRotation( int rot )
{
    graphic.SetRotation(rot);
}

void GraphicComponent::SetAnimation(std::string anim)
{
    graphic.SetAnimation(anim);
}

void GraphicComponent::SetFPS(int fps)
{
    graphic.SetFPS(fps);
}

void GraphicComponent::Disappear()
{
    expanding = true;
}

void GraphicComponent::FadeTo(int fade)
{
    targetTran = fade;
}

void GraphicComponent::SetFade(int fade)
{
    targetTran = fade;
    transparency = fade;
}

bool GraphicComponent::Playing()
{
    return graphic.Playing();
}