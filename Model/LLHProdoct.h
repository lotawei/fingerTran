//
//  Prodoct.h
//  指尖叫货
//
//  Created by lotawei on 16/6/19.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LLHProdoct : NSObject
@property(nonatomic,strong) NSString  *goodsCode;
@property(nonatomic,strong)NSString  *barcode;
@property(nonatomic,strong)NSString  *imageUrl;
@property(nonatomic,strong)NSString  *categoryTitle;
@property(nonatomic,strong) NSString *title;
@property(nonatomic,strong)  NSString  *remark;
//库存
@property(nonatomic)  NSInteger  reserve;

@property(nonatomic)  NSInteger   package;
@property(nonatomic,strong)   NSString *pictureList;
@property(nonatomic)  double  price;
@property(nonatomic)  NSInteger  discount;
@property(nonatomic)  double  discountprice;
@property(nonatomic)  BOOL     isnewgoods;
@property(nonatomic)  NSInteger     procount;

+(instancetype)proWithdic:(NSDictionary*)dic;

+(NSMutableDictionary*)dicWithPro:(LLHProdoct *)apro;
-(NSString *)description;
@end
