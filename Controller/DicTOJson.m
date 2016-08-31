//
//  DicTOJson.m
//  指尖叫货
//
//  Created by lotawei on 16/6/26.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "DicTOJson.h"

@implementation DicTOJson
+(NSString *)dictojson:(NSDictionary *)dic
{
    
        
        NSError *parseError = nil;
        
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
        
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    

}
@end
