//
//  FileComponent.cpp
//  Game
//
//  Created by Nolan Daigle on 3/18/16.
//  Copyright (c) 2016 Nolan Daigle. All rights reserved.
//

#include "FileComponent.h"

FileComponent::FileComponent(System *_system) : Component(_system)
{
}

FileComponent::~FileComponent()
{
}

void FileComponent::OpenFile(std::string f)
{
    filename = f;
    file.open(f);
}

void FileComponent::CloseFile()
{
    file.close();
}

std::string FileComponent::GetLine()
{
    std::string temp;
    file>>temp;
    return temp;
}

void FileComponent::WriteLine(std::string line)
{
    file<<line;
}