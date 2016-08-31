//
//  ConfirmOrderListViewController.h
//  指尖叫货
//
//  Created by rimi on 16/6/29.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConfirmOrderListViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *lianxiren;
@property (strong, nonatomic) IBOutlet UILabel *tel;
@property (strong, nonatomic) IBOutlet UITextView *address;
- (IBAction)xiugai:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *xiaoji;
@property (strong, nonatomic) IBOutlet UILabel *yunfei;
@property (strong, nonatomic) IBOutlet UILabel *heji;
@property (strong, nonatomic) IBOutlet UITextView *liuyan;
@property (strong, nonatomic) IBOutlet UIButton *xiadan;

@end
