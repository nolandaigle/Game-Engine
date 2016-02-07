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
}

GraphicComponent::~GraphicComponent()
{
}

void GraphicComponent::Display(int x, int y)
{
        graphic.Update();
        graphic.SetPosition(x, y);
        system->GetWindow()->draw(*graphic.GetSprite());
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

bool GraphicComponent::Playing()
{
    return graphic.Playing();
}