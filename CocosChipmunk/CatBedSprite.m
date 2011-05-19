//
//  CatBedSprite.m
//  CocosChipmunk
//
//  Created by 欧 on 11/05/19.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CatBedSprite.h"

@implementation CatBedSprite
@synthesize back;

- (void)createBodyAtLocation:(CGPoint)location {
    
    int num1 = 4;
    CGPoint verts1[] = {
        cpv(-180.0f/2, 37.0f/2),
        cpv(-158.0f/2, 33.0f/2),
        cpv(-148.0f/2, -39.0f/2),
        cpv(-171.0f/2, -38.0f/2)
    };
    
    int num2 = 4;
    CGPoint verts2[] = {
        cpv(-172.0f/2, -28.0f/2),
        cpv(180.0f/2, -32.0f/2),
        cpv(176.0f/2, -52.0f/2),
        cpv(-169.0f/2, -52.0f/2)
    };
    
    int num3 = 4;
    CGPoint verts3[] = {
        cpv(-172.0f/2, -28.0f/2),
        cpv(180.0f/2, -32.0f/2),
        cpv(176.0f/2, -52.0f/2),
        cpv(-169.0f/2, -52.0f/2)
    };

    float mass = 1.0;
    float moment1 = cpMomentForPoly(mass, num1, verts1, CGPointZero);
    float moment2 = cpMomentForPoly(mass, num2, verts2, CGPointZero);    
    float moment3 = cpMomentForPoly(mass, num3, verts3, CGPointZero);
    
    body = cpBodyNew(mass*3, moment1+moment2+moment3);
    body->p = location;
    body->data = self;
    cpSpaceAddBody(space, body);
    
    shape = cpPolyShapeNew(body, num1, verts1, CGPointZero);
    shape->e = 0.3; 
    shape->u = 1.0;
    shape->data = self;    
    cpSpaceAddShape(space, shape);
    
    shape2 = cpPolyShapeNew(body, num2, verts2, CGPointZero);
    shape2->e = 0.3; 
    shape2->u = 1.0;
    shape2->data = self;
    shape2->collision_type = kCollisionTypeBed;
    cpSpaceAddShape(space, shape2);
    
    shape3 = cpPolyShapeNew(body, num3, verts3, CGPointZero);
    shape3->e = 0.3; 
    shape3->u = 1.0;
    shape3->data = self;
    cpSpaceAddShape(space, shape3);
    
    
}

- (id)initWithSpace:(cpSpace *)theSpace location:(CGPoint)location {
    if ((self = [super initWithSpace:theSpace location:location spriteFrameName:@"catbed_front.png"])) {
                
        back = [[[CatBedBackSprite alloc] initWithSpace:theSpace location:location] autorelease];
        back.body = body;
        
        canBeDestroyed = NO;
        
    }
    return self;
}

@end
