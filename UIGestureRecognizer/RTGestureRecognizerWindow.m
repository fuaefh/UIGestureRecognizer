//
//  RTGestureRecognizerWindow.m
//  UIGestureRecognizer
//
//  Created by MacBook on 16/6/7.
//  Copyright © 2016年 MacBook. All rights reserved.
//

#import "RTGestureRecognizerWindow.h"
#import "RTUIimageViewGestureRecognizer.h"
#import "RTMovieViewController.h"
#import "Constants.h"
#import "RTRotateView.h"

@interface RTGestureRecognizerWindow () <UIGestureRecognizerDelegate>
{
    RTUIimageViewGestureRecognizer *_imageView1;
    UIImageView *_logicImageView;
    UIImageView *_lucencyView;
    CGRect _startRect;
    UIViewController *_rootVc;
    NSInteger _resourceType;
    NSString *_resourceName;
}
@end

@implementation RTGestureRecognizerWindow 

- (id)initWithFrame:(CGRect)frame resourceName:(NSString *)name resourceType:(NSInteger)type beginRect:(CGRect)rect
{
    self = [super initWithFrame:frame];
    if (self) {
        _startRect = rect;
        _resourceType = type;
        _resourceName =name;
        [self setRootViewController];
        [self setDisplayView];
    }
    return self;
}

- (void)setRootViewController{
    self.windowLevel = UIWindowLevelAlert;
    UIViewController *vc = [[UIViewController alloc]init];
    _rootVc = vc;
    self.rootViewController = vc;
    _lucencyView = [[UIImageView alloc]initWithFrame:screenSize];
    _lucencyView.image = [UIImage imageNamed:@"toumin"];
    _lucencyView.alpha = 0;
    [UIView animateWithDuration:0.3 animations:^{
        _lucencyView.alpha = 1;
    } completion:^(BOOL finished) {
        if (finished) {
        }
    }];
    [_rootVc.view addSubview:_lucencyView];
}
#pragma mark-- 设置展示视图
- (void)setDisplayView
{
    if (_resourceType == imageResource) {
        [self setImagesWithName:_resourceName beginRect:_startRect];
    }
    else if (_resourceType == logicRotateImageResource){
        [self setLogicRotateImage];
    }
    else if (_resourceType == videoResource){
        RTMovieViewController *movieView = [[RTMovieViewController alloc]init];
        self.rootViewController = movieView;
    }
}
#pragma mark-- 设置逻辑方法的旋转视图
- (void)setLogicRotateImage
{
    _logicImageView = [[UIImageView alloc]initWithFrame:_startRect];
    _logicImageView.image = [UIImage imageNamed:_resourceName];
    _logicImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [self setTapGestureRecognizer:_logicImageView];
    [self setRotationGestureRecognizer:_logicImageView];
    [self setPinchGestureRecognizer:_logicImageView];
    
    [_rootVc.view addSubview:_logicImageView];
    
    [UIView animateWithDuration:0.3 animations:^{
        _logicImageView.frame = screenSize;
    } completion:^(BOOL finished) {
        if (finished) {
        }
    }];
}
#pragma mark-- setGestureRecognizer
#pragma mark setTapGestureRecognizer
- (void)setTapGestureRecognizer:(UIView *)view
{
    view.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapch = [[UITapGestureRecognizer alloc]
                                     initWithTarget:self action:@selector(handleTap1:)];
    tapch.numberOfTouchesRequired = 1;
    tapch.numberOfTapsRequired = 1;
    tapch.delegate = self;
    [view addGestureRecognizer:tapch];
}
#pragma mark setRotationGestureRecognizer
- (void)setRotationGestureRecognizer:(UIView *)view
{
    view.userInteractionEnabled = YES;
    UIRotationGestureRecognizer *rotate = [[UIRotationGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:@selector(handleRotate:)];
    rotate.delegate = self;
    [view addGestureRecognizer:rotate];
}
#pragma mark setPinchGestureRecognizer
- (void)setPinchGestureRecognizer:(UIView *)view
{
    view.userInteractionEnabled = YES;
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc]
                                       initWithTarget:self
                                       action:@selector(handlePinch:)];
    pinch.delegate = self;
    [view addGestureRecognizer:pinch];
}
#pragma mark-- 设置继承方法的旋转视图
- (void)setImagesWithName:(NSString *)name beginRect:(CGRect)rect
{
    _imageView1 = [[RTUIimageViewGestureRecognizer alloc]initWithFrame:rect];

    
    _imageView1.image = [UIImage imageNamed:name];

     _imageView1.contentMode = UIViewContentModeScaleAspectFit;
    
    
    [_imageView1 setGestureConfig:YES];
    
    [self setTapGestureRecognizer:_imageView1];
    
    [_rootVc.view addSubview:_imageView1];
    
    [UIView animateWithDuration:0.3 animations:^{
        _imageView1.frame = screenSize;
    } completion:^(BOOL finished) {
        if (finished) {
        }
    }];
}
#pragma mark-- 旋转事件
- (void)handleRotate:(UIRotationGestureRecognizer *)recognizer
{
    [[RTRotateView sharedManager] rotateView:recognizer.view angle:recognizer.rotation];
    recognizer.rotation = 0;
    if (recognizer.state==UIGestureRecognizerStateEnded) {
        [self endTransformView:_logicImageView During:0.2];
    }
}
#pragma mark-- 点击事件
- (void)handleTap1:(UIPinchGestureRecognizer *)recognizer
{
    [self dismiss];
}
#pragma mark-- 捏合事件
- (void)handlePinch:(UIPinchGestureRecognizer *)recognizer
{
    [[RTRotateView sharedManager] pinchView:recognizer.view scaleX:recognizer.scale scaleY:recognizer.scale];

    recognizer.scale = 1;
    if(recognizer.state==UIGestureRecognizerStateEnded)
    {
        [self endTransformView:_logicImageView During:0.2];
    }
}

- (void)show {
    [self makeKeyAndVisible];
}

- (void)dismiss {
    [UIView animateWithDuration:0.3 animations:^{
        _imageView1.frame = _startRect;
        _imageView1.alpha = 0;
        _logicImageView.frame = _startRect;
        _logicImageView.alpha = 0;
        _lucencyView.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self resignKeyWindow];
            self.hidden = YES;
        }
    }];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches anyObject];
    CGPoint location = [touch locationInView:self];
    if (_resourceType == videoResource) {
        if (location.y >= screenSize.size.height/2) {
            [UIView animateWithDuration:0.3 animations:^{
                self.rootViewController.view.frame = CGRectMake(0, -300, screenSize.size.width, screenSize.size.height);
            } completion:^(BOOL finished) {
                if (finished) {
                    [self resignKeyWindow];
                    self.hidden = YES;
                }
            }];
        }
    }
}
# pragma mark-- 结束形变
- (void)endTransformView:(UIView*)view During:(CGFloat)time
{
    [UIView animateWithDuration:time animations:^{
        view.transform =
        CGAffineTransformIdentity;
    }];
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
@end
