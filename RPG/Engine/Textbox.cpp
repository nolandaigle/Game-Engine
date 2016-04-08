//
//  Textbox.cpp
//  RPG
//
//  Created by Nolan Daigle on 12/29/15.
//  Copyright (c) 2015 Nolan Daigle. All rights reserved.
//

#include <iostream>
#include "ResourcePath.hpp"
#include "Textbox.h"

Textbox::Textbox()
{
    showing = false;
    grShowing = true;
    
    y[0] = -40;
    y[1] = 241;
    
    currentChar = 0;
    currentLine = 0;
    
    fade = 0;
    
    cinematic[0] = sf::RectangleShape(sf::Vector2f(960,480));
    cinematic[0].setFillColor(sf::Color::Black);
    cinematic[1] = sf::RectangleShape(sf::Vector2f(960,480));
    cinematic[1].setFillColor(sf::Color::Black);
    cinematic[2] = sf::RectangleShape(sf::Vector2f(960,540));
    cinematic[2].setFillColor(sf::Color( 255, 255, 255, fade ));
    if ( !font.loadFromFile(resourcePath()+"/Resources/Fonts/hellovetica.ttf"))
    {
    }
    
    textspeed = .1;
    textTimer = 0;
    normalTime = .1;
    punctiationTime = .5;
    
    text = "";
    
    voice = new Sound();
    voice->Load("Resources/Sound/uh.wav");
}

Textbox::~Textbox()
{
    delete graphic;
}

void Textbox::Update(int screenx, int screeny, float dt)
{
    textTimer += dt;
    
    if ( showing )
    {
        if ( fade < 200 )
            fade += 2;
        if ( y[0] < 0 )
            y[0] += 1;
        if ( y[1] > 480 )
            y[1] -= 1;
        
        //BLACK BORDER
        cinematic[2].setFillColor(sf::Color( 0, 0, 0, fade ));
        cinematic[0].setPosition(screenx, screeny+y[0]);
        cinematic[1].setPosition(screenx, screeny+y[1]);
        cinematic[2].setPosition(screenx, screeny);
        
        //FACE
        graphic->SetPosition(screenx+40, screeny+75);
        //graphic->GetSprite()->setColor(sf::Color( 255, 255, 255, fade ) );
        graphic->Update();
        
        //TEXT
        int i = 0;
        
        sf::String str = line.begin()->getString();
        std::string str2 = str;
        
        std::string lineText = text.substr(0,currentChar);
        if ( currentChar < text.size() && textTimer > textspeed )
        {
            if ( text.substr(currentChar,1) != " " )
                voice->Play();
            if ( text.substr(currentChar,1) == "." || text.substr(currentChar,1) == "?" )
                textspeed = punctiationTime;
            else
                textspeed = normalTime;
            textTimer = 0;
            currentChar++;
        }
        line[currentLine].setString(lineText);
        
        int boxWidth = 128;
        ///
        int ty = 0;
        for (std::vector<sf::Text>::iterator it = line.begin() ; it != line.end(); ++it)
        {
            it->setColor( sf::Color( 255, 255, 255, fade ) );
            it->setPosition(screenx+150, screeny+50+ty);
            ty += 10;
        }
        
    }
    else
    {
        if ( fade > 0 )
        {
            fade -= 2;
            cinematic[2].setFillColor(sf::Color( 0, 0, 0, fade ));
            //graphic->GetSprite()->setColor(sf::Color( 255, 255, 255, fade ) );
        }
        if ( y[0] > -41 )
            y[0] -= 1;
        if ( y[1] < 241 )
            y[1] += 1;
        cinematic[0].setPosition(screenx, screeny+y[0]);
        cinematic[1].setPosition(screenx, screeny+y[1]);
        cinematic[2].setPosition(screenx, screeny);
    }
}

void Textbox::Display(sf::RenderWindow *window)
{
    if ( showing )
    {
        window->draw(cinematic[2]);
        window->draw(cinematic[0]);
        window->draw(cinematic[1]);
        if ( GetGraphic() && grShowing )
            window->draw(*GetGraphic()->GetSprite());
        
        for (std::vector<sf::Text>::iterator it = line.begin() ; it != line.end(); ++it)
        {
            window->draw((*it));
        }
    }
}

void Textbox::PushMessage(std::string message)
{
    Clear();
    text = message;
    
    line.push_back(sf::Text("", font, 24));
    line[line.size()-1].setScale(.5, .5);
}

void Textbox::SetGraphic(std::string file )
{
    if (!graphic)
    {
        graphic = new Graphic;
        graphic->Load(file);
        graphic->SetBox(0, 0, 32, 32);
        //graphic->GetSprite()->setScale(3, 3);
        
        graphic->AddFrame("Talk", sf::Vector2f(0,0));
        graphic->AddFrame("Talk", sf::Vector2f(1,0));
    }
    else
    {
        graphic->Load(file);
    }
}

void Textbox::SetVoice(std::string file)
{
    voice->Load("Resources/Sound/"+file);
}

void Textbox::Open()
{
    showing = true;
    graphic->Play("Talk", true);
}

void Textbox::Close()
{
    for (std::vector<sf::Text>::iterator it = line.begin() ; it != line.end(); ++it)
    {
        it->setColor( sf::Color( 255, 255, 255, 0 ) );
    }
    showing = false;
    graphic->Stop();
}

void Textbox::Clear()
{
    currentLine = 0;
    currentChar = 0;
    text = "";
    line.clear();
}