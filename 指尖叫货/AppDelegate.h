//
//  AppDelegate.h
//  指尖叫货
//
//  Created by rimi on 16/6/19.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLHUser.h"
#import "CartShopView.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

//用于全局获取用户是否在线登录情况
@property(nonatomic,strong) LLHUser   *auser;
@property (strong, nonatomic) UIWindow *window;


//商品编号
@property(strong,nonatomic)  NSString   *goodscode;

//传分类
@property(strong,nonatomic)  NSMutableDictionary   *catedic ;
//传显示位置
@property(nonatomic)   NSInteger     pos ;

@property(nonatomic)   CGRect     original;

@property(nonatomic,strong)NSString *oneLevelTitle;

@property  (nonatomic,strong) CartShopView   *shopview;



@end

