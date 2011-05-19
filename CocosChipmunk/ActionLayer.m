//
//  ActionLayer.m
//  CocosChipmunk
//
//  Created by 欧 on 11/05/19.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ActionLayer.h"
#import "drawSpace.h"
#import "SimpleAudioEngine.h"

@implementation ActionLayer

+ (id)scene
{
    CCScene *scene = [CCScene node];
    ActionLayer *layer = [ActionLayer node];
    [scene addChild:layer];
    return scene;
}

- (void)initMenu
{
    CCLabelBMFont *restartLabel = [CCLabelBMFont labelWithString:@"Restart" fntFile:@"Arial.fnt"]; 
    
    restartItem = [CCMenuItemLabel itemWithLabel:restartLabel target:self selector:@selector(restartTapped:)];
    restartItem.scale = 0.1;
    restartItem.position = ccp(winSize.width/2, 140);
    
    CCMenu *menu = [CCMenu menuWithItems:restartItem, nil];
    menu.position = CGPointZero;
    [self addChild:menu z:99];
}

- (void)restartTapped:(id)sender {
    
    [[CCDirector sharedDirector] replaceScene:[CCTransitionZoomFlipX transitionWithDuration:0.5 scene:[ActionLayer scene]]];
    
}

- (void)showHello
{
    msgLabel = [CCLabelBMFont labelWithString:@"Hello, Chipmunk!" fntFile:@"Arial.fnt"];
    msgLabel.position = ccp(winSize.width/2, winSize.height/2);
    [self addChild:msgLabel z:99];
    
    msgLabel.scale = 0.1;
    [msgLabel runAction:[CCSequence actions:
                           [CCScaleTo actionWithDuration:0.5 scale:1.0],
                           [CCDelayTime actionWithDuration:3.0],
                           [CCScaleTo actionWithDuration:0.5 scale:0.1],
                           [CCCallFunc actionWithTarget:self selector:@selector(hideHello)],
                           nil]];

}

- (void)hideHello
{
    msgLabel.visible = false;
}

- (void)createSpace {
    space = cpSpaceNew();
    space->gravity = ccp(0, -750);
    cpSpaceResizeStaticHash(space, 400, 200);
    cpSpaceResizeActiveHash(space, 200, 200);
}

- (void)createGround {
    
    CGPoint lowerLeft = ccp(0, 0);
    CGPoint lowerRight = ccp(winSize.width, 0);
    
    cpBody *groundBody = cpBodyNewStatic();
    
    float radius = 10.0;
    cpShape *groundShape = cpSegmentShapeNew(groundBody, lowerLeft, lowerRight, radius);
    groundShape->e = 0.5; // elasticity
    groundShape->u = 1.0; // friction
    groundShape->collision_type = kCollisionTypeGround;
    cpSpaceAddShape(space, groundShape);
    
}

- (void)createBoxAtLocation:(CGPoint)location {
    
    float boxSize = 60.0;
    float mass = 1.0;
    cpBody *body = cpBodyNew(mass, cpMomentForBox(mass, boxSize, boxSize));
    body->p = location;
    cpSpaceAddBody(space, body);
    
    cpShape *shape = cpBoxShapeNew(body, boxSize, boxSize);
    shape->e = 1.0; 
    shape->u = 1.0;
    cpSpaceAddShape(space, shape);
}

- (void) preloadSound
{
    SimpleAudioEngine *engine = [SimpleAudioEngine sharedEngine];
    [engine preloadEffect:@"sleep.wav"];
    [engine preloadEffect:@"wake.wav"];
    [engine preloadEffect:@"proof.wav"];
}

- (void)endScene:(BOOL)win {
    
    if (gameOver) return;
    gameOver = TRUE;
    
    NSString *message;
    if (win) {
        message = @"You win!";
        [cat sleep];
        [[SimpleAudioEngine sharedEngine] playEffect:@"sleep.wav"];
    } else {
        message = @"You lose!";
        [cat wake];
        [[SimpleAudioEngine sharedEngine] playEffect:@"wake.wav"];
    }
    
    [msgLabel setString:message];
    msgLabel.visible = true;
    msgLabel.scale = 0.1;
    msgLabel.position = ccp(winSize.width/2, 180);
    
    [restartItem runAction:[CCScaleTo actionWithDuration:0.5 scale:1.0]];
    [msgLabel runAction:[CCScaleTo actionWithDuration:0.5 scale:1.0]];
    
}

- (void)catHitGround {
    CCLOG(@"Cat hit the ground!");
    [self endScene:FALSE];
}

- (void)catHitBed {
    CCLOG(@"Cat hit the bed!");
    [self endScene:TRUE];
}

cpBool catHitGround(cpArbiter *arb, struct cpSpace *space, void *data) {
    ActionLayer *layer = (ActionLayer *)data;
    [layer catHitGround];
    return cpTrue;
}

cpBool catHitBed(cpArbiter *arb, struct cpSpace *space, void *data) {
    ActionLayer *layer = (ActionLayer *)data;
    [layer catHitBed];
    return cpTrue;
}


- (void) createBatchNode
{
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"catnap.plist"];
    batchNode = [CCSpriteBatchNode batchNodeWithFile:@"catnap.png"];
    [self addChild:batchNode];
    
    cat = [[[CatSprite alloc] initWithSpace:space location:ccp(245, 217)] autorelease];
    [batchNode addChild:cat];  
    
    SmallBlockSprite *block1a = [[[SmallBlockSprite alloc] initWithSpace:space location:ccp(213, 47)] autorelease];
    [batchNode addChild:block1a];
    
    SmallBlockSprite *block1b = [[[SmallBlockSprite alloc] initWithSpace:space location:ccp(272, 59)] autorelease];
    [batchNode addChild:block1b];
    
    SmallBlockSprite *block1c = [[[SmallBlockSprite alloc] initWithSpace:space location:ccp(267, 158)] autorelease];
    [batchNode addChild:block1c];
    
    LargeBlockSprite *block2a = [[[LargeBlockSprite alloc] initWithSpace:space location:ccp(270, 102)] autorelease];
    [batchNode addChild:block2a];
    cpBodySetAngle(block2a.body, CC_DEGREES_TO_RADIANS(90));
    
    LargeBlockSprite *block2b = [[[LargeBlockSprite alloc] initWithSpace:space location:ccp(223, 139)] autorelease];
    cpBodySetAngle(block2b.body, CC_DEGREES_TO_RADIANS(90));
    [batchNode addChild:block2b];
    
    LargeBlockSprite *block2c = [[[LargeBlockSprite alloc] initWithSpace:space location:ccp(214, 85)] autorelease];
    [batchNode addChild:block2c]; 
    
    CatBedSprite *catBed = [[[CatBedSprite alloc] initWithSpace:space location:ccp(230, 50)] autorelease];
    [batchNode addChild:catBed z:1];
    [batchNode addChild:catBed.back z:-1];
    
    cpSpaceAddCollisionHandler(space, kCollisionTypeCat, kCollisionTypeGround,
                               catHitGround, NULL, NULL, NULL, self);
    cpSpaceAddCollisionHandler(space, kCollisionTypeCat, kCollisionTypeBed, catHitBed, NULL, NULL, NULL, self);
}

- (id)init
{
    if((self = [super init])) {
        winSize = [CCDirector sharedDirector].winSize;
        
        CCSprite *background = [CCSprite spriteWithFile:@"catnap_bg.png"];
        background.anchorPoint = CGPointZero;
        [self addChild:background z:-1];
        
        [self preloadSound];
        
        [self initMenu];
        [self showHello];
        
        [self createSpace];
        [self createGround];
        
        [self createBoxAtLocation:ccp(100, 100)];
        [self createBoxAtLocation:ccp(200, 200)];
        
        [self scheduleUpdate];

        mouse = cpMouseNew(space);
        self.isTouchEnabled = YES;
        
        [self createBatchNode];

    }
    return self;
}

- (void) update:(ccTime)dt
{
    cpSpaceStep(space, dt);
    for (CPSprite *sprite in batchNode.children) {
        [sprite update];
    };
}

- (void)draw
{
    drawSpaceOptions options = {
        0,  // drawHash
        0,  // drawBBs
        1,  // drawShapes
        4.0,  // collisionPointSize
        4.0,  // bodyPointSize
        2.0  // lineThickness
    };
    
    drawSpace(space, &options);
}

// Add new methods
- (void)registerWithTouchDispatcher {
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
    
    cpShape *shape = cpSpacePointQueryFirst(space, touchLocation, GRABABLE_MASK_BIT, 0);
    if(shape) {
        CPSprite *sprite = (CPSprite *) shape->data;
        [sprite destroy];
        [[SimpleAudioEngine sharedEngine] playEffect:@"proof.wav"];
    }
    
    cpMouseGrab(mouse, touchLocation, false);
    return YES;
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
    cpMouseMove(mouse, touchLocation);
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    cpMouseRelease(mouse);
}

- (void)ccTouchCancelled:(UITouch *)touch withEvent:(UIEvent *)event {
    cpMouseRelease(mouse);    
}

- (void) dealloc
{
    cpMouseFree(mouse);
	cpSpaceFree(space);
	
	[super dealloc];
}

@end
