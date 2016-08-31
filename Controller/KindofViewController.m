//
//  KindofViewController.m
//  指尖叫货
//
//  Created by lotawei on 16/6/27.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "KindofViewController.h"
#import "SlideHeadView.h"
#import "AppDelegate.h"
#import "UIImageView+WebCache.h"
#import "SVProgressHUD.h"
#import "LLHProdoct.h"
#import "LLHCateGoryPro.h"

#import "CateGoryDetailController.h"

@interface KindofViewController ()

@end

@implementation KindofViewController
-(NSMutableArray *)pros
{
    if (_pros==nil) {
            AppDelegate   *app = [UIApplication   sharedApplication].delegate;
        NSArray   *arr =  [app.catedic  objectForKey:  app.catedic.allKeys[0]];
        if (arr==nil) {
            _pros = [NSMutableArray   arrayWithCapacity:0];
            return _pros;
        }
        
        _pros = [NSMutableArray arrayWithArray:arr];
        
    }
    return _pros;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    SlideHeadView *slideVC = [[SlideHeadView alloc]init];
    [self.view addSubview:slideVC];
    
//    
//    OrderListViewController *firstVC = [[OrderListViewController alloc]init];
//    OrderListViewController  *secondVC = [[OrderListViewController alloc]init];
//    OrderListViewController *threeVC = [[OrderListViewController alloc]init];
//    
//    firstVC.status = @"0";
//    secondVC.status = @"1";
//    threeVC.status = @"-1";
//    
//    NSArray *titleArr = @[@"已下单",@"已完成",@"已取消"];
//    slideVC.titlesArr = titleArr;
//    
//    [slideVC addChildViewController:firstVC title:titleArr[0]];
//    [slideVC addChildViewController:secondVC title:titleArr[1]];
//    [slideVC addChildViewController:threeVC title:titleArr[2]];
    
    
    
    CateGoryDetailController   *acontrAll = [[CateGoryDetailController  alloc]init];
    AppDelegate   *app = [UIApplication   sharedApplication].delegate;
    acontrAll.categoryTitle = app.oneLevelTitle;
    
    [slideVC addChildViewController:acontrAll title:@"全部"];
    
    for (int   i = 0 ; i<self.pros.count; i++) {
        CateGoryDetailController   *acontr = [[CateGoryDetailController  alloc]init];
        
        LLHCateGoryPro *categoryPro = self.pros[i];
        NSString *titleString = categoryPro.title;
//        NSLog(@"%@",titleString);
        
        
//        NSLog(@"%ld",i);
        
        acontr.categoryTitle = titleString;
        
        [slideVC addChildViewController:acontr title:titleString];
        
        
    }
    
    [slideVC setSlideHeadView];
    
    
   
    

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
