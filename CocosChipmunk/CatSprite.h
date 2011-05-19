//
//  CatSprite.h
//  CocosChipmunk
//
//  Created by 欧 on 11/05/19.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CPSprite.h"

@interface CatSprite : CPSprite {
    CCAnimation *sleepAnimation;
}

- (id)initWithSpace:(cpSpace *)theSpace location:(CGPoint)location;

- (void)sleep;
- (void)wake;

@end
