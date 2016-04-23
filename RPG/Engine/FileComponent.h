//
//  FileComponent.h
//  Game
//
//  Created by Nolan Daigle on 3/18/16.
//  Copyright (c) 2016 Nolan Daigle. All rights reserved.
//

#ifndef __Game__FileComponent__
#define __Game__FileComponent__

#include "Component.h"
#include <fstream>
#include "json/json.h"

class FileComponent: public Component
{
private:
    std::string filename;
    Json::Value file;
    
protected:
public:
    FileComponent(System *_system);
    ~FileComponent();
    void OpenFile(std::string fi);
    std::string GetVariable(std::string variable);
    void SetVariable(std::string variable, std::string value);
    void WriteFile();
};

#endif /* defined(__Game__FileComponent__) */
