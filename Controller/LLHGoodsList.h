//
//  LLHGoodsList.h
//  指尖叫货
//
//  Created by rimi on 16/6/27.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LLHGoodsList : NSObject

@property(nonatomic,strong) NSString *amount ;
@property(nonatomic,strong)NSString  *barcode;
@property(nonatomic)  NSInteger  discount;
@property(nonatomic)  double  discountprice;
@property(nonatomic,strong) NSString  *goodsCode;
@property(nonatomic) NSInteger goodid;
@property(nonatomic,strong) NSString *orderId;
@property(nonatomic)  NSInteger   package;
@property(nonatomic)  double  price;
@property(nonatomic) NSInteger quantity;
@property(nonatomic,strong) NSString *title;


+(instancetype)goodWithdic:(NSDictionary*)dic;


-(NSString *)description;
@end
