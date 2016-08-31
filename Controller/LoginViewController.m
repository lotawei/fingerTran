//
//  LoginViewController.m
//  指尖叫货
//
//  Created by rimi on 16/6/20.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "LoginViewController.h"
#import "LLHAnimaTextField.h"
#import "RegisterViewController.h"
#import "ChangePasswordViewController.h"
#import "DataService.h"
#import "NSString+Md5.h"
#import "AllFunction.h"
#import "MineViewController.h"
#import "SVProgressHUD.h"
#import "CartShopView.h"

#import "AppDelegate.h"
@interface LoginViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) CAShapeLayer *layer;

@property (nonatomic, strong)   LLHAnimaTextField *usernameTF;
@property (nonatomic, strong)   LLHAnimaTextField *passwordTF;
@end

@implementation LoginViewController
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view  endEditing:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    AppDelegate   *app= [UIApplication sharedApplication].delegate;
    CartShopView   *aview =      [app.window  viewWithTag:1995];
    aview.ordertotal.text = [NSString  stringWithFormat:@"%.2f",app.auser.orderprice];
    
    aview.hidden = YES;
    
  

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor  whiteColor];
    
    //navigation的返回键，只想保留箭头
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                         forBarMetrics:UIBarMetricsDefault];
    self.navigationItem.title =@"登录";
    LLHAnimaTextField *usernameTF = [[LLHAnimaTextField alloc] initWithFrame:CGRectMake(20, 100, self.view.frame.size.width - 40, 70)];
    [usernameTF setPlaceHolderText:@"请输入用户名"];
   
    [self.view addSubview:self.usernameTF = usernameTF];
    
    
    LLHAnimaTextField *passwordTF = [[LLHAnimaTextField alloc] initWithFrame:CGRectMake(20, 200, self.view.frame.size.width - 40, 70)];
    [passwordTF setTipsIcon:[UIImage imageNamed:@"invisible_icon"]];
    [passwordTF setPlaceHolderIcon:[UIImage imageNamed:@"1"]];
    [passwordTF setPlaceHolderText:@"请输入密码"];
    [passwordTF setInputType:XMNAnimTextFieldInputTypePassword];
    [self.view addSubview:self.passwordTF = passwordTF];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"登录" forState:UIControlStateNormal];
    [button sizeToFit];
    [button setBackgroundColor:[UIColor grayColor]];
    button.layer.cornerRadius = 4.0f;
    button.layer.borderWidth = 1.0f;
    [button setFrame:CGRectMake(32, 300, self.view.frame.size.width - 64, 40)];
    [button addTarget:self action:@selector(_loginAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    UIButton *regbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [regbutton setTitle:@"注册用户？" forState:UIControlStateNormal];
    [regbutton sizeToFit];
    [regbutton setBackgroundColor:[UIColor whiteColor]];
    [regbutton setTitleColor:[UIColor  blueColor] forState:UIControlStateNormal];
    [regbutton setFrame:CGRectMake(32, 360, self.view.frame.size.width - 64, 40)];
    [regbutton addTarget:self action:@selector(_regAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:regbutton];
    UIButton *forgetbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [forgetbutton setTitle:@"忘记密码？" forState:UIControlStateNormal];
    [forgetbutton sizeToFit];
    [forgetbutton setBackgroundColor:[UIColor whiteColor]];
    [forgetbutton setTitleColor:[UIColor  blueColor] forState:UIControlStateNormal];
    [forgetbutton setFrame:CGRectMake(32, 420, self.view.frame.size.width - 64, 40)];
    [forgetbutton addTarget:self action:@selector(_resetpassAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetbutton];
    
    // Do any additional setup after loading the view.
}


- (void)_loginAction {
    if (self.usernameTF.text.length == 0 ) {
        self.usernameTF.state = XMNAnimTextFieldStateError;
        return;
    }
    if (self.passwordTF.text.length == 0 ) {
        self.passwordTF.state = XMNAnimTextFieldStateError;
        return;
    }
    self.usernameTF.state = self.passwordTF.state = XMNAnimTextFieldStateNormal;
    NSString   *name = self.usernameTF.text;
    NSString   *pwd = [self.passwordTF.text md5Encrypt] ;
   
    
    NSDictionary  *params  = [NSDictionary  dictionaryWithObjects:@[name,pwd] forKeys:@[@"LoginName",@"Password"]];
   
    
        [DataService  getdataService:[AllFunction  Login] andparams:params succeed:^(id response) {
           
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
                   
                    
//                    appdelagate.auser.coustomerId = response[@"data"][0][@"Id"];
//                    NSLog(@"%@",response[@"data"][0][@"Id"]);
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
           
                
                UIAlertController  *con = [UIAlertController alertControllerWithTitle:error message:nil
                                                                       preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction   *cancle  = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
                [con addAction:cancle];
                [self presentViewController:con animated:YES completion:nil];
                
          
        }];
        
        
  

}
-(void)viewWillDisappear:(BOOL)animated
{
    [SVProgressHUD  dismiss];
}
-(void)_resetpassAction
{
     [self.navigationController  pushViewController:[[ChangePasswordViewController  alloc]init] animated:YES];
}

-(void)_regAction
{
    [self.navigationController  pushViewController:[[RegisterViewController  alloc]init] animated:YES];
}



-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.usernameTF resignFirstResponder];
    return YES;
}


@end
