//
//  zuixingonggao.m
//  指尖叫货
//
//  Created by lotawei on 16/6/28.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "zuixingonggaoViewController.h"

@interface zuixingonggaoViewController ()

@end

@implementation zuixingonggaoViewController

-(void)viewWillDisappear:(BOOL)animated
{
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 40)];
    label.text = @"最新公告";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor colorWithRed:0.2f green:0.55f blue:1.0f alpha:1];
    
    self.navigationItem.titleView = label;
    self.view.backgroundColor = [UIColor  whiteColor];
    UITextView   *aview = [[UITextView  alloc]initWithFrame:CGRectMake(0, 0, 375, 200) textContainer:nil];
    aview.editable = NO;
    [aview setFont:[UIFont  systemFontOfSize:20]];
    aview.text =self.text;
    [self.view  addSubview:aview];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
