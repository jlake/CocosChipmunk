//
//  CatBedSprite.h
//  CocosChipmunk
//
//  Created by 欧 on 11/05/19.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CPSprite.h"
#import "CatBedBackSprite.h"

@interface CatBedSprite : CPSprite {
    CatBedBackSprite *back;
    cpShape *shape2;
    cpShape *shape3;
}

@property (readonly) CatBedBackSprite *back;

- (id)initWithSpace:(cpSpace *)theSpace location:(CGPoint)location;

@end
