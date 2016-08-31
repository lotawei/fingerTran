//
//  ShopViewController.h
//  指尖叫货
//
//  Created by rimi on 16/6/25.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLHProdoct.h"
#import "CellProtocol.h"
#import  "OrderDeatilView.h"

@interface ShopViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,CellProtocol>



@property(nonatomic,strong)  UIImageView   *xiadanimg;
@property(nonatomic,strong)  OrderDeatilView   *orderview;
@property(nonatomic,strong)  UITableView   *tableview ;
@property(nonatomic)  NSInteger    yunfei;
@end
