//
//  CheckRegsiter.h
//  指尖叫货
//
//  Created by rimi on 16/6/21.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CheckRegsiter : NSObject
//验证邮箱
+(BOOL)isValidateEmail:(NSString *)email ;

//两次密码正确
+(BOOL)passincorrect:(NSString*)ps1 andps2:(NSString*)ps2;
//验证用户
+(BOOL)checkuser:(NSString*)username;
@end
