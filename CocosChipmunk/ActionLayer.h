//
//  ActionLayer.h
//  CocosChipmunk
//
//  Created by 欧 on 11/05/19.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "chipmunk.h"
#import "drawSpace.h"
#import "cpMouse.h"

#import "SmallBlockSprite.h"
#import "LargeBlockSprite.h"
#import "CatSprite.h"
#import "CatBedSprite.h"

@interface ActionLayer : CCLayer {
    CGSize winSize;
    
    CCLabelBMFont *msgLabel;
    CCMenuItemLabel *restartItem;
    
    
    cpSpace *space;
    cpMouse *mouse;
    
    CCSpriteBatchNode *batchNode;
    CatSprite *cat;
    
    BOOL gameOver;
}

+ (id)scene;

@end
