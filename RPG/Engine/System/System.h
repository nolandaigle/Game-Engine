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
#include <iostream>
#include "Textbox.h"

class System
{
private:
    //SFML System variables
    sf::RenderWindow *window;
    sf::View *view;
    sf::Color screencolor;
    sf::Event event;
    float viewSize;
    float sleep;
    
    //Debug Mode
    bool debugging;
    
    //Textbox
    Textbox textbox;
    
    //Variables for holding Deltatime and FPS information
    sf::Clock frameTimer;
    float dt;
    float fps;
    bool slowing;
    float slowspeed;
    float targetslow;
    
    //Whether the player is in the pause state or the game state;
    bool paused;
    
    //Soundtrack music stuff
    sf::Music music;
    
    //Variables for Pixel Shader Effect
    sf::Shader shader;
    float shaderOnset;
    float shaderCap;
    float shaderIncrement;
    bool shaderEnabled;
    
    //Screenshake stuff
    int screenX, screenY;
    float shakeX, shakeY;
    float xvel, yvel;
    float shakeTimer;
    bool shaking;
public:
    System();
    ~System();
    
    //Loads windows and shaders
    bool Load();
    //Displays textbox and updates shaders
    void Display();
    
    //Accessor functiosn for textbox, windows, views, shader
    Textbox *GetTextbox() { return &textbox;}
    sf::RenderWindow *GetWindow() { return window; }
    sf::Event *GetEvent() { return &event; }
    sf::View *GetView() { return view; }
    sf::Shader *GetShader() { return &shader; }
    bool ShaderEnabled();
    float GetFPS() { return fps; }
    void SetSize(int size)
    {
        viewSize = size;
        GetView()->setSize(viewSize*256, viewSize*240);
    }
    void SetMusic(std::string file);
    void SetMusicLoop(bool loop);
    void PlayMusic();
    void StopMusic();
    
    //Function to change Pixel Shader intensity
    void SetPixelate( bool enabled, float cap, float increment );
    
    //Returns amount of time since last frame
    float DeltaTime() { return dt; }
    
    //Screen size and screen resolutions
    int resolution_w;
    int resolution_h;
    
    void Sleep() { sleep -= DeltaTime(); }
    void SetSleep(float time) { sleep = time; }
    float GetSleep() { return sleep; }
    
    float Lerp(float num, float target, float ramp);
    void ScreenShake( float time, float intensity );
    void SlowMo(float multiplyer);
    void Pause()
    {
        if (paused == true) { paused = false; }
        else if (paused == false) { paused = true; }
        std::cout<<"Pausing: "<<paused<<std::endl;
    }
    bool IsPaused() { return paused; }
    
    void SetScreenColor(int r, int g, int b ) { screencolor = sf::Color( r, g, b ); }
    sf::Color GetScreenColor() { return screencolor; }
};

#endif /* defined(__RPG__System__) */