//
//  Scene.cpp
//  RPG
//
//  Created by Nolan Daigle on 12/9/15.
//  Copyright (c) 2015 Nolan Daigle. All rights reserved.
//

#include "Scene.h"

Scene::Scene(System *_system)
{
    system = _system;
    eL = EntityLibrary::instance();
}

Scene::~Scene()
{
    Collapse();
}

void Scene::Bang()
{
    
}

void Scene::Input(sf::Event *event)
{
}

void Scene::Turn()
{
    
}

void Scene::Display()
{
}

void Scene::Collapse()
{
    
}