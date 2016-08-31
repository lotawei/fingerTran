//
//  LLHAddress.m
//  指尖叫货
//
//  Created by rimi on 16/6/23.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "LLHAddress.h"
#import "AppDelegate.h"
@implementation LLHAddress

-(NSString *)description
{
    return [NSString stringWithFormat:@"地址ID：%ld，省份：%@，城市：%@，收货人姓名：%@，手机号码：%@，微信号：%@，商店名称：%@，送货开始时间：%@，送货结束时间：%@，详细地址：%@，邮编：%@",(long)self.addressId,self.provinceName,self.city,self.name ,self.mobile,self.weixin,self.shopName,self.startTime,self.endTime,self.addressDetail,self.zip ];
}

+(instancetype)addrWithdic:(NSDictionary *)dic
{
    LLHAddress *address = [[LLHAddress alloc]init];
    
    address.addressId = [dic[@"Id"] integerValue];
    address.provinceName = dic[@"ProvinceName"];
    address.cnee = dic[@"CNEE"];
    address.city = dic[@"City"];
    address.name = dic[@"Name"];
    address.mobile = dic[@"Mobile"];
    address.weixin = dic[@ "Weixin"];
    address.shopName = dic[@"ShopName"];
    address.rest = dic[@"Rest"];
    address.startTime = dic[@"StartTime"];
    address.endTime = dic[@"EndTime"];
    address.addressDetail = dic[@"AddressDetail"];
    address.zip = dic[@"Zip"];
    address.isDefaultAddress = dic[@"IsDefaultAddress"];
    
    return address;
}
+(NSMutableDictionary *)dicWithAddress:(LLHAddress *)address
{
    NSMutableDictionary  *mutadic = [NSMutableDictionary  dictionary];
    AppDelegate   *app = [UIApplication   sharedApplication].delegate;
    
    [mutadic setObject:  [NSString   stringWithFormat:@"%ld",  address.addressId ] forKey:@"Id"];
    
    [mutadic setObject:address.provinceName forKey:@"ProvinceName"];
    
    if (address.cnee) {
        [mutadic setObject: address.cnee forKey:@"CNEE"];

    }else
    {
        [mutadic setObject:app.auser.loginName forKey:@"CNEE"];
    }
    if (address.city) {
         [mutadic setObject:address.city  forKey:@"City"];
    }
    else
    {
        [mutadic setObject:@"默认"  forKey:@"City"];

    }
    if (address.name) {
        [mutadic setObject: address.name forKey:@"Name"];

    }
    else
    {
        [mutadic setObject: @"默认" forKey:@"Name"];
    }
    
    if (![address.mobile isEqual:[NSNull  null]]) {
        [mutadic setObject: address.mobile forKey:@"Mobile"];
    }
    else
    {
        [mutadic setObject: @"默认" forKey:@"Mobile"];

    }
    if (![address.weixin isEqual:[NSNull  null]]) {
        [mutadic setObject:address.weixin forKey:@ "Weixin"];
    }
    else
    {
        [mutadic setObject:@"默认" forKey:@ "Weixin"];

    }
    if (![address.shopName  isEqual:[NSNull  null] ]) {
        [mutadic setObject: address.shopName forKey:@"ShopName"];

    }
    else
    {
          [mutadic setObject: @"无" forKey:@"ShopName"];
    }
    
    
    
    
    
    [mutadic setObject:@(address.rest) forKey:@"Rest"];
    [mutadic setObject:address.startTime  forKey:@"StartTime"];
    
    [mutadic setObject: address.endTime forKey:@"EndTime"];
    
    [mutadic setObject:address.addressDetail forKey:@"AddressDetail"];
    
    [mutadic setObject:address.zip forKey:@"Zip"];
    
    [mutadic setObject:@(address.isDefaultAddress) forKey:@"IsDefaultAddress"];
    
  
    
    
    return mutadic;
}



@end
