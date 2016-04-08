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

class FileComponent: public Component
{
private:
    std::string filename;
    std::fstream file;
protected:
public:
    FileComponent(System *_system);
    ~FileComponent();
    void OpenFile(std::string f);
    void CloseFile();
    std::string GetLine();
    void WriteLine(std::string line);
};

#endif /* defined(__Game__FileComponent__) */
