//
//  DialogComponent.cpp
//  RPG
//
//  Created by Nolan Daigle on 12/29/15.
//  Copyright (c) 2015 Nolan Daigle. All rights reserved.
//

#include "DialogComponent.h"

DialogComponent::DialogComponent(System *_system) : Component(_system)
{
    name = "DialogComponent";
    system = _system;
    graphic = "Resources/Graphic/test.png";
    voice = "uh.wav";
    currentMessage = 0;
}

DialogComponent::~DialogComponent()
{
    
}

void DialogComponent::OpenDialogue()
{
    if ( currentMessage == messages.size() )
        HideBox();
    else if ( !system->GetTextbox()->IsShowing() )
    {
        system->GetTextbox()->SetGraphic(graphic);
        system->GetTextbox()->SetVoice(voice);
        system->GetTextbox()->Open();
        system->GetTextbox()->PushMessage(messages[currentMessage]);
        currentMessage += 1;
    }
    else if ( system->GetTextbox()->IsShowing() )
    {
        system->GetTextbox()->Clear();
        system->GetTextbox()->PushMessage(messages[currentMessage]);
        currentMessage += 1;
    }
}

void DialogComponent::PushMessage(std::string message)
{
    messages.push_back(message);
}

void DialogComponent::HideBox()
{
    currentMessage = 0;
    if ( system->GetTextbox()->IsShowing() )
    {
        system->GetTextbox()->Close();
    }
}

void DialogComponent::SetGraphic(std::string _graphic)
{
    graphic = _graphic;
}

void DialogComponent::SetVoice(std::string _voice)
{
    voice = _voice;
}

void DialogComponent::Clear()
{
    system->GetTextbox()->Clear();
    currentMessage = 0;
    messages.clear();
}