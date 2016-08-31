//
//  RegisterViewController.m
//  指尖叫货
//
//  Created by rimi on 16/6/20.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "RegisterViewController.h"
#import "RegistSucceedViewController.h"
#import "DataService.h"
#import "CheckRegsiter.h"
#import "AllFunction.h"
#import "NSString+Md5.h"
#define TextFieldGap   (30.f)
#define TextFieldWidth      (357.f)
#define TextFieldHeight   (55.f)
#define TextFieldX (9.f)
#define ButtonGap (52.f)
#define ButtonX (71.f)
#define NavibarPad (60.f)



@interface RegisterViewController ()<UITextFieldDelegate>

@property(nonatomic,strong) UITextField *account;

@property(nonatomic,strong) UITextField *password;

@property(nonatomic,strong) UITextField *confirmPassword;

@property(nonatomic,strong) UITextField *email;

@property(nonatomic,strong) UITextField *salesmanID;





@property (nonatomic, strong) UIButton *confirmRegister;


@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //navigation的返回键，只想保留箭头
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                         forBarMetrics:UIBarMetricsDefault];
    
    _account = [[UITextField alloc]initWithFrame:CGRectMake(TextFieldX, TextFieldGap + NavibarPad, TextFieldWidth, TextFieldHeight)];
    _password = [[UITextField alloc]initWithFrame:CGRectMake(TextFieldX, 2*TextFieldGap+TextFieldHeight + NavibarPad, TextFieldWidth, TextFieldHeight)];
    _confirmPassword = [[UITextField alloc]initWithFrame:CGRectMake(TextFieldX, 3*TextFieldGap+2*TextFieldHeight + NavibarPad, TextFieldWidth, TextFieldHeight)];
    _email = [[UITextField alloc]initWithFrame:CGRectMake(TextFieldX, 4*TextFieldGap+3*TextFieldHeight + NavibarPad, TextFieldWidth, TextFieldHeight)];
    _salesmanID = [[UITextField alloc]initWithFrame:CGRectMake(TextFieldX, 5*TextFieldGap+4*TextFieldHeight + NavibarPad, TextFieldWidth, TextFieldHeight)];
    _email.tag = 1005;
    
    
    _confirmRegister = [[UIButton alloc]initWithFrame:CGRectMake(ButtonX, 5*TextFieldGap+5*TextFieldHeight+ButtonGap + NavibarPad, 233,50 )];
    _confirmRegister.layer.cornerRadius = 5.0;
    
//
//    _confirmRegister.titleLabel.text = @"确认注册";
    
    [_confirmRegister setTitle:@"确认注册" forState:UIControlStateNormal];
    
    _confirmRegister.backgroundColor = [UIColor blueColor];
    
    [_confirmRegister addTarget:self action:@selector(registeruser) forControlEvents:UIControlEventTouchUpInside];
    
    
    _account.borderStyle = UITextBorderStyleRoundedRect;
    _password.borderStyle = UITextBorderStyleRoundedRect;
    _confirmPassword.borderStyle = UITextBorderStyleRoundedRect;
    _email.borderStyle = UITextBorderStyleRoundedRect;
    _salesmanID.borderStyle = UITextBorderStyleRoundedRect;
    
    _salesmanID.tag = 1000;
    
//    _account.backgroundColor = [UIColor ];
    
    [self.view addSubview:_account];
    
    [self.view addSubview:_password];
    
    [self.view addSubview:_confirmPassword];
    
    [self.view addSubview:_email];
    
    [self.view  addSubview: _salesmanID];
    
    [self.view addSubview:_confirmRegister];
    

    
    _account.delegate = self;
    _password.delegate = self;
    _confirmPassword.delegate = self;
    _email.delegate = self;
    _salesmanID.delegate = self;
    
    
    UILabel *accountLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 26)];
    accountLabel.text = @"   账    号：";
    
    _account.leftViewMode = UITextFieldViewModeAlways;
    _account.leftView = accountLabel;
    _account.autocapitalizationType = UITextAutocapitalizationTypeWords;
    
    UILabel *passwordLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 26)];
    passwordLabel.text = @"   输入密码：";
    
    _password.leftViewMode = UITextFieldViewModeAlways;
    _password.leftView = passwordLabel;
    
    
    UILabel *confrimPasswordLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 26)];
    confrimPasswordLabel.text = @"   确认密码：";
    
    _confirmPassword.leftViewMode = UITextFieldViewModeAlways;
    _confirmPassword.leftView = confrimPasswordLabel;
    
    
    UILabel *emailLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 26)];
    emailLabel.text = @"   邮    箱：";
    
    _email.leftViewMode = UITextFieldViewModeAlways;
    _email.leftView = emailLabel;
    
    
    UILabel *salesmanLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 26)];
    salesmanLabel.text = @"   业务员ID：";
    
    _salesmanID.leftViewMode = UITextFieldViewModeAlways;
    _salesmanID.leftView = salesmanLabel;
    
    
        
    
    //输入控制与键盘动画
    //1.长度
   
    //2.加密
    _password.secureTextEntry = YES;
    _confirmPassword.secureTextEntry = YES;
    //3.清空
    //4.过滤无效字符
}



-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if (textField.tag == 1000) {
        [UIView animateWithDuration:0.4 animations:^{
            self.view.center = CGPointMake(self.view.center.x, self.view.center.y+100);
        }];
        return  YES;
    }
    else{
        return YES;
    }
        
   
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField;
{
   if (textField.tag == 1000) {
    [UIView animateWithDuration:0.4 animations:^{
        self.view.center = CGPointMake(self.view.center.x, self.view.center.y-100);
    }];
    return  YES;
   }
    else{
        return YES;
    }
}

//4.过滤无效字符
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.tag == 1005) {
        return YES;
    }
    if (range.location >12) {
        //如果文本长度大于12   则不允许文本输入
        
        return NO;
    }
    if (string.length == 0) {
        return  YES;
    }
    if (![@"qwertyuiopasdfghjklzxcvbnm0123456789_" containsString:[string lowercaseString]]) {
        return NO;
    }
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [UIView animateWithDuration:0.4 animations:^{
        textField.center = CGPointMake(textField.center.x, textField.center.y);
    }];
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void)shakeviewforview:(UIView*)view
{
    CATransform3D transform;
    if (arc4random() % 2 == 1)//这是为了让不同的View对象向左或向右转动
        transform = CATransform3DMakeRotation(-0.08, 0, 0, 3.0);
    else
        transform = CATransform3DMakeRotation(0.08, 0, 0, 3.0);      CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.toValue = [NSValue valueWithCATransform3D:transform];
    animation.autoreverses = YES;
    animation.duration = 0.1;   //间隔时间
    animation.repeatCount = 3;   //重复的次数
    animation.delegate = self;
    [view.layer addAnimation:animation forKey:@"wiggleAnimation"];
}


-(void)registeruser

{
    //经过验证
//    [CheckRegsiter passincorrect:self.password.text andps2:self.confirmPassword.text]
    if (![CheckRegsiter checkuser:self.account.text]) {
        [self  shakeviewforview:self.account];
        return ;
    }
    if (![CheckRegsiter passincorrect:self.password.text andps2:self.confirmPassword.text]) {
        [self  shakeviewforview:self.password];
        [self  shakeviewforview:self.confirmPassword];
        return ;
    }
    if (![CheckRegsiter  isValidateEmail:self.email.text]) {
        [self  shakeviewforview:self.email];
        return ;
    }
    
   
    
    else
    {
        NSString   *name = self.account.text;
        
        NSString   *pwd  = [self.password.text md5Encrypt] ;
        
        
        NSString   *email = self.email.text ;
      
        NSDictionary  *params  = [NSDictionary  dictionaryWithObjects:@[name,pwd,email] forKeys:@[@"LoginName",@"Password",@"Email"]];
        dispatch_queue_t  aq = dispatch_queue_create("aq",  DISPATCH_QUEUE_CONCURRENT);
        dispatch_async(aq, ^{
            [DataService  getdataService:[AllFunction  Register] andparams:params succeed:^(id response) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if ([response[@"statusMessage"]
                         isEqualToString:@"添加成功"]) {
                        
                        [self.navigationController  pushViewController:[[RegistSucceedViewController alloc]init] animated:YES];
                        
                        
                        [[NSUserDefaults  standardUserDefaults]setObject:params forKey:@"autologin"];
                    }
                    else
                    {
                        UIAlertController  *con = [UIAlertController alertControllerWithTitle:@"注册失败" message:nil
                                                                               preferredStyle:UIAlertControllerStyleAlert];
                        UIAlertAction   *cancle  = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
                        [con addAction:cancle];
                        [self presentViewController:con animated:YES completion:nil];
                    }

                });
                
                
            } failed:^(id error) {
                 dispatch_async(dispatch_get_main_queue(), ^{
                     
                     UIAlertController  *con = [UIAlertController alertControllerWithTitle:error message:nil
                                                                            preferredStyle:UIAlertControllerStyleAlert];
                     UIAlertAction   *cancle  = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
                     [con addAction:cancle];
                     [self presentViewController:con animated:YES completion:nil];
                     
                     
                 });
            }];
            

        });
        
    }
    
  
    
    
}

@end
