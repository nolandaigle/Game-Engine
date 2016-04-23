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

void FileComponent::OpenFile(std::string fi)
{
    filename = fi;
    file.clear();
    std::ifstream ifstr(filename);
    ifstr>>file;
    ifstr.close();
    
}

std::string FileComponent::GetVariable(std::string variable)
{
    std::ifstream ifstr(filename);
    ifstr>>file;
    ifstr.close();
    return file[variable].asString();
}

void FileComponent::SetVariable(std::string variable, std::string value)
{
    file[variable] = value;
}

void FileComponent::WriteFile()
{
    Json::StyledWriter styledWriter;
    std::ofstream ofstr(filename);
    ofstr<<styledWriter.write(file);
    ofstr.close();
}