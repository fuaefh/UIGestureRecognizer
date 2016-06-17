//
//  RTTableViewCell.h
//  UIGestureRecognizer
//
//  Created by MacBook on 16/6/7.
//  Copyright © 2016年 MacBook. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RTCellContent;


@interface RTTableViewCell : UITableViewCell

@property (nonatomic,strong) RTCellContent *status;
@property (assign,nonatomic) CGFloat height;

@end
