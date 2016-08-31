//
//  DataService.h
//  指尖叫货
//
//  Created by rimi on 16/6/19.
//  Copyright © 2016年 lw. All rights reserved.
//






#import <Foundation/Foundation.h>

@interface DataService : NSObject

//根据 不同需求  返回不同数据

+(void)getdataService:(NSString*)kindsofdata  andparams:(NSDictionary*)params succeed:(void(^)(id  response)) succeedBlock    failed:(void(^)(id  error))  failedBlock ;



+(void)getLaunchdataService:(NSString*)kindsofdata  andparams:(NSDictionary*)params succeed:(void(^)(id  response)) succeedBlock    failed:(void(^)(id  error))  failedBlock ;
@end
