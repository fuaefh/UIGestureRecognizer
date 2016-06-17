//
//  RTRotateView.h
//  UIGestureRecognizer
//
//  Created by MacBook on 16/6/14.
//  Copyright © 2016年 MacBook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RTRotateView : NSObject


+ (RTRotateView *)sharedManager;

- (void)rotateView:(UIView *)view angle:(CGFloat)angle;
- (void)pinchView:(UIView *)view scaleX:(CGFloat)scalex scaleY:(CGFloat)scaley;


@end
