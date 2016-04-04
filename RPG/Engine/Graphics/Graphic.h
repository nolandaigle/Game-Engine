//
//  Graphic.h
//  RPG
//
//  Created by Nolan Daigle on 12/8/15.
//  Copyright (c) 2015 Nolan Daigle. All rights reserved.
//

#ifndef __RPG__Graphic__
#define __RPG__Graphic__

#include <SFML/Graphics.hpp>

class Graphic
{
private:
    sf::Texture *txt;
    sf::Sprite sprite;
    std::string file;
    bool looping;
    int frameWidth;
    int frameHeight;
    bool animated;
    sf::Clock fpsTimer;
    float fps;
    
    std::map<std::string, std::vector<sf::Vector2f>> animation;
    std::vector<sf::Vector2f>::iterator frameIt;
    std::string currentAnimation;
public:
    Graphic();
    ~Graphic();
    void Load(std::string _file);
    void Update();
    sf::Sprite *GetSprite() { return &sprite; }
    void SetPosition( int x, int y) { sprite.setPosition(x, y); }
    void SetBox( int x, int y, int w, int h );
    void SetScale(float x, float y );
    void SetFrameSize( int _w, int _h );
    void SetRotation(int rot );
    void SetColor( int r, int g, int b, int t = 255 ) { sprite.setColor( sf::Color( r, g, b, t )); }
    void SetAnimation( std::string anim );
    void SetFPS( int _fps );
    void Animate();
    void AddFrame(std::string anim, sf::Vector2f coord);
    void Play(std::string anim, bool loop);
    void Stop();
    bool Playing() { return animated; }
    
    std::string GetCurrentAnimation() { return currentAnimation; }
};

#endif /* defined(__RPG__Graphic__) */
