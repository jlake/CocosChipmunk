//
//  CatBedBackSprite.m
//  CocosChipmunk
//
//  Created by 欧 on 11/05/19.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CatBedBackSprite.h"

@implementation CatBedBackSprite

- (void)createBodyAtLocation:(CGPoint)location {
    
}

- (id)initWithSpace:(cpSpace *)theSpace location:(CGPoint)location {
    if ((self = [super initWithSpace:theSpace location:location spriteFrameName:@"catbed_back.png"])) {
        canBeDestroyed = NO;
    }
    return self;
}

@end