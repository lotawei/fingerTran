//
//  RegistSucceedViewController.m
//  指尖叫货
//
//  Created by rimi on 16/6/20.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "RegistSucceedViewController.h"
#import "LoginViewController.h"
#import "DataService.h"
#import "AllFunction.h"
#import "AppDelegate.h"
#import "LoginViewController.h"

@interface RegistSucceedViewController ()
{
    NSTimer   *curtime;
    int seconds;
}

@property (nonatomic,strong)UILabel *labelSucceed;
@property(nonatomic,strong)UIButton *immediatelyLogin;
@property(nonatomic,strong) UILabel   *txtlab ;

@end

@implementation RegistSucceedViewController
-(UILabel *)labelSucceed
{
    if (_labelSucceed==nil) {
        _labelSucceed = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMidX(self.view.frame)-150, 150, 300, 100)];
        _labelSucceed.text = @"恭喜你，注册成功!";
        _labelSucceed.textAlignment = NSTextAlignmentCenter;
        _labelSucceed.font = [UIFont systemFontOfSize:27];
        
       
    }
    return _labelSucceed;

}

-(UIButton *)immediatelyLogin
{
    if (_immediatelyLogin==nil) {
        _immediatelyLogin = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMidX(self.view.frame)-105, 290, 210, 50)];
        [_immediatelyLogin setTitle:@"马上登录" forState:UIControlStateNormal];
        _immediatelyLogin.backgroundColor = [UIColor blueColor];
        _immediatelyLogin.tintColor = [UIColor whiteColor];
        _immediatelyLogin.layer.cornerRadius = 10;
        
        [_immediatelyLogin addTarget:self action:@selector(gologin) forControlEvents:UIControlEventTouchUpInside];
    }
    return _immediatelyLogin;
   

}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
}
-(UILabel *)txtlab
{
    if (_txtlab==nil) {
          _txtlab  = [[UILabel   alloc]initWithFrame:CGRectMake(CGRectGetMidX(self.view.frame)-75, CGRectGetMaxY(self.immediatelyLogin.frame), 150, 40)];
          _txtlab.text = @"5秒后自动跳转" ;
            _txtlab.textAlignment = NSTextAlignmentCenter;
    }
    return _txtlab;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //navigation的返回键，只想保留箭头
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                         forBarMetrics:UIBarMetricsDefault];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.immediatelyLogin];
   
    
    
    
    [self.view addSubview:self.labelSucceed];
    
    
    [self.view  addSubview:self.txtlab];
    //启动倒计时
    seconds = 5;//5秒倒计时
    //开始倒计时
    curtime = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
    
    
}
-(void)timeFireMethod{
    //倒计时-1
    seconds--;
    //修改倒计时标签现实内容
    self.txtlab.text=[NSString stringWithFormat:@"%d秒自动跳转",seconds];
    //当倒计时到0时，做需要的操作，比如验证码过期不能提交
    if(seconds==0){
        [curtime invalidate];
        [self.txtlab removeFromSuperview];
        self.navigationController.navigationBar.hidden = NO;
    
       [self.navigationController popToRootViewControllerAnimated:YES];

    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
-(void)gologin
{
       [curtime invalidate];
    self.navigationController.navigationBar.hidden = NO;
    
    
//     NSDictionary  *params  = [NSDictionary  dictionaryWithObjects:@[name,pwd,email] forKeys:@[@"LoginName",@"Password",@"Email"]];
    NSDictionary  *autodic =      [[NSUserDefaults  standardUserDefaults ] objectForKey:@"autologin"];
    NSString   *name   = autodic[@"LoginName"];
    NSString   *pwd = autodic[@"Password"];
    
    
    NSDictionary  *params  = [NSDictionary  dictionaryWithObjects:@[name,pwd] forKeys:@[@"LoginName",@"Password"]];
    [DataService  getdataService:[AllFunction Login ] andparams:params succeed:^(id response) {
        if ([response[@"statusCode"]
                                  integerValue]==1) {
             
             
                                 AppDelegate  *appdelagate  = [UIApplication sharedApplication].delegate;
             
                                 NSString *customerId = response[@"data"][0][@"Id"];
                                 NSLog(@"%@",customerId);
                                 appdelagate.auser.loginName = name;
                                 appdelagate.auser.isOnline = YES;
             
                                 NSDictionary  *userdic = [NSDictionary dictionaryWithObjects:@[name,@YES,customerId] forKeys:@[@"loginname",@"islogin",@"coustomerId"]];
                                 [[NSUserDefaults  standardUserDefaults]setObject:userdic forKey:@"userdic"];
             
                                 appdelagate.auser.coustomerId  = customerId;
                                 
                                 

            [self.navigationController popToRootViewControllerAnimated:YES];
            [self.navigationController  pushViewController:[[LoginViewController alloc]init] animated:YES];
        }
        else
        {
            UIAlertController  *con = [UIAlertController alertControllerWithTitle:@"登录失败" message:nil
                                                                   preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction   *cancle  = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            [con addAction:cancle];
            [self presentViewController:con animated:YES completion:nil];
        }


    } failed:^(id error) {
        
    }];
//
//
//        [DataService  getdataService:[AllFunction  Login] andparams:params succeed:^(id response) {
//            [SVProgressHUD  show];
//         
//                if ([response[@"statusCode"]
//                     integerValue]==1) {
//                    
//                    
//                    AppDelegate  *appdelagate  = [UIApplication sharedApplication].delegate;
//                    
//                    NSString *customerId = response[@"data"][0][@"Id"];
//                    NSLog(@"%@",customerId);
//                    appdelagate.auser.loginName = name;
//                    appdelagate.auser.isOnline = YES;
//                    
//                    NSDictionary  *userdic = [NSDictionary dictionaryWithObjects:@[name,@YES,customerId] forKeys:@[@"loginname",@"islogin",@"coustomerId"]];
//                    [[NSUserDefaults  standardUserDefaults]setObject:userdic forKey:@"userdic"];
//                    
//                    appdelagate.auser.coustomerId  = customerId;
//                    
//                    
//                    [self.navigationController popToRootViewControllerAnimated:YES];
//                }
//        
    
    
    

}

@end
