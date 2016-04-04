//
//  Selector.cpp
//  Game
//
//  Created by Nolan Daigle on 3/18/16.
//  Copyright (c) 2016 Nolan Daigle. All rights reserved.
//

#include "ResourcePath.hpp"
#include "Selector.h"

Selector::Selector(int _x, int _y, std::string _name, System *_system)
{
    x = _x;
    y = _y;
    name = _name;
    system = _system;
    curOption = 0;
    selL.Load("Resources/Graphic/GUI/ArrowL.png");
    selR.Load("Resources/Graphic/GUI/ArrowR.png");
    
    if ( !font.loadFromFile(resourcePath()+"Resources/Fonts/Japan.ttf") )
    {
    }
    label.setFont(font);
    label.setCharacterSize(24);
    label.setColor(sf::Color::Black);
    label.setString(name);
    
    option.setFont(font);
    option.setCharacterSize(24);
    option.setColor(sf::Color::Black);
    
    selected = false;
}

Selector::~Selector()
{
}

void Selector::Display()
{
    label.setPosition( x, y);
    option.setPosition( x + 32 + label.getGlobalBounds().width, y);
    selR.SetPosition(x+label.getGlobalBounds().width+8, y+8);
    selL.SetPosition(x+label.getGlobalBounds().width+option.getGlobalBounds().width+48, y+8);
    
    if ( selected )
    {
        selR.SetColor( 200, 200, 0);
        selL.SetColor( 200, 200, 0);
        option.setColor(sf::Color( 200, 200, 0 ));
    }
    else
    {
        selR.SetColor( 0, 0, 0);
        selL.SetColor( 0, 0, 0);
        option.setColor(sf::Color( 0, 0, 0 ));
    }
    
    system->GetWindow()->draw(*selL.GetSprite(), system->GetShader());
    system->GetWindow()->draw(*selR.GetSprite(), system->GetShader());
    system->GetWindow()->draw(label, system->GetShader());
    system->GetWindow()->draw(option, system->GetShader());
}

void Selector::AddOption(std::string newOption)
{
    options.push_back(newOption);
    option.setString(options[curOption]);
}

void Selector::Swipe(std::string dir)
{
    if ( dir == "right" )
    {
        if ( curOption < options.size()-1 )
            curOption = curOption + 1;
        else
            curOption = 0;
    }
    else if ( dir == "left" )
    {
        curOption = curOption - 1;
        
        if ( curOption  < 0 )
            curOption = options.size()-1;
    }
    
    option.setString(options[curOption]);
}