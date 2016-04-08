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
    system->GetView()->setCenter(std::floor(x), std::floor(y));
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