//
//  LLHAddress.h
//  指尖叫货
//
//  Created by rimi on 16/6/23.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LLHAddress : NSObject

@property(nonatomic) NSInteger addressId;

@property(nonatomic,strong ) NSString *provinceName;
@property(nonatomic,strong) NSString *city;
@property(nonatomic,strong) NSString *name;
@property(nonatomic,strong) NSString *mobile;
@property(nonatomic,strong) NSString *weixin;
@property(nonatomic,strong) NSString *shopName;
@property(nonatomic) BOOL rest;
@property(nonatomic,strong) NSString *startTime;
@property(nonatomic,strong) NSString *endTime;
@property(nonatomic,strong) NSString *addressDetail;
@property(nonatomic,strong) NSString *zip;
@property(nonatomic) BOOL isDefaultAddress;
@property(nonatomic,strong)  NSString   *cnee;
+(instancetype)addrWithdic:(NSDictionary *)dic;
+(NSMutableDictionary*)dicWithAddress:(LLHAddress*)address;
-(NSString *)description;
@end
