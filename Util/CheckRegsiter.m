//
//  CheckRegsiter.m
//  指尖叫货
//
//  Created by rimi on 16/6/21.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "CheckRegsiter.h"

@implementation CheckRegsiter
+(BOOL)isValidateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
+(BOOL)passincorrect:(NSString*)ps1 andps2:(NSString*)ps2
{
    if (ps2.length==0||ps1.length==0) {
        return NO;
    }
    return [ps1  isEqualToString:ps2] ;
}
+(BOOL)checkuser:(NSString *)username
{
    return username.length>0 ? YES:NO;
}

@end
