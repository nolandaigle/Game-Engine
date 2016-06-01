//
//  System.cpp
//  RPG
//
//  Created by Nolan Daigle on 12/7/15.
//  Copyright (c) 2015 Nolan Daigle. All rights reserved.
//

#include "System.h"
#include "EntityLibrary.h"
#include "Resourcepath.hpp"

bool System::Load()
{
    //Create new SF::Render window at 3x scale
    window = new sf::RenderWindow( sf::VideoMode(resolution_w, resolution_h), "*_*", sf::Style::Fullscreen );
    //Create new SF::View with the size of the game's resolution
    view = new sf::View(sf::FloatRect(0, 0, resolution_w, resolution_h));
    //Tell window to draw the view
    window->setView(*view);
    //Cap framerate at 60
    window->setFramerateLimit(60);
    //Set KeyRepeat to false
    window->setKeyRepeatEnabled(false);
    window->setVerticalSyncEnabled(true);
    
    //Load shader from file and set parameters
    if (!shader.loadFromFile(resourcePath()+"Resources/Shaders/pixelate.frag", sf::Shader::Fragment))
        return false;
    shader.setParameter("pixel_threshold", shaderOnset);
    
    //Return false if there is trouble loading the window or view
    if (!window || !view )
        return false;
    
    music.setLoop(true);
    
    return true;
}

System::System()
{
    //Set the view size to a 1:1 ratio with resolution
    viewSize = 1;
    //Set inital DeltaTime value to 0
    dt = 0;
    //Set initial FPS
    fps = 0;
    
    //Set initial shader information
    shaderOnset = 0;    //What the actual shader value holds
    shaderCap = .25;    //What number the shaderOnset is moving toward
    shaderEnabled = false;  //Whether or not the shader in enabled
    shaderIncrement = .001; //The increment amount that the shader moves toward the shaderCap
    
    //Set screen resolution
    resolution_w = 960;
    resolution_h = 540;
    
    //Screenshake stuff
    shaking = false;
    screenX = 0;
    screenY = 0;
    shakeX = 10;
    shakeY = 10;
    shakeTimer = 0;
    xvel = 0;
    yvel = 0;
    
    //SLOWMO
    slowing = false;
    slowspeed = .0;
    targetslow = 0;
    
    screencolor = sf::Color(253,244,235);
    
    //Debug stuff
    debugging = false;
    paused = false;
}

System::~System()
{
    //Delete window and view if they have been loaded
    if ( window != NULL )
        delete window;
    if ( view != NULL )
        delete view;
}


void System::SetPixelate( bool enabled, float cap, float increment )
{
    shaderEnabled = enabled;
    shaderCap = cap;
    shaderIncrement = increment;
}

void System::Display()
{
    //Tell window to draw the view
    window->setView(*view);
    
    if ( shaking )
    {
        float x = GetView()->getCenter().x;
        float y = GetView()->getCenter().y;
        
        if ( shakeTimer > 0 )
        {
            shakeTimer -= DeltaTime();
            
            if ( x < shakeX )
                xvel += 1;
            else if ( x > shakeX )
            xvel -= 1;
            
            if ( y < shakeY )
                yvel += 1;
            else if ( y > shakeY )
                yvel -= 1;
            
            x += xvel;
            y += yvel;
        }
        else if ( x - resolution_w/2 < 2 || x - resolution_w/2 > -2 )
        {
            x += Lerp( x, screenX, .1 );
            y += Lerp( y, screenY, .1 );
        }
        else
        {
            view->setCenter(0, 0);
        }
        
        view->setCenter(x, y);
    }
    
    if ( shaderEnabled )
    {
        //If shader onset is less than the cap, increase by increment
        if (shaderOnset < shaderCap )
        {
            shaderOnset += shaderIncrement;
            shader.setParameter("pixel_threshold", shaderOnset);
        }
        else    //Else, decrease by increment
        {
            shaderOnset -= shaderIncrement;
            shader.setParameter("pixel_threshold", shaderOnset);
        }
    }
    else
    {
        //If shader is disabled, lower until it is 0
        if ( shaderOnset > .01 )
        {
            shaderOnset -= shaderIncrement;
            shader.setParameter("pixel_threshold", shaderOnset);
        }
        else
            shaderOnset = 0;
    }
    
    if (slowing)
    {
        if (slowspeed < targetslow )
            slowspeed += Lerp(slowspeed, targetslow, .02);
        else
            slowspeed = 0;
        EntityLibrary::instance()->Slow(slowspeed);
    }
    
    //Update textbox
    textbox.Update( GetView()->getCenter().x - GetView()->getSize().x/2,GetView()->getCenter().y - GetView()->getSize().y/2, DeltaTime() );
    //Display textbox
    textbox.Display(GetWindow());
    
    //Debug info
    if ( debugging == true )
    {
    }
    
    //Deltatime is equal to the amount of time since the last frame
    dt = frameTimer.getElapsedTime().asSeconds();
    frameTimer.restart();
    
    //Update FPS
    fps = 1/dt;
    
}

bool System::ShaderEnabled()
{
    if(shaderOnset <= 0 )
        return false;
    else
        return true;
}

float System::Lerp(float num, float target, float ramp)
{
    if (target != num )
        return (target - num)*ramp;
    else
        return 0;
}

void System::ScreenShake( float time, float intensity )
{
    shakeTimer = time;
    screenX = GetView()->getCenter().x;
    screenY = GetView()->getCenter().y;
    shakeX = GetView()->getCenter().x + intensity/2;
    shakeY = GetView()->getCenter().y;// + intensity/2;
    shaking = true;
}

void System::SlowMo(float multiplyer)
{
    slowing = true;
    targetslow = multiplyer;
}

void System::SetMusic(std::string file)
{
    music.openFromFile(resourcePath()+file);
}

void System::PlayMusic()
{
    music.play();
}

void System::StopMusic()
{
    music.stop();
}

void System::SetMusicLoop(bool loop)
{
    music.setLoop(loop);
}