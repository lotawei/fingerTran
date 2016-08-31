//
//  LLHCateGoryPro.h
//  指尖叫货
//
//  Created by lotawei on 16/6/27.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  获取分类的 商品信息 展示 只有三个属性的
 */
@interface LLHCateGoryPro : NSObject
@property(nonatomic,strong)  NSString   *imageUrl;
@property(nonatomic,strong)  NSString   *title;
@property(nonatomic)  NSInteger  total;

+(instancetype)categoryWithdic:(NSDictionary*)dic;
@end
