//
//  CateGoryViewController.h
//  指尖叫货
//
//  Created by rimi on 16/6/22.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShowView.h"

@interface CateGoryViewController : UIViewController
@property(nonatomic,strong) ShowView   *allgoods;
@property(nonatomic,strong) ShowView   *categery;
@property(nonatomic,strong)  ShowView   *newgoods;
@property(nonatomic,strong)  ShowView    *dicountgoods;

@property(nonatomic,strong)NSString *yijiTitile;

@property(nonatomic,strong)  NSMutableArray   *yijiarr;
@property(nonatomic,strong)  NSMutableArray    *products;

@property(nonatomic,strong)   NSMutableDictionary  *muludic;
@property(nonatomic,strong)  UITableView  *tab1;
@property(nonatomic,strong)  UITableView  *tab2;
@end
