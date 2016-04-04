//
//  GUIComponent.h
//  Game
//
//  Created by Nolan Daigle on 3/17/16.
//  Copyright (c) 2016 Nolan Daigle. All rights reserved.
//

#ifndef __Game__GUIComponent__
#define __Game__GUIComponent__

#include "Component.h"
#include "Selector.h"

class GUIComponent: public Component
{
private:
    int x, y;
    int selected;
    std::vector<Selector*> selectors;
    sf::Font font;
    sf::Text text;
public:
    GUIComponent(int x, int y, System *_system);
    ~GUIComponent();
    
    void AddSelector(std::string name);
    void AddOption(int s, std::string option);
    void Swipe(std::string dir);
    
    void Display();
    void SetString(std::string string);
    void SetColor(int r, int g, int b);
    void Select( int s ) { selected = s; }
    std::string GetSelected() { return selectors[selected]->GetSelected(); }
};

#endif /* defined(__Game__GUIComponent__) */
