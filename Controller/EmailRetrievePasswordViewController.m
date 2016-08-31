//
//  EmailRetrievePasswordViewController.m
//  指尖叫货
//
//  Created by rimi on 16/6/20.
//  Copyright © 2016年 lw. All rights reserved.
//


#define NavigetionBarHeight (60.f)

#define TextFieldNavigetionGap (48.f)
#define TextFieldX (30.f)
#define TextFieldHeight (50.f)

#define ButtonX (30.f)
#define ButtonGap (50.f)

#import "EmailRetrievePasswordViewController.h"

@interface EmailRetrievePasswordViewController ()<UITextFieldDelegate>
@property(nonatomic,strong)UITextField *emailTextFeild;
@property(nonatomic,strong)UIButton *commitButton;

@end

@implementation EmailRetrievePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //navigation的返回键，只想保留箭头
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                         forBarMetrics:UIBarMetricsDefault];
    
    _emailTextFeild = [[UITextField alloc]initWithFrame:CGRectMake(TextFieldX, TextFieldNavigetionGap+NavigetionBarHeight, 375-2*TextFieldX, TextFieldHeight)];
    
    
    UILabel *emailLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 26)];
    emailLabel.text = @"   请输入邮箱：";
    
    _emailTextFeild.leftViewMode = UITextFieldViewModeAlways;
    _emailTextFeild.leftView = emailLabel;
    _emailTextFeild.borderStyle = UITextBorderStyleRoundedRect;
    _emailTextFeild.delegate = self;
    
    
    
    
    
    _commitButton = [[UIButton alloc]initWithFrame:CGRectMake(375-ButtonX-80, NavigetionBarHeight+TextFieldNavigetionGap+TextFieldHeight+ButtonGap, 80, 50)];
    [_commitButton setTitle:@"提交" forState:UIControlStateNormal];
    _commitButton.backgroundColor = [UIColor blueColor];
    _commitButton.tintColor = [UIColor whiteColor];
    _commitButton.layer.cornerRadius = 7;
    [self.view addSubview:_commitButton];
    [self.view addSubview:_emailTextFeild];
    
    
}



-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
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

@end
