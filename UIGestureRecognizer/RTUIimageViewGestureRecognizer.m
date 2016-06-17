//
//  RTUIimageViewGestureRecognizer.m
//  UIGestureRecognizer
//
//  Created by MacBook on 16/6/12.
//  Copyright © 2016年 MacBook. All rights reserved.
//

#import "RTUIimageViewGestureRecognizer.h"
#import "Constants.h"

@interface RTUIimageViewGestureRecognizer () <UIGestureRecognizerDelegate>
{
    CGFloat _animateWithDuration;
    NSInteger _lastGearsNumber;
}
/**
 *  纪录每次点击view时，view的初始frame
 */
@property(nonatomic,assign) CGRect rectValue;
@property(nonatomic,assign) CGFloat rotateAngle;
@property(nonatomic,assign) CGRect selfFrame;
@end

@implementation RTUIimageViewGestureRecognizer
#pragma mark-- associative添加属性

#pragma mark-- init
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _animateWithDuration = 0.2;
        _lastGearsNumber = 0;
    }
    return self;
}
#pragma mark-- 手势配置
- (void)setGestureConfig:(BOOL)yesOrNo
{
    if (yesOrNo) {
        self.userInteractionEnabled = YES;
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]
                                       initWithTarget:self
                                       action:@selector(handlePan:)];
        UIRotationGestureRecognizer *rotate = [[UIRotationGestureRecognizer alloc]
                                               initWithTarget:self
                                               action:@selector(handleRotate:)];
        UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:@selector(handlePinch:)];
        pan.delegate = self;
        rotate.delegate = self;
        pinch.delegate = self;
        [self addGestureRecognizer:pan];
        [self addGestureRecognizer:rotate];
        [self addGestureRecognizer:pinch];
    }
    else
    {
        NSInteger gestureCount = self.gestureRecognizers.count;
        for (NSInteger i = 0; i < gestureCount; i++)
        {
            [self removeGestureRecognizer:[self.gestureRecognizers objectAtIndex:0]];
        }
    }
}
#pragma mark-- 事件
- (void)handlePan:(UIPanGestureRecognizer *)recognizer
{
    CGPoint translation = [recognizer translationInView:self.superview];
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,recognizer.view.center.y + translation.y);
    [recognizer setTranslation:CGPointZero inView:self.superview];
    /**
     *  保证imageView不出边界
     */
    if (self.center.x <= 0) {
        self.center = CGPointMake(0, self.center.y);
    }
    else if (self.center.x >= screenSize.size.width) {
        self.center = CGPointMake(screenSize.size.width, self.center.y);
    }
    if (self.center.y <= 0)
    {
        self.center = CGPointMake(self.center.x, 0);
    }
    else if (self.center.y >= screenSize.size.height)
    {
        self.center = CGPointMake(self.center.x, screenSize.size.height);
    }
    if (recognizer.state == UIGestureRecognizerStateEnded)
    {
        [self refreshSelfFrame];
        [self endGestureRecognizer];
    }
}

- (void)handleRotate:(UIRotationGestureRecognizer *)recognizer
{
    recognizer.view.transform = CGAffineTransformRotate(recognizer.view.transform, recognizer.rotation);
    self.rotateAngle = self.rotateAngle + recognizer.rotation;
    recognizer.rotation = 0;
    
    if(recognizer.state == UIGestureRecognizerStateEnded)
    {
    }
}

- (void)handlePinch:(UIPinchGestureRecognizer *)recognizer
{
    recognizer.view.transform = CGAffineTransformScale(recognizer.view.transform, recognizer.scale, recognizer.scale);
    recognizer.scale = 1;
    /**
     *  结束后恢复
     */
    if(recognizer.state == UIGestureRecognizerStateEnded)
    {
    }
}
#pragma mark-- touchs
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.frame.size.width != screenSize.size.width && self.frame.size.height != screenSize.size.height) {
        [self setRectValue:self.rectValue];
    }
    /**
     *  总是最上层显示
     */
    [self.superview bringSubviewToFront:self];
}
# pragma mark-- UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    return  YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}
#pragma mark-- myFunction
- (CGRect)beginRect
{
    CGRect beginR = self.rectValue;
    return beginR;
}

- (void)endGestureRecognizer
{
    [UIView animateWithDuration:_animateWithDuration animations:^{
        self.transform = CGAffineTransformIdentity;
        self.frame = screenSize;
    }];
}

- (NSInteger)rightAngleNumber
{
    int number = self.rotateAngle / 1.571;
    return number;
}

- (CGFloat)remainderAngle
{
    CGFloat number = self.rotateAngle - 1.571 * [self rightAngleNumber];
    return number;
}

- (NSInteger)gearsNumber
{
    NSInteger argument = 1;
    NSInteger rightAngleN = [self rightAngleNumber];
    CGFloat remainderA = [self remainderAngle];
    if (remainderA < 0) {
        rightAngleN = -rightAngleN;
        argument = -1;
        remainderA = -remainderA;
    }
    NSInteger gearsNum;
    if (remainderA <= 0.8) {
        gearsNum = rightAngleN;
    }
    else
    {
        gearsNum = rightAngleN + 1;
    }
    NSInteger val = gearsNum / 4;
    gearsNum = gearsNum - val*4;
    return gearsNum*argument;
}

- (void)refreshSelfFrame
{
    NSInteger gearsNum = [self gearsNumber];
    if (gearsNum == _lastGearsNumber) {
        _animateWithDuration = 0.2;
    }
    else
    {
        _animateWithDuration = 0;
        _lastGearsNumber = gearsNum;
    }
    if ((gearsNum == -1) || (gearsNum == 3)) {
        CGImageRef   cgimage = self.image.CGImage;
        UIImage *rot = [UIImage imageWithCGImage:cgimage scale:1 orientation:UIImageOrientationLeft];
        self.image = rot;
    }
    else if ((gearsNum == -2) || (gearsNum == 2))
    {
        CGImageRef   cgimage = self.image.CGImage;
        UIImage *rot = [UIImage imageWithCGImage:cgimage scale:1 orientation:UIImageOrientationDown];
        self.image = rot;
    }
    else if ((gearsNum == -3) || (gearsNum == 1))
    {
        CGImageRef   cgimage = self.image.CGImage;
        UIImage *rot = [UIImage imageWithCGImage:cgimage scale:1 orientation:UIImageOrientationRight];
        self.image = rot;
    }
    else if (gearsNum == 0)
    {
        CGImageRef   cgimage = self.image.CGImage;
        UIImage *rot = [UIImage imageWithCGImage:cgimage scale:1 orientation:UIImageOrientationUp];
        self.image = rot;
    }
}
@end
