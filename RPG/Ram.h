//
//  Ram.h
//  RPG
//
//  Created by Nolan Daigle on 12/7/15.
//  Copyright (c) 2015 Nolan Daigle. All rights reserved.
//

#ifndef __RPG__Ram__
#define __RPG__Ram__

#include "System.h"

class Ram
{
private:
    System system;
public:
    Ram();
    ~Ram();
    void Bang();
    void Turn();
    void Collapse();
};

#endif /* defined(__RPG__Ram__) */
