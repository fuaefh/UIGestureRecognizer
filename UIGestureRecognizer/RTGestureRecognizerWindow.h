//
//  RTGestureRecognizerWindow.h
//  UIGestureRecognizer
//
//  Created by MacBook on 16/6/7.
//  Copyright © 2016年 MacBook. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RTGestureRecognizerWindow : UIWindow 

- (id)initWithFrame:(CGRect)frame resourceName:(NSString *)name resourceType:(NSInteger)type beginRect:(CGRect)rect;
- (void)show;
- (void)dismiss;

@end
