//
//  System.h
//  RPG
//
//  Created by Nolan Daigle on 12/7/15.
//  Copyright (c) 2015 Nolan Daigle. All rights reserved.
//

#ifndef __RPG__System__
#define __RPG__System__

#include <SFML/System.hpp>
#include <SFML/Graphics.hpp>
#include "Textbox.h"

class System
{
private:
    sf::RenderWindow *window;
    sf::View *view;
    sf::Event event;
    Textbox textbox;
    
    sf::Clock frameTimer;
    float dt;
public:
    System();
    ~System();
    
    void Load();
    void Display();
    void Signal(std::string signal);
    void Message(std::string entity, std::string message);
    
    Textbox *GetTextbox() { return &textbox;}
    
    sf::RenderWindow *GetWindow() { return window; }
    sf::Event *GetEvent() { return &event; }
    sf::View *GetView() { return view; }
    
    float DeltaTime() { return dt; }
    
    float size;
};

#endif /* defined(__RPG__System__) */