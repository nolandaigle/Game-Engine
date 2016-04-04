//
//  GUIComponent.cpp
//  Game
//
//  Created by Nolan Daigle on 3/17/16.
//  Copyright (c) 2016 Nolan Daigle. All rights reserved.
//

#include "ResourcePath.hpp"
#include "GUIComponent.h"

GUIComponent::GUIComponent(int _x, int _y, System *_system ) : Component(_system)
{
    x = _x;
    y = _y;
    system = _system;
    
    if ( !font.loadFromFile(resourcePath()+"Resources/Fonts/lunchds.ttf") )
    {
    }
    text.setFont(font);
    text.setCharacterSize(24);
    text.setColor(sf::Color::Black);
    
    selected = 0;
}

GUIComponent::~GUIComponent()
{    
}

void GUIComponent::Display()
{
    text.setPosition(x, y);
    system->GetWindow()->draw(text);
    for ( int i = 0; i < selectors.size(); i++ )
    {
        if ( selectors[i] )
        {
            if ( selected == -1 )
                selectors[i]->Select(false);
            else if ( i == selected )
                selectors[i]->Select(true);
            else
                selectors[i]->Select(false);
            
            selectors[i]->Display();
        }
    }
}

void GUIComponent::SetString(std::string string)
{
    text.setString(string);
}

void GUIComponent::SetColor(int r, int g, int b)
{
    text.setColor(sf::Color( r, g, b));
}

void GUIComponent::AddSelector(std::string name)
{
    selectors.push_back(new Selector( x, y+(selectors.size()+1)*24, name, system));
}

void GUIComponent::AddOption(int s, std::string option)
{
    if ( selectors[s] )
        selectors[s]->AddOption(option);
}

void GUIComponent::Swipe(std::string dir)
{
    if ( selectors[selected] )
        selectors[selected]->Swipe(dir);
}