//
//  ViewController.m
//  UIGestureRecognizer
//
//  Created by MacBook on 16/6/2.
//  Copyright © 2016年 MacBook. All rights reserved.
//

#import "ViewController.h"
#import "Constants.h"
#import "RTCellContent.h"
#import "RTTableViewCell.h"
#import "RTGestureRecognizerWindow.h"

static RTGestureRecognizerWindow * window;

@interface ViewController () <UITableViewDataSource,UITableViewDelegate>
{
    /**
     *  tableView
     */
    UITableView *_tableView;
    NSMutableArray *_status;
    NSMutableArray *_statusCells;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addDisplayData];
    [self initData];
    [self addTableView];
}

- (void)addTableView
{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)  style:UITableViewStyleGrouped];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    [self.view addSubview:_tableView];

}

#pragma mark-- 加载数据
- (NSString *)filePath:(NSString *)fileName {
    NSArray *myPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *myDocPath = [myPaths objectAtIndex:0];
    NSString *filePath = [myDocPath stringByAppendingPathComponent:fileName];
    return filePath;
}

- (void)initData{
    NSString *fileName = [self filePath:@"my2.plist"];
    NSArray *array=[[NSArray alloc]initWithContentsOfFile:fileName];
    _status=[[NSMutableArray alloc]init];
    _statusCells=[[NSMutableArray alloc]init];
    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [_status addObject:[RTCellContent statusWithDictionary:obj]];
        RTCellContent *cell=[[RTCellContent alloc]init];
        NSLog(@"%lu",(unsigned long)_status.count);
        [_statusCells addObject:cell];
    }];
}

#pragma mark-- 模拟数据源
- (void)addDisplayData
{
    /**
     *  扩展Cell需修改的地方
     */
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    NSString * user = @"睿泰集团";
    NSString * imageName = @"8";
    NSString * logoImageName = @"logo";
    NSString * movieImageName = @"bof";

    [dic setValue:imageName forKey:@"profileImageUrl"];
    [dic setValue:user forKey:@"userName"];
    [dic setValue:logoImageName forKey:@"logoImageName"];
    [dic setValue:movieImageName forKey:@"movieUrl"];


    NSString* fileName = [self filePath:@"my2.plist"];
    NSMutableArray *array=[[NSMutableArray alloc]initWithContentsOfFile:fileName];
    if (!array.count) {
        NSMutableArray *array = [[NSMutableArray alloc]init];
        [array writeToFile:fileName atomically:YES];
    }
    [array addObject:dic];
    [array writeToFile:fileName atomically:YES];
}

#pragma mark-- 数据源方法
#pragma mark 返回分组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

#pragma mark 返回每组行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _status.count;
}

#pragma mark 返回每行的单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier=@"UITableViewCellIdentifierKey1";
    RTTableViewCell *cell;
    cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell){
        cell=[[RTTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    RTCellContent *status=_status[indexPath.row];
    cell.status=status;

    return cell;
}

#pragma mark-- 代理方法
#pragma mark 重新设置单元格高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

#pragma mark 重写状态样式方法
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

#pragma mark 监听点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    NSInteger value = [[userDef objectForKey:@"touchOnImageViewOrNot"] integerValue];
    /**
     *  获取cell的位置
     */
    CGRect  popoverRect = [tableView convertRect:[tableView rectForRowAtIndexPath:indexPath] toView:[tableView superview]];
    if ((value > 5) && (value < 15)) {
        [self setUserDefZreo];
        window = [[RTGestureRecognizerWindow alloc]initWithFrame:screenSize resourceName:@"8" resourceType:imageResource beginRect:CGRectMake(popoverRect.origin.x+5, popoverRect.origin.y+5, 90, 90)];
        [window show];
    }
    else if ((value > 15) && (value < 25)) {
        [self setUserDefZreo];
        window = [[RTGestureRecognizerWindow alloc]initWithFrame:screenSize resourceName:@"logo" resourceType:imageResource beginRect:CGRectMake(popoverRect.origin.x+100, popoverRect.origin.y, 50, 50)];
        [window show];
    }
    else if ((value > 25) && (value < 35)) {
        [self setUserDefZreo];
//        window = [[RTGestureRecognizerWindow alloc]initWithFrame:screenSize resourceName:@"bof" resourceType:videoResource beginRect:CGRectMake(0,0, 0, 0)];
//        [window show];
    }
    [_tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark 编辑
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"DELETE";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        NSString* fileName = [self filePath:@"my2.plist"];
        NSMutableArray *array=[[NSMutableArray alloc]initWithContentsOfFile:fileName];
        [array removeObjectAtIndex:[indexPath row]];
        [array writeToFile:fileName atomically:YES];
        [_status removeObjectAtIndex:[indexPath row]];
        [tableView deleteRowsAtIndexPaths:@[indexPath]withRowAnimation:UITableViewRowAnimationLeft];
    }
}

#pragma mark-- myFunctions
- (void)setUserDefZreo
{
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    NSInteger a = 0;
    NSNumber * value = [NSNumber numberWithInteger:a];
    [userDef setObject:value forKey:@"touchOnImageViewOrNot"];
    [userDef synchronize];
}

@end
