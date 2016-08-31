//
//  ChangePasswordViewController.m
//  指尖叫货
//
//  Created by rimi on 16/6/20.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "ChangePasswordViewController.h"

#define LabelX (20.f)
#define LabelNavigetionGap (33.f)
#define LabelHeight (30.f)
#define LabelWidth (80.f)

#define NavigetionBarHeight (60.f)

#define TextFieldNavigetionGap (33.f)
#define TextFieldHeight (30.f)
#define TextFieldWidth (200.f)

#define ButtonX (40.f)
#define ButtonGap (224.f)
#define LabelTextFeildGap (20.f)



@interface ChangePasswordViewController ()<UITextFieldDelegate>

@property(nonatomic,strong)UILabel *accountLabel;
@property(nonatomic,strong)UILabel *oldPasswordLabel;
@property(nonatomic,strong)UILabel *nwPasswordLabel;
@property(nonatomic,strong)UILabel *retypePaswwordLabel;

@property(nonatomic,strong)UITextField *accountTextFeild;
@property(nonatomic,strong)UITextField *oldPasswordTextField;
@property(nonatomic,strong)UITextField *nwPasswordTextField;
@property(nonatomic,strong)UITextField *retypePaswwordTextField;

@property(nonatomic,strong)UIButton *confirmChange;

@end

@implementation ChangePasswordViewController

-(void)regsign
{
    for (UIView *aview   in   self.view.subviews) {
        [aview resignFirstResponder];
    }
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //navigation的返回键，只想保留箭头
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                         forBarMetrics:UIBarMetricsDefault];
    
     UITapGestureRecognizer  *tap  = [[UITapGestureRecognizer  alloc]initWithTarget:self action:@selector(regsign)];
    [self.view  addGestureRecognizer:tap];
    
    NSMutableArray *arrayLabel = [NSMutableArray array];
    NSMutableArray *arrayTextField = [NSMutableArray array];

    self.view.backgroundColor = [UIColor whiteColor];
    
    
    for (int i = 0; i<4; i++) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(LabelX, NavigetionBarHeight+(2*i+1)*LabelNavigetionGap, LabelWidth, LabelHeight)];
        
        
        label.font = [UIFont systemFontOfSize:15];
        [self.view addSubview:label];
        
        [arrayLabel addObject:label];
        
        
        UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(LabelX+LabelWidth+LabelTextFeildGap, (2*i+1)*TextFieldNavigetionGap+NavigetionBarHeight, TextFieldWidth, TextFieldHeight)];
        
        textField.borderStyle = UITextBorderStyleRoundedRect;
        
        textField.delegate =self;
        
        [self.view addSubview:textField];
        
        [arrayTextField addObject:textField];
        
        
    }
    _accountLabel = arrayLabel[0];
    _oldPasswordLabel = arrayLabel[1];
    _nwPasswordLabel = arrayLabel[2];
    _retypePaswwordLabel = arrayLabel[3];
    
    _accountLabel.text = @"用户名：";
    _oldPasswordLabel.text = @"旧密码：";
    _nwPasswordLabel.text = @"新密码：";
    _retypePaswwordLabel.text = @"确认密码：";
    
    
    
    _accountTextFeild = arrayTextField[0];
    _oldPasswordTextField = arrayTextField[1];
    _nwPasswordTextField = arrayTextField[2];
    _retypePaswwordTextField = arrayTextField[3];
    
    _oldPasswordTextField.secureTextEntry = YES;
    _nwPasswordTextField.secureTextEntry = YES;
    _retypePaswwordTextField.secureTextEntry = YES;
    
    _confirmChange = [[UIButton alloc]initWithFrame:CGRectMake(70, 380, 235, 50)];
    [_confirmChange setTitle:@"确认修改" forState:UIControlStateNormal];
    _confirmChange.backgroundColor = [UIColor blueColor];
    _confirmChange.tintColor = [UIColor whiteColor];
    _confirmChange.layer.cornerRadius = 7;
    [self.view addSubview:_confirmChange];
    
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
