//
//  CatSprite.m
//  CocosChipmunk
//
//  Created by 欧 on 11/05/19.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CatSprite.h"

@implementation CatSprite

- (void)createBodyAtLocation:(CGPoint)location {
    
    int num = 4;
    CGPoint verts[] = {
        cpv(-31.5f/2.0, 70.5f/2.0),
        cpv(43.5f/2.0, 65.5f/2.0),
        cpv(34.5f/2.0, -69.5f/2.0),
        cpv(-52.5f/2.0, -69.5f/2.0)
    };
    
    float mass = 1.0;
    float moment = cpMomentForPoly(mass, num, verts, CGPointZero);
    body = cpBodyNew(mass, moment);
    body->p = location;
    cpSpaceAddBody(space, body);
    
    shape = cpPolyShapeNew(body, num, verts, CGPointZero);
    shape->e = 0.3; 
    shape->u = 0.5;
    shape->collision_type = kCollisionTypeCat;
    cpSpaceAddShape(space, shape);
    
}

- (id)initWithSpace:(cpSpace *)theSpace location:(CGPoint)location {
    if ((self = [super initWithSpace:theSpace location:location spriteFrameName:@"cat_sleepy.png"])) {
        canBeDestroyed = NO;    
        
        NSArray *sleepAnimImages = [NSArray arrayWithObjects:@"cat_sleepy.png",
                                    @"cat_curlup_1.png", @"cat_curlup2.png", @"cat_curlup3.png", nil];
        NSMutableArray *sleepAnimFrames = [NSMutableArray array];
        for (NSString *sleepAnimImage in sleepAnimImages) {
            [sleepAnimFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:sleepAnimImage]];
        }        
        sleepAnimation = [CCAnimation animationWithFrames:sleepAnimFrames delay:0.2];
        [sleepAnimation retain];
        
    }
    return self;
}

- (void)sleep {
    [self stopAllActions];
    [self runAction:[CCAnimate actionWithAnimation:sleepAnimation restoreOriginalFrame:NO]];
}

- (void)wake {    
    [self setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"cat_awake.png"]];    
}

- (void)dealloc {
    [sleepAnimation release];
    [super dealloc];
}

@end