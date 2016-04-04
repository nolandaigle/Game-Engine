//
//  DialogComponent.h
//  RPG
//
//  Created by Nolan Daigle on 12/29/15.
//  Copyright (c) 2015 Nolan Daigle. All rights reserved.
//

#ifndef __RPG__DialogComponent__
#define __RPG__DialogComponent__

#include "Component.h"
#include "System/System.h"

class DialogComponent: public Component
{
private:
    std::string graphic;
    std::string voice;
    
    int currentMessage;
    std::vector<std::string> messages;
protected:
public:
    DialogComponent(System *_system);
    ~DialogComponent();
    void PushMessage(std::string message);
    void OpenDialogue();
    void HideBox();
    void SetGraphic(std::string graphic);
    void ShowGraphic(bool show) { system->GetTextbox()->ShowGraphic(show); }
    void SetVoice(std::string voice);
};

#endif /* defined(__RPG__DialogComponent__) */
