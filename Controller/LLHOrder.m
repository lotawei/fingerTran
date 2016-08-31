//
//  LLHOrder.m
//  指尖叫货
//
//  Created by rimi on 16/6/27.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "LLHOrder.h"

@implementation LLHOrder

-(NSString *)description
{
    return [NSString stringWithFormat:@"订单号：%@，下单日期：%@，数量 金额：%@",self.orderId,self.addDate,self.goodList];
}

-(NSMutableArray *)goodList
{
    if (!_goodList) {
        _goodList = [NSMutableArray arrayWithCapacity:0];
    }
    return _goodList;
}

+(instancetype)orderWithdic:(NSDictionary*)dic
{
    LLHOrder *order = [[LLHOrder alloc]init];
    
    order.addDate = dic[@"AddDate"];
    order.amount=dic[@"Amount"];
    order.customerName = dic[@"CustomerName"];
    order.customerId = dic[@"CustomerId"];
    order.freightPrice=[dic[@"FreightPrice"]integerValue];
    
    order.isSalemanOrder = [dic[@"IsSalemanOrder"]integerValue];
    order.orderId = dic[@"OrderId"];
    order.remark = dic[@"Remark"];
    order.salemanId= dic[@"SalemanId"];
    order.salemanName = dic[@"SalemanName"];
    NSLog(@"里面的goodList%@",dic[@"GoodsList"]);
    
    NSArray *goodsArray = [NSArray arrayWithArray:dic[@"GoodsList"]];
    
    NSLog(@"==============goodsArray%@",goodsArray);
    
    
    for (int i =0 ; i< goodsArray.count; i++) {
        NSDictionary *dicGoods = goodsArray[i];
        
        NSLog(@"采购物品  %@",dicGoods);
        order.goodList[i] = [LLHGoodsList goodWithdic:dicGoods];
    }
    
    
//    NSDictionary *dicAddress = @{
//                                 @"Id":@(0),
//                                 @"ProvinceName":dic[@"ProvinceName"],
//                                 @"City":dic[@"City"],
//                                 @"Name" : dic[@"Name"],
//                                 @"Mobile" : dic[@"Mobile"],
//                                 @"Weixin" : dic[@"Weixin"],
//                                 @"ShopName" : dic[@"ShopName"],
//                                 @"Rest" : dic[@"Rest"],
//                                 @"StartTime" : dic[@"StartTime"],
//                                 @"EndTime" : dic[@"EndTime"],
//                                 @"AddressDetail":dic[@"AddressDetail"],
//                                 @"Zip":dic[@"Zip"],
//                                 @"IsDefaultAddress":@"false"
//                        };
//    
//    order.address = [LLHAddress addrWithdic:dicAddress];
    
    return order;
    
    
}




@end
