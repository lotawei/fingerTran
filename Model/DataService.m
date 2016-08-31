//
//  DataService.m
//  指尖叫货
//
//  Created by rimi on 16/6/19.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "DataService.h"
#import  "AFHTTPSessionManager.h"
#import "AllFunction.h"
@implementation DataService

+(void)getdataService:(NSString*)kindsofdata  andparams:(NSDictionary*)params succeed:(void(^)(id  response)) succeedBlock    failed:(void(^)(id  error))  failedBlock
{
    
    AFHTTPSessionManager  *amanager = [[AFHTTPSessionManager  alloc]init];
    
    amanager.responseSerializer.acceptableContentTypes = [[NSSet  alloc]initWithObjects:@"text/html",@"application/json" ,nil];
    
   
    [amanager POST: [[AllFunction BaseUrl] stringByAppendingString:kindsofdata] parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        succeedBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failedBlock(error);
    }];
    
   
}

+(void)getLaunchdataService:(NSString*)kindsofdata  andparams:(NSDictionary*)params succeed:(void(^)(id  response)) succeedBlock    failed:(void(^)(id  error))  failedBlock
{
    
    AFHTTPSessionManager  *amanager = [[AFHTTPSessionManager  alloc]init];
    
    amanager.responseSerializer.acceptableContentTypes = [[NSSet  alloc]initWithObjects:@"text/html",@"application/json" ,nil];
    
    
    [amanager POST: [[AllFunction AddressUrl] stringByAppendingString:kindsofdata] parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        succeedBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failedBlock(error);
    }];
    
    
}







@end
