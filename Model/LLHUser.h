//
//  LLHUser.h
//  指尖叫货
//
//  Created by lotawei on 16/6/19.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LLHProdoct.h"
#import "LLHAddress.h"
@interface LLHUser : NSObject



@property(nonatomic,strong)  NSString  *loginName;

@property(nonatomic,strong)  NSString  *password;
//浏览的商品
@property(nonatomic,strong)  NSMutableArray    *scanproducts;
@property(nonatomic,strong)  NSMutableArray    *orderproducts;
@property(nonatomic,strong)  NSString *coustomerId;







@property(nonatomic)  BOOL  isOnline;
+(instancetype)userWithDic:(NSDictionary *)dic;


-(void)addOrderPro:(LLHProdoct *)apro;

-(void)deletePro:(LLHProdoct *)apro;
//商品 总金额
-(double)orderprice;
//商品个数统计
-(NSInteger)ordercount;
//改变视图的商品显示
-(void)changcount:(NSArray *)products;

-(void)addScanPro:(LLHProdoct *)apro;

-(void)deleteScanPro:(LLHProdoct *)apro;

//总金额

@property(nonatomic)  double   xiandanjine;

//运费

@property(nonatomic)  double   yunfei ;
@end
