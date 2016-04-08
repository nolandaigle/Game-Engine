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
    
    quad = sf::VertexArray(sf::Quads, 4);
    
    quad[0].position = sf::Vector2f(0, 0);
    quad[1].position = sf::Vector2f(0, 0);
    quad[2].position = sf::Vector2f(0, 0);
    quad[3].position = sf::Vector2f(0, 0);
    
    
    scaleX = 1.0;
    scaleY = 1.0;
}

Graphic::~Graphic()
{
    TextureLibrary::instance()->RemoveTexture(file);
}

void Graphic::SetPosition( int x, int y)
{
    quad[0].position = sf::Vector2f(x, y);
    quad[1].position = sf::Vector2f(x+(frameWidth*scaleX), y);
    quad[2].position = sf::Vector2f(x+(frameWidth*scaleX), y+(frameHeight*scaleY));
    quad[3].position = sf::Vector2f(x, y+(frameHeight*scaleY));
}

void Graphic::SetColor( int r, int g, int b, int t )
{
    quad[0].color = sf::Color( r, g, b );
    quad[1].color = sf::Color( r, g, b );
    quad[2].color = sf::Color( r, g, b );
    quad[3].color = sf::Color( r, g, b );
}

void Graphic::SetTransparency(int t)
{
    quad[0].color.a = t;
    quad[1].color.a = t;
    quad[2].color.a = t;
    quad[3].color.a = t;
}

void Graphic::SetScale( int x, int y )
{
    scaleX = x;
    scaleY = y;
}

void Graphic::SetFrameSize( int _w, int _h )
{
    frameWidth = _w;
    frameHeight = _h;
}

void Graphic::SetRotation( int rot)
{
}

void Graphic::Load(std::string _file)
{
    file = _file;
    
    TextureLibrary::instance()->AddTexture(file);
    
    txt = TextureLibrary::instance()->GetTexture(file);
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
    
    quad[0].texCoords = sf::Vector2f(x, y);
    quad[1].texCoords = sf::Vector2f(x+w-0.0075, y);
    quad[2].texCoords = sf::Vector2f(x+w-0.0075, y+h-0.0075);
    quad[3].texCoords = sf::Vector2f(x, y+h-0.0075);
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