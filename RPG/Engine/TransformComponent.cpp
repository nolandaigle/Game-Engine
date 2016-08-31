//
//  TransformComponent.cpp
//  RPG
//
//  Created by Nolan Daigle on 12/13/15.
//  Copyright (c) 2015 Nolan Daigle. All rights reserved.
//

#include "TransformComponent.h"
#include <cmath>

TransformComponent::TransformComponent(System *_system) : Component(_system)
{
    system = _system;
    name = "TransformComponent";
    
    x = 0;
    y = 0;
    w = 16;
    h = 16;
    
    vCPoint[0] = sf::Vector2f( 2, 0 ); // TOP left
    vCPoint[1] = sf::Vector2f(w-2, 0); // TOP right
    vCPoint[2] = sf::Vector2f( 2, h ); //BOTTOM left
    vCPoint[3] = sf::Vector2f(w-2, h); //BOTTOM right
    
    hCPoint[0] = sf::Vector2f( 0, 2 ); // LEFT top
    hCPoint[1] = sf::Vector2f( 0, h-2); // LEFT bottom
    hCPoint[2] = sf::Vector2f( w, 2 ); // RIGHT top
    hCPoint[3] = sf::Vector2f(w, h-2); // RIGHT bottom
}

TransformComponent::~TransformComponent()
{
}

void TransformComponent::CenterView()
{
    system->GetView()->setCenter((x), (y));
}

void TransformComponent::SetSize( int _w, int _h )
{
    w = _w;
    h = _h;
    
    vCPoint[0] = sf::Vector2f( 2, 0 ); // TOP left
    vCPoint[1] = sf::Vector2f(w-2, 0); // TOP right
    vCPoint[2] = sf::Vector2f( 2, h ); //BOTTOM left
    vCPoint[3] = sf::Vector2f(w-2, h); //BOTTOM right
    
    hCPoint[0] = sf::Vector2f( 0, 2 ); // LEFT top
    hCPoint[1] = sf::Vector2f( 0, h-2); // LEFT bottom
    hCPoint[2] = sf::Vector2f( w, 2 ); // RIGHT top
    hCPoint[3] = sf::Vector2f(w, h-2); // RIGHT bottom
}

void TransformComponent::Display(bool pointed)
{
    if ( pointed )
    {
    for ( int i = 0; i < 4; i++)
    {
        sf::RectangleShape hRect(sf::Vector2f(1, 1));
        hRect.setPosition(sf::Vector2f( x+hCPoint[i].x, y+hCPoint[i].y));
        hRect.setFillColor(sf::Color::Yellow);
        system->GetWindow()->draw(hRect);
        
        sf::RectangleShape vRect(sf::Vector2f(1, 1));
        vRect.setPosition(sf::Vector2f(x+ vCPoint[i].x, y+ vCPoint[i].y));
        vRect.setFillColor(sf::Color::Red);
        system->GetWindow()->draw(vRect);
    }
    }
    else
    {
        sf::RectangleShape rect(sf::Vector2f(w, h));
        rect.setPosition(sf::Vector2f( x, y));
        rect.setFillColor(sf::Color::Green);
        system->GetWindow()->draw(rect);
    }
}