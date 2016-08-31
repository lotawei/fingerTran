//
//  EmailSendViewController.m
//  指尖叫货
//
//  Created by rimi on 16/6/20.
//  Copyright © 2016年 lw. All rights reserved.
//

#define NavigetionBarHeight (60.f)

#define ImageViewNavigetionGap (30.f)
#define ImageViewX (153.f)
#define ImageViewHeight (50.f)


#define LabelImageViewGap (50.f)
#define LabelX (60.f)
#define LabelHeight (31.f)

#define ButtonX (30.f)
#define ButtonGap (80.f)
#define ButtonHeight (50.f)

#import "EmailSendViewController.h"



@interface EmailSendViewController ()
@property (nonatomic,strong)UIImageView *imageSend;
@property (nonatomic,strong)UILabel *labelSend;
@property(nonatomic,strong)UIButton *buttonConfirmChange;


@end

@implementation EmailSendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //navigation的返回键，只想保留箭头
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                         forBarMetrics:UIBarMetricsDefault];
    
    self.view.backgroundColor = [UIColor whiteColor];
    _imageSend = [[UIImageView alloc]initWithFrame:CGRectMake(ImageViewX, NavigetionBarHeight+ImageViewNavigetionGap, 375-2*ImageViewX, ImageViewHeight)];
    
    _imageSend.image = [UIImage imageNamed:@"信@2x.png"];
    
    
    _labelSend = [[UILabel alloc]initWithFrame:CGRectMake(LabelX, NavigetionBarHeight+ImageViewNavigetionGap+ImageViewHeight+LabelImageViewGap, 375-2*LabelX, LabelHeight)];
    
    _labelSend.text = @"找回密码邮件已发送至你的邮箱";
    
    
    
    _buttonConfirmChange = [[UIButton alloc]initWithFrame:CGRectMake(ButtonX, NavigetionBarHeight+ImageViewNavigetionGap+ImageViewHeight+LabelImageViewGap+ButtonGap+LabelHeight, 375-2*ButtonX, ButtonHeight)];
    
    [_buttonConfirmChange setBackgroundImage:[UIImage imageNamed:@"修改密码@2x.png"] forState:UIControlStateNormal];
    
    
    [self.view addSubview:_imageSend];
    [self.view addSubview:_labelSend];
    [self.view addSubview:_buttonConfirmChange];
    
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
