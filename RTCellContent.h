//
//  RTCellContent.h
//  UIGestureRecognizer
//
//  Created by MacBook on 16/6/7.
//  Copyright © 2016年 MacBook. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RTCellContent : NSObject
/**
 *  扩展Cell需修改的地方
 */
@property (nonatomic,copy) NSString *profileImageUrl;
@property (nonatomic,copy) NSString *userName;
@property (nonatomic,copy) NSString *logoImageName;
@property (nonatomic,copy) NSString *movieUrl;

- (RTCellContent *)initWithDictionary:(NSDictionary *)dic;
+ (RTCellContent *)statusWithDictionary:(NSDictionary *)dic;

@end
