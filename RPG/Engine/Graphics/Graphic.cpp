//
//  Graphic.cpp
//  RPG
//
//  Created by Nolan Daigle on 12/8/15.
//  Copyright (c) 2015 Nolan Daigle. All rights reserved.
//

#include "Graphic.h"
#include "TextureLibrary.h"
#include <iostream>

Graphic::Graphic()
{
    currentAnimation = "";
    looping = false;
    frameWidth = 16;
    frameHeight = 16;
    animated = false;
    AddFrame("", sf::Vector2f(0,0) );
    frameIt = animation[""].begin();
    fps = 4;
}

Graphic::~Graphic()
{
    TextureLibrary::instance()->RemoveTexture(file);
}

void Graphic::SetScale( float x, float y )
{
    sprite.setScale(x, y);
}

void Graphic::SetFrameSize( int _w, int _h )
{
    frameWidth = _w;
    frameHeight = _h;
}

void Graphic::SetRotation( int rot)
{
    sprite.setRotation(rot);
}

void Graphic::Load(std::string _file)
{
    file = _file;
    
    TextureLibrary::instance()->AddTexture(file);
    
    txt = TextureLibrary::instance()->GetTexture(file);
    
    sprite.setTexture(*txt);
}

void Graphic::Update()
{
    if ( fpsTimer.getElapsedTime().asSeconds() > 1/fps && animated == true )
        Animate();
}

void Graphic::SetBox( int x, int y, int w, int h )
{
    frameWidth = w;
    frameHeight = h;
    sprite.setTextureRect(sf::IntRect(x,y,w,h) );
}

void Graphic::SetFPS( int _fps )
{
    fps = _fps;
}

void Graphic::Animate()
{
    fpsTimer.restart();
    SetBox(frameIt->x*frameWidth, frameIt->y*frameHeight,frameWidth, frameHeight );
    ++frameIt;
    if ( frameIt == animation[currentAnimation].end() )
        frameIt = animation[currentAnimation].begin();
}

void Graphic::AddFrame(std::string anim, sf::Vector2f coord)
{    animated = true;
    animation[anim].push_back(coord);
}

void Graphic::Play(std::string anim, bool loop)
{
    currentAnimation = anim;
    animated = true;
    looping = loop;
    frameIt = animation[currentAnimation].begin();
    Animate();
}

void Graphic::Stop()
{
    animated = false;
}

void Graphic::SetAnimation(std::string anim)
{
    currentAnimation = anim;
    frameIt = animation[currentAnimation].begin();
}