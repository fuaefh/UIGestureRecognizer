//
//  RTRotateView.m
//  UIGestureRecognizer
//
//  Created by MacBook on 16/6/14.
//  Copyright © 2016年 MacBook. All rights reserved.
//

#import "RTRotateView.h"

@implementation RTRotateView

+ (RTRotateView *)sharedManager
{
    static RTRotateView *sharedRotateViewInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedRotateViewInstance = [[self alloc] init];
    });
    return sharedRotateViewInstance;
}

- (void)rotateView:(UIView *)view angle:(CGFloat)angle
{
    view.transform = CGAffineTransformRotate(view.transform, angle);
}

- (void)pinchView:(UIView *)view scaleX:(CGFloat)scalex scaleY:(CGFloat)scaley
{
    view.transform = CGAffineTransformScale(view.transform, scalex, scaley);
}

@end
