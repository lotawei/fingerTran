//
//  AppDelegate.m
//  指尖叫货
//
//  Created by rimi on 16/6/19.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "AppDelegate.h"
#import "DataService.h"
#import "AllFunction.h"
#import "LoginViewController.h"
#import "DataService.h"
#import  "CartShopView.h"

#define USERDIC   @"userdic"

@interface AppDelegate ()

@end
//prototalprice  >0
@implementation AppDelegate
-(NSMutableDictionary *)catedic
{
    if (_catedic==nil) {
        
        _catedic = [NSMutableDictionary  dictionary];
    }
    return _catedic;
}
-(CartShopView *)shopview
{
    if (_shopview==nil) {
        _shopview =  [[[NSBundle  mainBundle]loadNibNamed:@"CartShopView" owner:nil options:nil] firstObject];
        _shopview.alpha = 1 ;
        [_shopview setFrame:CGRectMake(20, 590, 60, 60)];
        _shopview.backgroundColor = [UIColor colorWithRed:0.2f green:0.55f blue:1.0f alpha:1];
        self.original  = _shopview.frame;
        
    }
    return _shopview ;
}
-(LLHUser *)auser
{
    if (_auser == nil) {
        _auser =  [[LLHUser  alloc]init];
       
        _auser.isOnline = NO;
       
      
      
    }
    return _auser;
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
     //存入字典记录登录用户情况
    NSDictionary   *userdic = [[NSUserDefaults  standardUserDefaults]objectForKey:USERDIC];
    
   
    
    
    //没有用户登录过
    if (userdic==nil) {
        UIStoryboard   *strory = [UIStoryboard   storyboardWithName:@"Main" bundle:nil];
                  UINavigationController  *index = [strory  instantiateViewControllerWithIdentifier:@"RootViewController"];
                  self.window.rootViewController = index;
                  [index  pushViewController:[[LoginViewController alloc]init] animated:YES];
                  [self.window  makeKeyAndVisible];
     }
    else
    {
        self.auser.loginName = userdic[@"loginname"];
        self.auser.isOnline = userdic[@"islogin"];
        self.auser.coustomerId = userdic[@"coustomerId"];
    }
    
    
    
  
    
    
   
    
    
    return YES;
}







@end
