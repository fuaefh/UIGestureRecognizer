//
//  RTCellContent.m
//  UIGestureRecognizer
//
//  Created by MacBook on 16/6/7.
//  Copyright © 2016年 MacBook. All rights reserved.
//

#import "RTCellContent.h"

@implementation RTCellContent

- (RTCellContent *)initWithDictionary:(NSDictionary *)dic
{
    if(self=[super init]){
        /**
         *  扩展Cell需修改的地方
         */
        self.profileImageUrl=dic[@"profileImageUrl"];
        self.userName=dic[@"userName"];
        self.logoImageName=dic[@"logoImageName"];
        self.movieUrl=dic[@"movieUrl"];
    }
    return self;
}

+(RTCellContent *)statusWithDictionary:(NSDictionary *)dic{
    RTCellContent *status=[[RTCellContent alloc]initWithDictionary:dic];
    return status;
}

@end
