//
//  LLHGoodsList.m
//  指尖叫货
//
//  Created by rimi on 16/6/27.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "LLHGoodsList.h"

@implementation LLHGoodsList

-(NSString *)description
{
    return [NSString stringWithFormat:@"数量：%ld，价钱：%@",self.quantity,self.amount];
}

+(instancetype)goodWithdic:(NSDictionary*)dic
{
    LLHGoodsList *goodlist = [[LLHGoodsList alloc]init];
    goodlist.amount = dic [@"Amount"];
    goodlist.barcode = dic[@"Barcode"];
    goodlist.discount = [dic[@"Discount"] integerValue];
    goodlist.discountprice = [dic[@"DiscountPrice"]doubleValue];
    goodlist.goodsCode = dic[@"GoodsCode"];
    
    goodlist.goodid = [dic[@"Id"]integerValue];
    goodlist.orderId = dic[@"OrderId"];
    
    goodlist.package = [dic[@"Package"]integerValue];
    goodlist.price = [dic[@"Price"]doubleValue];
    goodlist.quantity = [dic[@"Quantity"]integerValue];
    goodlist.title= dic[@"Title"];

    
    return goodlist;


}

@end
