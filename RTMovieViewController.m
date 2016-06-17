//
//  RTMovieViewController.m
//  UIGestureRecognizer
//
//  Created by MacBook on 16/6/15.
//  Copyright © 2016年 MacBook. All rights reserved.
//

#import "RTMovieViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import "Constants.h"


@interface RTMovieViewController ()

@property (nonatomic,strong)AVPlayer *player;
@end
@implementation RTMovieViewController


-(instancetype)init{
    if (self = [super init]) {
//        self.view.backgroundColor = [UIColor clearColor];
////      NSString *filePath = [[NSBundle mainBundle] pathForResource:@"backspace" ofType:@"mov"];
//        NSURL *sourceMovieURL = [self getNetworkUrl];
//        
//        AVAsset *movieAsset = [AVURLAsset URLAssetWithURL:sourceMovieURL options:nil];
//        AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:movieAsset];
//        AVPlayer *player = [AVPlayer playerWithPlayerItem:playerItem];
//        AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
//        playerLayer.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 300);
//        playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
//        
//        playerLayer.backgroundColor =[UIColor cyanColor].CGColor;
//        [self.view.layer addSublayer:playerLayer];  
//        [player play];
//        
//        self.view.frame = CGRectMake(0, -300, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
//        [UIView animateWithDuration:0.3 animations:^{
//            self.view.frame = screenSize;
//        }];
    }
    return self;
}

//-(NSURL *)getNetworkUrl{
//    NSString *urlStr=@"http://v.jxvdy.com/sendfile/w5bgP3A8JgiQQo5l0hvoNGE2H16WbN09X-ONHPq3P3C1BISgf7C-qVs6_c8oaw3zKScO78I--b0BGFBRxlpw13sf2e54QA";
//    urlStr=[urlStr  stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
//    NSURL *url=[NSURL URLWithString:urlStr];
//    return url;
//}
@end
