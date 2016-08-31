//
//  OrderListDetailsViewController.h
//  指尖叫货
//
//  Created by rimi on 16/6/29.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLHOrder.h"
@interface OrderListDetailsViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) IBOutlet UILabel *acount;
@property (strong, nonatomic) IBOutlet UILabel *yunfei;
@property (strong, nonatomic) IBOutlet UILabel *orderid;
@property(nonatomic,strong)  LLHOrder   *orderlist;
@end
