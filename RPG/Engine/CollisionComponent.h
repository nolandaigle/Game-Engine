//
//  CollisionComponent.h
//  RPG
//
//  Created by Nolan Daigle on 12/28/15.
//  Copyright (c) 2015 Nolan Daigle. All rights reserved.
//

#ifndef __RPG__CollisionComponent__
#define __RPG__CollisionComponent__

#include "TransformComponent.h"

class CollisionComponent: public Component
{
private:
    std::vector<CollisionComponent*> ColliderList;
    std::string type;
protected:
public:
    CollisionComponent(System *_system, TransformComponent* _transform);
    ~CollisionComponent();
    TransformComponent *transform;
    std::string CollidingType(std::string side);
    std::string CollidingName(std::string side);
    bool TransformBoxColliding( TransformComponent *t1, TransformComponent *t2 );
    std::string TransformColliding( TransformComponent *t1, TransformComponent *t2 );
    std::string GetType();
    TransformComponent *GetTransform();
    void SetType(std::string _type);
    void SetTransform(TransformComponent *t ) { transform = t; }
};

#endif /* defined(__RPG__CollisionComponent__) */
