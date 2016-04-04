
//
//  CollisionComponent.cpp
//  RPG
//
//  Created by Nolan Daigle on 12/28/15.
//  Copyright (c) 2015 Nolan Daigle. All rights reserved.
//

#include "CollisionComponent.h"
#include "EntityLibrary.h"

CollisionComponent::CollisionComponent(System *_system, TransformComponent* _transform) : Component(_system)
{
    name = "CollisionComponent";
    transform = _transform;
    type = "Collider";
}

CollisionComponent::~CollisionComponent()
{
}

std::string CollisionComponent::GetType()
{
    return type;
}

void CollisionComponent::SetType(std::string _type)
{
    type = _type;
}

TransformComponent *CollisionComponent::GetTransform()
{
    if ( transform )
    {
        return transform;
    }
    else
    {
        return NULL;
    }
}

bool CollisionComponent::TransformBoxColliding( TransformComponent *t1, TransformComponent *t2 )
{
    if ( t1->x > t2->x+t2->w )
        return false;
    if ( t1->x+t1->w > t2->x )
        return false;
    if ( t1->y > t2->y+t2->h )
        return false;
    if ( t1->y+t1->h < t2->y )
        return false;
    
    return true;
}

std::string CollisionComponent::TransformColliding( TransformComponent *t1, TransformComponent *t2 )
{
    if ( t1 )
    {
        if ( t2 )
        {
            if ( t1->x+t1->hCPoint[0].x > t2->x &&
                t1->x+t1->hCPoint[0].x < t2->x+t2->w &&
                t1->y+t1->hCPoint[0].y > t2->y &&
                t1->y+t1->hCPoint[0].y < t2->y+t2->h )
                return "left";
            if ( t1->x+t1->hCPoint[1].x > t2->x &&
                t1->x+t1->hCPoint[1].x < t2->x+t2->w &&
                t1->y+t1->hCPoint[1].y > t2->y &&
                t1->y+t1->hCPoint[1].y < t2->y+t2->h )
                return "left";
            if ( t1->x+t1->hCPoint[2].x > t2->x &&
                t1->x+t1->hCPoint[2].x < t2->x+t2->w &&
                t1->y+t1->hCPoint[2].y > t2->y &&
                t1->y+t1->hCPoint[2].y < t2->y+t2->h )
                return "right";
            if ( t1->x+t1->hCPoint[3].x > t2->x &&
                t1->x+t1->hCPoint[3].x < t2->x+t2->w &&
                t1->y+t1->hCPoint[3].y > t2->y &&
                t1->y+t1->hCPoint[3].y < t2->y+t2->h )
                return "right";
            if ( t1->x+t1->vCPoint[0].x > t2->x &&
                t1->x+t1->vCPoint[0].x < t2->x+t2->w &&
                t1->y+t1->vCPoint[0].y > t2->y &&
                t1->y+t1->vCPoint[0].y < t2->y+t2->h )
                return "top";
            if ( t1->x+t1->vCPoint[1].x > t2->x &&
                t1->x+t1->vCPoint[1].x < t2->x+t2->w &&
                t1->y+t1->vCPoint[1].y > t2->y &&
                t1->y+t1->vCPoint[1].y < t2->y+t2->h )
                return "top";
            if ( t1->x+t1->vCPoint[2].x > t2->x &&
                t1->x+t1->vCPoint[2].x < t2->x+t2->w &&
                t1->y+t1->vCPoint[2].y > t2->y &&
                t1->y+t1->vCPoint[2].y < t2->y+t2->h )
                return "bottom";
            if ( t1->x+t1->vCPoint[3].x > t2->x &&
                t1->x+t1->vCPoint[3].x < t2->x+t2->w &&
                t1->y+t1->vCPoint[3].y > t2->y &&
                t1->y+t1->vCPoint[3].y < t2->y+t2->h )
                return "bottom";
        }
    }
    
    return "none";
}

std::string CollisionComponent::CollidingType(std::string side)
{
    int e = 0;
    TransformComponent *transform1;
    for (std::vector<CollisionComponent*>::iterator it = EntityLibrary::instance()->cList.begin() ; it != EntityLibrary::instance()->cList.end(); ++it)
    {
        transform1 = (*it)->transform;
        
        if ( transform1 )
        {
            if ( transform != transform1 )
            {
                if ( side == "all" )
                {
                    if ( TransformColliding(transform, transform1) != "none" )
                        return (*it)->GetType();
                }
                else
                {
                    if ( TransformColliding(transform, transform1) == side )
                        return (*it)->GetType();
                }
            }
        }
        
    }
    return "";
}

std::string CollisionComponent::CollidingName(std::string side)
{
    int e = 0;
    TransformComponent *transform1;
    for (std::vector<CollisionComponent*>::iterator it = EntityLibrary::instance()->cList.begin() ; it != EntityLibrary::instance()->cList.end(); ++it)
    {
        transform1 = (*it)->transform;
        
        if ( transform1 )
        {
            if ( transform != transform1 )
            {
                if ( side == "all" )
                {
                    if ( TransformColliding(transform, transform1) != "none" )
                        return (*it)->GetEntityName();
                }
                else
                {
                    if ( TransformColliding(transform, transform1) == side )
                        return (*it)->GetEntityName();
                }
            }
        }
        
    }
    return "";
}