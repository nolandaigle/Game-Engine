//
//  Component.h
//  RPG
//
//  Created by Nolan Daigle on 12/9/15.
//  Copyright (c) 2015 Nolan Daigle. All rights reserved.
//

#ifndef __RPG__Component__
#define __RPG__Component__

#include <iostream>
#include "System.h"

class Component
{
private:
protected:
    std::string name;
    System *system;
public:
    Component(System *_system);
    ~Component();
    void Bang();
    void Collapse();
    void Turn();
    void Display();
    
    std::string GetName() { return name; }
};

#endif /* defined(__RPG__Component__) */
