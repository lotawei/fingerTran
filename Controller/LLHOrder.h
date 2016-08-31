//
//  LLHOrder.h
//  指尖叫货
//
//  Created by rimi on 16/6/27.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LLHGoodsList.h"
#import "LLHAddress.h"


@interface LLHOrder : NSObject

@property(nonatomic,strong) NSString *addDate;
//   AddressDetail = Ttyugvbhnjklhjl;
@property(nonatomic,strong) NSString *amount;
//   CityName = sfasdfa;
@property(nonatomic,strong) NSString *customerId;
@property(nonatomic,strong) NSString *customerName;
//   EndTime = "00:00:00";
@property(nonatomic) NSInteger freightPrice;

@property(nonatomic) NSInteger isSalemanOrder;
//   Mobile = 35312123;
@property(nonatomic,strong) NSString *orderId;
//   ProvinceName = Albacete;
@property(nonatomic,strong) NSString *remark;
//   Rest = 0;
@property(nonatomic,strong) NSString *salemanId;
@property(nonatomic,strong) NSString *salemanName;
//   ShopName = "";
//   StartTime = "00:00:00";
@property(nonatomic,strong) NSString *status;
//   Weixin = "";
//   Zip = "";
@property(nonatomic,strong) NSMutableArray  *goodList;
//@property(nonatomic,strong) LLHAddress *address;



+(instancetype)orderWithdic:(NSDictionary *)dic;
-(NSString *)description;
@end
