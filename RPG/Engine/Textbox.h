//
//  Textbox.h
//  RPG
//
//  Created by Nolan Daigle on 12/29/15.
//  Copyright (c) 2015 Nolan Daigle. All rights reserved.
//

#ifndef __RPG__Textbox__
#define __RPG__Textbox__
#include <SFML/Graphics.hpp>
#include "Graphics/Graphic.h"
#include "Audio/Sound.h"

class Textbox
{
private:
    sf::Font font;
    bool showing;
    bool grShowing;
    int y[2];
    
    int currentChar;
    int currentLine;
    
    int fade;
    
    Graphic *graphic;
    Sound *voice;
    
    std::vector<sf::Text> line;
    std::string text;
    
    float textspeed;
    float punctiationTime;
    float normalTime;
    float textTimer;
public:
    Textbox();
    ~Textbox();
    
    void Update(int screenx, int screeny, float dt );
    void Display(sf::RenderWindow *window);
    
    void Open();
    void Close();
    void Clear();
    void PushMessage(std::string message);
    void SetVoice(std::string file);
    
    void SetGraphic(std::string file);
    
    bool ShowGraphic(bool showing) { grShowing = showing; }
    bool IsShowing() { return showing; }
    
    sf::RectangleShape cinematic[3];
    
    Graphic *GetGraphic() { return graphic; }
};

#endif /* defined(__RPG__Textbox__) */
