//
//  Sound.cpp
//  RPG
//
//  Created by Nolan Daigle on 12/8/15.
//  Copyright (c) 2015 Nolan Daigle. All rights reserved.
//

#include "Sound.h"
#include "BufferLibrary.h"

Sound::Sound()
{
}

Sound::~Sound()
{
    BufferLibrary::instance()->RemoveBuffer("nice_music.ogg");
}

void Sound::Play()
{
    sound.play();
}

void Sound::Stop()
{
    sound.stop();
}

void Sound::Load(std::string file)
{
    BufferLibrary::instance()->AddBuffer(file);
    
    buffer = BufferLibrary::instance()->GetBuffer(file);
    sound.setBuffer(*buffer);
}

void Sound::SetVolume(int vol)
{
    sound.setVolume(vol);
}

void Sound::SetLoop(bool loop)
{
    sound.setLoop(loop);
}