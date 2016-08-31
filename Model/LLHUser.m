//
//  LLHUser.m
//  指尖叫货
//
//  Created by lotawei on 16/6/19.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "LLHUser.h"
#import "NSString+Md5.h"
@implementation LLHUser


-(NSMutableArray *)scanproducts
{
    if (_scanproducts==nil) {
        _scanproducts = [NSMutableArray  arrayWithCapacity:0];
        
    }
    return _scanproducts;
}

-(NSMutableArray *)orderproducts
{
    if (_orderproducts==nil) {
        _orderproducts = [NSMutableArray  arrayWithCapacity:0];
        
    }
    return _orderproducts;
}
-(void)setPassword:(NSString *)password
{
    
    
    self.password = [password  md5Encrypt];
}
+(instancetype)userWithDic:(NSDictionary *)dic
{
    LLHUser   *auser = [[LLHUser  alloc]init];
    auser.loginName = dic[@"LoginName"];
    auser.password = dic [@"Password"];
    return auser;
}

-(void)addOrderPro:(LLHProdoct *)apro
{
    if (apro.procount<=0) {
        return  ;
        
    }
    for (LLHProdoct  *apr in self.orderproducts) {
        if ([apr.goodsCode isEqualToString:apro.goodsCode]&&apr.procount>0) {
            apr.procount = apro.procount;
            return  ;
        }
        
    }
    [self.orderproducts addObject:apro];
    
}
-(void)deletePro:(LLHProdoct *)apro
{
    for (LLHProdoct  *apr in self.orderproducts) {
    if ([apr.goodsCode isEqualToString:apro.goodsCode]||apr.procount<=0) {
          [self.orderproducts  removeObject:apr];
         return  ;
        }
     }
    
    

}
-(double)orderprice
{
    double    result =  0 ;
    for (LLHProdoct  *apr in self.orderproducts) {
        result += apr.procount  * apr.price  ;
    }
    
    return result ;
}

//商品个数统计
-(NSInteger)ordercount
{
    NSInteger    result =  0 ;
    for (LLHProdoct  *apr in self.orderproducts) {
        result += apr.procount ;
    }
    return result ;
}
-(void)changcount:(NSArray *)products
{
    
    if (products&&products.count>0) {
        for (LLHProdoct *pro  in products) {
            for (LLHProdoct *oder in self.orderproducts)
            {
                 if([pro.goodsCode isEqualToString:oder.goodsCode])
                 {
                     pro.procount = oder.procount;
                 }
            }
        }
        
    }
}
-(void)addScanPro:(LLHProdoct *)apro
{
    
    
    for (LLHProdoct  *apr in self.scanproducts) {
        if ([apr.goodsCode isEqualToString:apro.goodsCode]) {
            
            return  ;
        }
        
        
        
    }
    
    
    [self.scanproducts addObject:apro];
    
}

-(void)deleteScanPro:(LLHProdoct *)apro
{
    for (LLHProdoct  *apr in self.scanproducts) {
        if ([apr.goodsCode isEqualToString:apro.goodsCode]) {
            [self.scanproducts  removeObject:apr];
            return  ;
        }
    }
}

@end
