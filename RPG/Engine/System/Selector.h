//
//  Selector.h
//  Game
//
//  Created by Nolan Daigle on 3/18/16.
//  Copyright (c) 2016 Nolan Daigle. All rights reserved.
//

#ifndef __Game__Selector__
#define __Game__Selector__

#include <vector>
#include <string>
#include <SFML/Graphics.hpp>
#include "Graphic.h"
#include "System.h"

class Selector
{
private:
    int x;
    int y;
    System *system;
    std::string name;
    std::vector<std::string> options;
    int curOption;
    sf::Font font;
    sf::Text option;
    sf::Text label;
    Graphic selL;
    Graphic selR;
    
    bool selected;
    
public:
    Selector(int _x, int _y, std::string _name, System *_system);
    ~Selector();
    void Display();
    void AddOption(std::string option);
    void Swipe(std::string dir);
    void Select(bool s) { selected = s; }
    
    std::string GetSelected() { return options[curOption]; }
    
};

#endif /* defined(__Game__Selector__) */
