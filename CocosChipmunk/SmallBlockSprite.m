//
//  SmallBlockSprite.m
//  CocosChipmunk
//
//  Created by 欧 on 11/05/19.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SmallBlockSprite.h"


@implementation SmallBlockSprite

- (id)initWithSpace:(cpSpace *)theSpace location:(CGPoint)location
{
    if((self = [super initWithSpace:theSpace location:location spriteFrameName:@"block_1.png"])) {
        canBeDestroyed = NO;
    }
    return self;
}

@end
