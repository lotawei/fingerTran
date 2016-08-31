//
//  LLHCateGoryPro.m
//  指尖叫货
//
//  Created by lotawei on 16/6/27.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "LLHCateGoryPro.h"
#import "AllFunction.h"
@implementation LLHCateGoryPro
+(instancetype)categoryWithdic:(NSDictionary *)dic
{
    LLHCateGoryPro   *apro = [[LLHCateGoryPro
                               alloc]init];
    apro.imageUrl =  [NSString stringWithFormat:@"%@%@",[AllFunction BaseUrl], dic[@"ImageUrl"]];
    apro.title = dic[@"Title"];
    apro.total = [dic[@"Total"] integerValue]  ;
    
    return apro;
}
@end
