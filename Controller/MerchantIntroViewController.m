//
//  MerchantIntroViewController.m
//  指尖叫货
//
//  Created by rimi on 16/6/23.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "MerchantIntroViewController.h"
#import "DataService.h"
#import "AllFunction.h"

@interface MerchantIntroViewController ()

@property (nonatomic,strong)UITextView *intro;

@end

@implementation MerchantIntroViewController

- (void)viewDidLoad {
    [super viewDidLoad];
self.view.backgroundColor =[UIColor whiteColor];
//    self.navigationItem.title = @"商家简介";
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 40)];
    label.text = @"商家简介";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor colorWithRed:0.2f green:0.55f blue:1.0f alpha:1];
    
    self.navigationItem.titleView = label;
    [self.view addSubview:self.intro];
    
    //navigation的返回键，只想保留箭头
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                         forBarMetrics:UIBarMetricsDefault];
    
    //网上获取推荐列表
    
    [DataService  getdataService:[AllFunction GetContent ] andparams:nil  succeed:^(id response) {
        
        self.intro.text =  response[@"data"][0][@"Content"];
    } failed:^(id error) {
        
    }];

    
//    
//    [UIImageView
//    
//     btn ]sizeToFit;
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem  alloc]initWithTitle:@"add" style:0 target:nil action:nil];
    
    
}


-(UITextView *)intro
{
    if (_intro == nil) {
        _intro = [[UITextView alloc]initWithFrame:self.view.frame];
        _intro.editable = NO;
        _intro.scrollEnabled = YES;
        
        _intro.font = [UIFont systemFontOfSize:14];
        
    }
    return _intro;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
