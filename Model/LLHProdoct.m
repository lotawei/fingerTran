//
//  Prodoct.m
//  指尖叫货
//
//  Created by lotawei on 16/6/19.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "LLHProdoct.h"
#import "AllFunction.h"
@implementation LLHProdoct
-(NSString *)description;

{
    return [NSString   stringWithFormat:@"商品编码：%@商品条形码：%@名称：%@分类：%@打包：%ld单价:%f,总价%ld ,折扣:%ld ",self.goodsCode,self.barcode,self.title,self.categoryTitle,self.package,self.price,(long)self.procount,self.discount];
}
+(instancetype)proWithdic:(NSDictionary *)dic
{
    LLHProdoct  *pro = [[LLHProdoct  alloc]init];
    pro.goodsCode = dic[@"GoodsCode"];
    pro.barcode = dic[@"Barcode"];
    pro.imageUrl = [NSString stringWithFormat:@"%@%@",[AllFunction BaseUrl], dic[@"ImageUrl"]];
    pro.categoryTitle = dic[@"CategoryTitle"];
    pro.title = dic[@"Title"];
    pro.remark = dic[@"Remark"];
    pro.reserve = [dic[@"Reserve"] integerValue];
    pro.package = [dic[@"Package"] integerValue];
    pro.pictureList = dic[@"PictureList"];
    pro.price = [dic[@"Price"] doubleValue];
    pro.discount = [dic[@"Discount"] doubleValue];
    pro.discountprice = [dic[@"Discountprice"] doubleValue];
    return pro;
}
+(NSMutableDictionary*)dicWithPro:(LLHProdoct *)apro
{
    
    
    NSMutableDictionary  *dic = [NSMutableDictionary  dictionary];
    
    [dic setObject:apro.goodsCode forKey:@"GoodsCode"];
    NSNumber      *quantity = [NSNumber   numberWithInteger:apro.procount];
        [dic setObject:quantity forKey:@"GoodsQuantity"];
    
    return dic;
    
    
}
@end
