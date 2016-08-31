//
//  MineViewController.m
//  指尖叫货
//
//  Created by rimi on 16/6/20.
//  Copyright © 2016年 lw. All rights reserved.
//

#define ButtonCenterGap (20.f)
#define ButtonWidth (50.f)
#define ButtonHeight (30.f)

#define Hight (120.f)

#define CenterX ((375-2)/2.f)

#define LoginHight (80.f)
#define LoginLabelButtonGap (50.f)
//#define ButtonExitX (100.f)
#define ButtonExitWidth (100.f)
#define ButtonExitHeight (35.f)



#import "MineViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "AddressManageViewController.h"
#import "MyOrderViewController.h"
#import "MerchantIntroViewController.h"
#import "ServiceTelViewController.h"

@interface MineViewController () <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UIButton *backToIndex;
@property (nonatomic,strong)UILabel *mineLabel;
@property (nonatomic,strong)UIButton *registe;
@property (nonatomic,strong)UIButton *login;
@property(nonatomic,strong)UILabel *centerBlank;


@property(nonatomic,strong)UIView *backView;


@property(nonatomic,strong)UILabel *accountLabel;
@property(nonatomic,strong)UIButton *exitLoginButton;


@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSArray *picArray;
@property(nonatomic,strong)NSArray *stringArray;

@end

@implementation MineViewController

-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 200, self.view.bounds.size.width , self.view.bounds.size.height-200 ) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.separatorColor = [UIColor brownColor];
    }
    
    return  _tableView;
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
}
-(void)viewDidLayoutSubviews
{
    

    AppDelegate    *app = [UIApplication  sharedApplication].delegate;
    LLHUser        *auser = app.auser;
    
    self.navigationController.navigationBar.hidden = YES;//隐藏本身的navigationBar
    
    //上半部分
    _backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 375, 200)];
    
    _backView.backgroundColor = [UIColor colorWithRed:0.2f green:0.55f blue:1.0f alpha:1];
    
    
    [self.view addSubview:_backView];
    _backToIndex = [[UIButton alloc]initWithFrame:CGRectMake(10, 20, 40, 40)];
    
    [_backToIndex setBackgroundImage:[UIImage imageNamed:@"返回@2x.png" ]forState:UIControlStateNormal];
    [_backToIndex   addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [_backView addSubview:_backToIndex];
    
    _mineLabel = [[UILabel alloc]initWithFrame:CGRectMake((375-60)/2, 20, 60, 40)];
    _mineLabel.text = @"我的";
    _mineLabel.font = [UIFont systemFontOfSize:22];
    _mineLabel.textColor = [UIColor whiteColor];
    _accountLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, LoginHight, 375-40-40, 40)];
    
    _accountLabel.text = auser.loginName ==  nil ? @"无用户" :auser.loginName;
    _accountLabel.textAlignment = NSTextAlignmentCenter;
    
    _accountLabel.textColor = [UIColor whiteColor];
    
 
    
    
    _exitLoginButton = [[UIButton alloc]initWithFrame:CGRectMake((375-ButtonExitWidth)/2, LoginHight+LoginLabelButtonGap, ButtonExitWidth, ButtonExitHeight)];
    [_exitLoginButton setBackgroundImage:[UIImage imageNamed:@"退出@2x.png"] forState:UIControlStateNormal];
    
    [_backView addSubview:_exitLoginButton];
    //没有登录
    _centerBlank = [[UILabel alloc]initWithFrame:CGRectMake(CenterX, Hight, 2, 30)];
    
    _centerBlank.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_centerBlank];
    
    _registe = [[UIButton alloc]initWithFrame:CGRectMake(CenterX-ButtonCenterGap-ButtonWidth, Hight, ButtonWidth, ButtonHeight)];
    [_registe setTitle:@"注册" forState:UIControlStateNormal];
    _login = [[UIButton alloc]initWithFrame:CGRectMake(CenterX+2+ButtonCenterGap, Hight, ButtonWidth, ButtonHeight)];
    [_login setTitle:@"登录" forState:UIControlStateNormal];
    [_login  addTarget:self action:@selector(gologin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_login];
    [self ifLogin:auser.isOnline];
    
    [self.view addSubview:_registe];
    
    [_registe addTarget:self action:@selector(goreg) forControlEvents:UIControlEventTouchUpInside];
    
    [_backView addSubview:_mineLabel];
    
    
  
    
    [self.view addSubview:self.tableView];
    
    _picArray = @[@"iconfont-dingdan-(1)@2x.png",@"iconfont-dizhi@2x.png",@"iconfont-dianhua@2x.png",@"iconfont-shangjiajieshao@2x.png"];
    _stringArray = @[@"订单",@"收货地址",@"客服电话",@"商家简介"];
    
    
    [_exitLoginButton addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewDidLoad {
    [super viewDidLoad];
     self.navigationItem.title = @"我的";
   
}
-(void)goreg
{
    self.navigationController.navigationBar.hidden = NO;
      RegisterViewController  *reg = [[RegisterViewController  alloc]init];
    [self.navigationController   pushViewController:reg animated:YES];
}
-(void)back:(UIButton*)sender
{
    
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController  popViewControllerAnimated:YES];
    
}

-(void) ifLogin:(BOOL) flag
{
   
    if (flag) {
        //已经登录
        [self   hiddenbtn];
        [_backView addSubview:_accountLabel];
    }
    else{
       
         [self   showbtn];
    }
}
-(void)hiddenbtn
{
    _login.hidden = YES;
    _registe.hidden = YES;
    _centerBlank.hidden = YES;
    
    _exitLoginButton.hidden = NO;
}
-(void)showbtn
{
    _login.hidden = NO;
    _registe.hidden = NO;
   
    _centerBlank.hidden = NO;
    _exitLoginButton.hidden = YES;
}
-(void)logout
{
    
    AppDelegate    *app = [UIApplication  sharedApplication].delegate;

    if (![app.auser.loginName isEqualToString:@"无用户"]) {
        
        NSDictionary  *userdic = [NSDictionary dictionaryWithObjects:@[app.auser.loginName,@NO] forKeys:@[@"loginname",@"islogin"]];
        [[NSUserDefaults  standardUserDefaults]setObject:userdic forKey:@"userdic"];
        
         app.auser.isOnline = NO;
        
        
         [self.view  setNeedsLayout];

    }
   
    
    
    
    [self.view  setNeedsLayout];
}
-(void)gologin
{
    self.navigationController.navigationBar.hidden = NO;
    LoginViewController    *log = [[LoginViewController  alloc]init];
    [self.navigationController   pushViewController:log animated:YES];
 
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 7.f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *dataSourceString = @"cellDataSource";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:dataSourceString];//从缓存中获取与重用
    
    if (! cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:dataSourceString];
    }
    
    cell.imageView.image = [UIImage imageNamed:_picArray[indexPath.section]];
    cell.textLabel.text = _stringArray[indexPath.section];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return  cell;
    
    
}


-(void)alertLogin
{
    UIAlertController  *con = [UIAlertController alertControllerWithTitle:@"请先登录" message:nil
                                                           preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction   *cancle  = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [con addAction:cancle];
    [self presentViewController:con animated:YES completion:nil];



}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate    *app = [UIApplication  sharedApplication].delegate;
    
    
    
    AddressManageViewController *amvc  = [[AddressManageViewController alloc]init];
    MyOrderViewController *movc  = [[MyOrderViewController alloc]init];
    
    MerchantIntroViewController *mivc = [[MerchantIntroViewController alloc]init];
    ServiceTelViewController *stvc = [[ServiceTelViewController alloc]init];
    
    
    switch (indexPath.section) {
        case 0:
            if (app.auser.isOnline == YES) {
                self.navigationController.navigationBar.hidden = NO;
                [self.navigationController pushViewController:movc animated:YES];
            }
            else{
                [self alertLogin];
            }
            break;
            
            
        case 1:
            if (app.auser.isOnline == YES) {
                self.navigationController.navigationBar.hidden = NO;
                [self.navigationController pushViewController:amvc animated:YES];
                
            }
            else{
                [self alertLogin];
            }
            break;
        case 2:
            
            self.navigationController.navigationBar.hidden = NO;
            [self.navigationController pushViewController:stvc animated:YES];
            
            
            break;
        case 3:
            
            self.navigationController.navigationBar.hidden = NO;
            [self.navigationController pushViewController:mivc animated:YES];
            
            
            
            break;
            
    }
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
