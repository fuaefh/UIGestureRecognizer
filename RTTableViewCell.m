//
//  RTTableViewCell.m
//  UIGestureRecognizer
//
//  Created by MacBook on 16/6/7.
//  Copyright © 2016年 MacBook. All rights reserved.
//

#import "RTTableViewCell.h"
#import "RTCellContent.h"
#import "Constants.h"

#define userNameFontSize 40
#define userNameFontColor [UIColor grayColor]

@interface RTTableViewCell ()<UIGestureRecognizerDelegate>
{
    /**
     *  扩展Cell需修改的地方
     */
    UIImageView *_avatar;
    UIImageView *_logo;
    UIImageView *_movieImage;
    UILabel *_userName;
    NSString *_imageName;
}

@end

@implementation RTTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initCellView];
    }
    return self;
}

#pragma mark-- 初始化视图
- (void)initCellView
{
    /**
     *  扩展Cell需修改的地方
     */
    /**
     添加_avatar
     */
    _avatar=[[UIImageView alloc]init];
    CGFloat avatarX=5,avatarY=5;
    CGRect avatarRect=CGRectMake(avatarX, avatarY,90, 90);

    _avatar.frame=avatarRect;

    _avatar.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                     initWithTarget:self action:@selector(handleTap:)];
    tap.numberOfTouchesRequired = 1;
    tap.numberOfTapsRequired = 1;
    tap.delegate = self;
    [_avatar addGestureRecognizer:tap];
    [self.contentView addSubview:_avatar];
    /**
     添加_userName
     */
    _userName=[[UILabel alloc]init];
    _userName.textColor=userNameFontColor;
    _userName.font=[UIFont systemFontOfSize:userNameFontSize];
    [self.contentView addSubview:_userName];
    /**
     添加_logo
     */
    _logo = [[UIImageView alloc]initWithFrame:CGRectMake(100, 0, 50, 50)];
    _logo.userInteractionEnabled = YES;
    [self.contentView addSubview:_logo];
    /**
     添加_movieImage
     */
    _movieImage = [[UIImageView alloc]initWithFrame:CGRectMake(screenSize.size.width-95, 20, 60, 60)];
    _movieImage.userInteractionEnabled = YES;
    [self.contentView addSubview:_movieImage];

}

- (void)handleTap:(UIPinchGestureRecognizer *)recognizer
{
}

#pragma mark-- 设置
- (void)setStatus:(RTCellContent *)status{
    UIImage *avatarimage = [UIImage imageNamed:status.profileImageUrl];
    _avatar.contentMode = UIViewContentModeScaleAspectFit;

    _avatar.image=avatarimage;
    
    
    
    
    _imageName = status.profileImageUrl;
    
    CGFloat userNameX= CGRectGetMaxX(_avatar.frame)+10 ;
    CGFloat userNameY=50;
    CGSize userNameSize=[status.userName sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:userNameFontSize]}];
    CGRect userNameRect=CGRectMake(userNameX, userNameY, userNameSize.width,userNameSize.height);
    _userName.text=status.userName;
    _userName.frame=userNameRect;
    
    _logo.image = [UIImage imageNamed:status.logoImageName];
    _movieImage.image = [UIImage imageNamed:status.movieUrl];
}

# pragma mark-- UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    CGPoint location = [touch locationInView:self];
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]){
        return NO;
    }
    
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UIImageView"]) {
        if (location.x <= _avatar.frame.origin.x + _avatar.frame.size.width) {
            [self setUserDef:10];
            return NO;
        }
       else  if ((location.x >= _avatar.frame.origin.x + _avatar.frame.size.width) && (location.x <= screenSize.size.width-95)) {
            [self setUserDef:20];
            return NO;
        }
       else if (location.x >= screenSize.size.width-95) {
            [self setUserDef:30];
            return NO;
        }
    }
    return YES;
}
# pragma mark-- myFunctions
- (void)setUserDef:(NSInteger)value
{
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    NSNumber * defvalue = [NSNumber numberWithInteger:value];
    [userDef setObject:defvalue forKey:@"touchOnImageViewOrNot"];
    [userDef synchronize];
}

@end
