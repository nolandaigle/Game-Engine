//
//  ScreenComponent.h
//  Game
//
//  Created by Nolan Daigle on 1/28/16.
//  Copyright (c) 2016 Nolan Daigle. All rights reserved.
//

#ifndef __Game__ScreenComponent__
#define __Game__ScreenComponent__
#include "Component.h"

class ScreenComponent: public Component
{
private:
protected:
public:
    ScreenComponent(System *_system);
    ~ScreenComponent();
    void SetPixelate( bool enabled, float cap, float increment );
    void ScreenShake( float time, float intensity );
    void SlowMo( float multiplyer );
    
};

#endif /* defined(__Game__ScreenComponent__) */
