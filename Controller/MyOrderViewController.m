//
//  MyOrderViewController.m
//  指尖叫货
//
//  Created by rimi on 16/6/22.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "MyOrderViewController.h"
#import "SlideHeadView.h"
#import "OrderListViewController.h"


@interface MyOrderViewController ()

@end

@implementation MyOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    //navigation的返回键，只想保留箭头
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                         forBarMetrics:UIBarMetricsDefault];
    SlideHeadView *slideVC = [[SlideHeadView alloc]init];
    [self.view addSubview:slideVC];
    
    
    
    OrderListViewController *firstVC = [[OrderListViewController alloc]init];
   OrderListViewController  *secondVC = [[OrderListViewController alloc]init];
    OrderListViewController *threeVC = [[OrderListViewController alloc]init];
    
    firstVC.status = @"0";
    secondVC.status = @"1";
    threeVC.status = @"-1";
    
    NSArray *titleArr = @[@"已下单",@"已完成",@"已取消"];
    slideVC.titlesArr = titleArr;
    
    [slideVC addChildViewController:firstVC title:titleArr[0]];
    [slideVC addChildViewController:secondVC title:titleArr[1]];
    [slideVC addChildViewController:threeVC title:titleArr[2]];

     [slideVC setSlideHeadView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
