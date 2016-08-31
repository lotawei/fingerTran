//
//  ReceiverAddressViewController.m
//  指尖叫货
//
//  Created by rimi on 16/6/21.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "ReceiverAddressViewController.h"
#import "WMCustomDatePicker.h"
#import "UIViewExt.h"
#import "DataService.h"
#import "AllFunction.h"
#import "LLHAddress.h"
#import "AppDelegate.h"
#import "LLHUser.h"

#import "CustomPopOverView.h"

@interface ReceiverAddressViewController ()<UITextFieldDelegate,UIScrollViewDelegate,WMCustomDatePickerDelegate,CustomPopOverViewDelegate,UITextViewDelegate>



@property(nonatomic,strong)UILabel *labelProvince;
@property(nonatomic,strong)UILabel *labelCity;
@property(nonatomic,strong)UILabel *labelDetailAddress;
@property(nonatomic,strong)UILabel *labelConsigneeName;
@property(nonatomic,strong)UILabel *labelWeChatID;
@property(nonatomic,strong)UILabel *labelPhoneNumber;
@property(nonatomic,strong)UILabel *labelStoreName;
@property(nonatomic,strong)UILabel *labelPostcode;
@property(nonatomic,strong)UILabel *labelDeliveryTime;



@property(nonatomic,strong)UILabel *labelRest;
@property(nonatomic,strong)UIButton *buttonRest;



@property(nonatomic,strong)UITextField *textFieldProvince;
@property(nonatomic,strong)UITextField *textFieldCity;
@property(nonatomic,strong)UITextView *textViewDetailAddress;
@property(nonatomic,strong)UITextField *textFieldConsigneeName;
@property(nonatomic,strong)UITextField *textFieldWeChatID;
@property(nonatomic,strong)UITextField *textFieldPhoneNumber;
@property(nonatomic,strong)UITextField *textFieldStoreName;
@property(nonatomic,strong)UITextField *textFieldPostcode;
@property(nonatomic,strong)UITextField *textFieldBegin;
@property(nonatomic,strong)UILabel *labelTo;
@property(nonatomic,strong)UITextField *textFieldEnd;

@property (nonatomic,strong)WMCustomDatePicker *picker;
@property (nonatomic,copy) NSString *beginTimeStr;
@property (nonatomic,copy) NSString *timeStr;

@property(nonatomic,strong)UIView *pickerView;

@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic)BOOL flag;
@property(nonatomic)BOOL isRest;

@property(nonatomic,strong)NSMutableArray *array;

@property(nonatomic,strong)NSMutableArray *provinceArray;

@end

@implementation ReceiverAddressViewController
-(void)regsign
{
    for (UIView *aview   in   self.scrollView.subviews) {
        [aview resignFirstResponder];
    }
    
}

-(void)addNavigationBar
{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 40)];
    label.text = @"收获地址";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor colorWithRed:0.2f green:0.55f blue:1.0f alpha:1];
    
    self.navigationItem.titleView = label;
    
    //添加右边navigation的button
    
    if (self.updateAddress != nil) {
        UIBarButtonItem *barbutton = [[UIBarButtonItem alloc]initWithTitle:@"修改" style:0 target:self action:@selector(updateAddress:)];
        self.navigationItem.rightBarButtonItem = barbutton;
    }
    else{
        UIBarButtonItem *barbutton = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:0 target:self action:@selector(save:)];
        
        self.navigationItem.rightBarButtonItem = barbutton;
    }
    
    
}
    
   
- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer  *tap  = [[UITapGestureRecognizer  alloc]initWithTarget:self action:@selector(regsign)];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addNavigationBar];
    self.scrollView.alwaysBounceVertical = YES;
    [self.view addSubview:self.scrollView];
    [self.scrollView  addGestureRecognizer:tap];
    
    [self.scrollView addSubview:self.labelProvince];
    [self.scrollView addSubview:self.textFieldProvince];
    
    [self.scrollView addSubview:self.labelCity];
    [self.scrollView addSubview:self.textFieldCity];
    
    [self.scrollView addSubview:self.labelDetailAddress];
    [self.scrollView addSubview:self.textViewDetailAddress];
    
    [self.scrollView addSubview:self.labelConsigneeName];
    [self.scrollView addSubview:self.textFieldConsigneeName];
    
    [self.scrollView addSubview:self.labelWeChatID];
    [self.scrollView addSubview:self.textFieldWeChatID];
    
    [self.scrollView addSubview:self.labelPhoneNumber];
    [self.scrollView addSubview:self.textFieldPhoneNumber];
    
    [self.scrollView addSubview:self.labelStoreName];
    [self.scrollView addSubview:self.textFieldStoreName];
    
    [self.scrollView addSubview:self.labelPostcode];
    [self.scrollView addSubview:self.textFieldPostcode];
    
    [self.scrollView addSubview:self.buttonRest];
    [self.scrollView addSubview:self.labelRest];
    
    [self.scrollView addSubview:self.labelDeliveryTime];
    
    [self.scrollView addSubview:self.textFieldBegin];
    [self.scrollView addSubview:self.labelTo];
    [self.scrollView addSubview:self.textFieldEnd];
    
    [self createTimePick];
    [self.view addSubview:self.pickerView];
    
    [self addText];
    [self addMustFillIn];
    
    
    
    [self getProvince];
    
    
    
    [self updateTextFieldFillIn];
    
    
    
    
    
    
}

//修改地址
-(void)updateTextFieldFillIn
{
    if (self.updateAddress != nil) {
        
        NSLog(@"%@",self.updateAddress);
        self.textFieldProvince.text = self.updateAddress.provinceName;
        self.textFieldCity.text = self.updateAddress.city;
        self.textFieldConsigneeName.text = self.updateAddress.name;
        if (![self.updateAddress.weixin isEqual:[NSNull null]]) {
            self.textFieldWeChatID.text = self.updateAddress.weixin;
        }
        
//        self.textFieldWeChatID.text = self.updateAddress.weixin == nil ? @"":self.updateAddress.weixin;
        self.textFieldPhoneNumber.text = self.updateAddress.mobile;
        if (![self.updateAddress.shopName isEqual:[NSNull null]]) {
            self.textFieldStoreName.text = self.updateAddress.shopName;
        }
        
//        self.textFieldStoreName.text = self.updateAddress.shopName;
        if (![self.updateAddress.zip isEqual:[NSNull null]]) {
            self.textFieldPostcode.text = self.updateAddress.zip;

        }
        
        self.textViewDetailAddress.text = self.updateAddress.addressDetail;
        if (self.updateAddress.rest) {
            [_buttonRest setBackgroundImage:[UIImage imageNamed:@"收货地址_10.png"] forState:UIControlStateNormal];
            _isRest = NO;
        }
        else
        {
            [_buttonRest setBackgroundImage:[UIImage imageNamed:@"收货地址_07.png"] forState:UIControlStateNormal];
             _isRest = YES;

        }
        if (![self.updateAddress.startTime isEqual:[NSNull null]]) {
            self.textFieldBegin.text =self.updateAddress.startTime;
        }
        if (![self.updateAddress.endTime isEqual:[NSNull null]]) {
            self.textFieldEnd.text = self.updateAddress.endTime;

        }
        
        
        
    }
}

//添加需要加上＊号的text
-(void)addText
{
    _array = [NSMutableArray array];
    
    [_array addObject:self.textFieldProvince];
    [_array addObject:self.textFieldCity];
    [_array addObject:self.textFieldConsigneeName];
    [_array addObject:self.textFieldPhoneNumber];
    [_array addObject:self.textFieldPostcode];
//    [_array addObject:self.textViewDetailAddress];
    
}


//添加星号
-(void)addMustFillIn
{
    for (UITextField *text in _array) {
        UILabel *label  = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(text.frame)+5, CGRectGetMaxY(text.frame)-30, 15, 30)];
        label.text = @"*";
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor redColor];
        
//        NSLog(@" x = %f",CGRectGetMaxX(text.frame));
//        NSLog(@" y = %f",CGRectGetMaxY(text.frame));
        [self.scrollView addSubview:label];
    }
    
    UILabel *labelView = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.textViewDetailAddress.frame)+5, CGRectGetMaxY(_textViewDetailAddress.frame)-50, 15, 30)];
    labelView.text = @"*";
    labelView.textAlignment = NSTextAlignmentCenter;
    labelView.textColor = [UIColor redColor];
    [self.scrollView addSubview:labelView];
//    NSLog(@" y = %f",CGRectGetMaxY(_textViewDetailAddress.frame));
}

//添加时间选择框
-(void )createTimePick
{
    
    _pickerView = [[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 260)];
    
    _picker = [[WMCustomDatePicker alloc]initWithframe:CGRectMake(0, 40, [UIScreen mainScreen].bounds.size.width, 214) Delegate:self PickerStyle:WMDateStyle_DayHourMinute];
    self.pickerView.backgroundColor = [UIColor colorWithWhite:0.4 alpha:0.8];
    self.picker.backgroundColor = [UIColor colorWithWhite:0.4 alpha:0.8];
    
    _picker.minLimitDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    self.beginTimeStr = [dateFormatter stringFromDate:[NSDate date]];
    self.timeStr = [dateFormatter stringFromDate:_picker.date];
    
    [self.pickerView addSubview:self.picker];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    cancelBtn.frame = CGRectMake(0, 0, 60, 25);
    cancelBtn.backgroundColor = [UIColor clearColor];
    cancelBtn.tag = 105;
    [cancelBtn addTarget:self action:@selector(timePickerBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.pickerView addSubview:cancelBtn];
    
    UIButton *doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [doneBtn setTitle:@"完成" forState:UIControlStateNormal];
    [doneBtn setTitleColor:[UIColor colorWithRed:19/255.0f green:137/255.0f blue:208/255.0f alpha:1] forState:UIControlStateNormal];
    doneBtn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-60, 0, 60, 25);
    doneBtn.backgroundColor = [UIColor clearColor];
    doneBtn.tag = 106;
    [doneBtn addTarget:self action:@selector(timePickerBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.pickerView addSubview:doneBtn];

}
//timepicker click
- (void)timePickerBtnClicked:(UIButton *)btn {
    [UIView animateWithDuration:0.5 animations:^{
        self.pickerView.top = self.view.height;
        
        self.scrollView.center = CGPointMake(self.scrollView.center.x, self.scrollView.center.y+110);
        
        [self.pickerView sendSubviewToBack:self.scrollView];
    }];
    if (btn.tag == 106) {
        if ( _flag ) {
            
            self.textFieldEnd.text = self.timeStr;
        }
        else
        {
            
            self.textFieldBegin.text = self.timeStr;
        }
        
        NSLog(@"selectTime = %@",self.timeStr);
    }
}

//获得省份
-(void)getProvince
{
    
    [DataService getdataService:[AllFunction Province] andparams: nil
                        succeed:^(id response) {
                            NSArray *array  = response[@"data"];
                            
                            _provinceArray = [NSMutableArray array];
                            for (NSDictionary *dic in array) {
                                NSString *string = dic[@"Title"];
                                [_provinceArray addObject:string];
                            }
//                            NSLog(@"%@",_provinceArray);
    } failed:^(id error) {
        
    }];
}


//保存地址
-(void)save:(UIBarButtonItem *)sender
{
    
//    NSLog(@"%@",self.textFieldCity.text);
    
    if ([_textFieldProvince.text isEqualToString:@"" ]||
        [_textFieldCity.text isEqualToString:@"" ]||
        [_textFieldConsigneeName.text isEqualToString:@""] ||
        [_textFieldPhoneNumber.text isEqualToString:@""] ||
        [_textFieldPostcode.text isEqualToString:@"" ]||
        [_textViewDetailAddress.text isEqualToString:@""]) {
        
//        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"" style:<#(UIAlertActionStyle)#> handler:<#^(UIAlertAction * _Nonnull action)handler#>
        
        UIAlertController  *con = [UIAlertController alertControllerWithTitle:@"填写错误" message:nil
                                                               preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction   *cancle  = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [con addAction:cancle];
        
        
        [self presentViewController:con animated:YES completion:nil];
        
    }
    else
    {
        AppDelegate    *app = [UIApplication  sharedApplication].delegate;
        LLHUser        *auser = app.auser;
        
        LLHAddress *newAddress = [[LLHAddress alloc]init];
        
        
        newAddress.provinceName = _textFieldProvince.text;
        newAddress.city =_textFieldCity.text;
        newAddress.name = app.auser.loginName;
        newAddress.weixin = _textFieldWeChatID.text;
        newAddress.mobile = _textFieldPhoneNumber.text;
        newAddress.shopName = _textFieldStoreName.text;
        newAddress.zip = _textFieldPostcode.text;
        newAddress.addressDetail = _textViewDetailAddress.text;
        newAddress.rest = _isRest;
        newAddress.startTime = _textFieldBegin.text;
        newAddress.endTime = _textFieldEnd.text;
        newAddress.cnee = _labelConsigneeName.text;
        
        NSString *rest = newAddress.zip == NO ? @"0" :@"1";
        NSNumber   *res = [NSNumber   numberWithInt:[rest  intValue]];
        
        
        
        NSDictionary *dic = @{ @"ShopName":   newAddress.shopName,
                               @"ProvinceName":newAddress.provinceName,
                               @"City":  newAddress.city ,
                               @"CNEE":newAddress.cnee,
                               @"AddressDetail":  newAddress.addressDetail ,
                               @"Name":  newAddress.name,
                               @"Weixin":   newAddress.weixin ,
                               @"Mobile":   newAddress.mobile ,
                               @"Zip":  newAddress.zip ,
                               @"Rest":  res ,
                               @"StartTime":newAddress.startTime ,
                               @"EndTime":newAddress.endTime,
                               @"CustomerId":auser.coustomerId
                               };
        
        
//        [DataService getdataService:[AllFunction AddAddress] andparams:dic succeed:^(id response) {
//            
//            
//            NSLog(@"添加statusCode%@",response[@"statusCode"]);
//            
//            NSLog(@"添加Id  %@",response[@"data"]);
//            
//        } failed:^(id error) {
//            
//        }];
        
          [DataService   getLaunchdataService:[AllFunction  AddAddress] andparams:dic succeed:^(id response) {
              NSArray   *arr = response[@"data"][0];
              
              if (arr==nil) {
                  UIAlertController  *con = [UIAlertController alertControllerWithTitle:@"添加失败" message:nil
                                                                         preferredStyle:UIAlertControllerStyleAlert];
                  UIAlertAction   *cancle  = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
                  [con addAction:cancle];
                  [self presentViewController:con animated:YES completion:nil];
                  return ;
              }
              else
              {
                  
                  
                  [[NSUserDefaults  standardUserDefaults]setObject:dic forKey:@"DefaultAddress"];
//
                  UIAlertController  *con = [UIAlertController alertControllerWithTitle:@"添加成功" message:nil
                                                                         preferredStyle:UIAlertControllerStyleAlert];
                  UIAlertAction   *cancle  = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
                  [con addAction:cancle];
                  [self presentViewController:con animated:YES completion:nil];
                  
                  
              [self.navigationController  dismissViewControllerAnimated:YES completion:nil];
              }
              
              
          } failed:^(id error) {
              NSLog(@"%@",error);
          }];

    }
    
   
}

//地址更新
-(void)updateAddress:(UIBarButtonItem *)sender
{
    
    if ([_textFieldProvince.text isEqualToString:@"" ]||
        [_textFieldCity.text isEqualToString:@"" ]||
        [_textFieldConsigneeName.text isEqualToString:@""] ||
        [_textFieldPhoneNumber.text isEqualToString:@""] ||
        [_textFieldPostcode.text isEqualToString:@"" ]||
        [_textViewDetailAddress.text isEqualToString:@""]) {
        
        //        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"" style:<#(UIAlertActionStyle)#> handler:<#^(UIAlertAction * _Nonnull action)handler#>
        UIAlertController  *con = [UIAlertController alertControllerWithTitle:@"填写错误" message:nil
                                                               preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction   *cancle  = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [con addAction:cancle];
        
        
        [self presentViewController:con animated:YES completion:nil];

        
    }
    else
    {
        AppDelegate    *app = [UIApplication  sharedApplication].delegate;
        LLHUser        *auser = app.auser;
        
        LLHAddress *newAddress = [[LLHAddress alloc]init];
        
        
        newAddress.provinceName = _textFieldProvince.text;
        newAddress.city =_textFieldCity.text;
        newAddress.name = app.auser.loginName;
        newAddress.weixin = _textFieldWeChatID.text;
        newAddress.mobile = _textFieldPhoneNumber.text;
        newAddress.shopName = _textFieldStoreName.text;
        newAddress.zip = _textFieldPostcode.text;
        newAddress.addressDetail = _textViewDetailAddress.text;
        newAddress.rest = _isRest;
        newAddress.startTime = _textFieldBegin.text;
        newAddress.endTime = _textFieldEnd.text;
        newAddress.cnee= _labelConsigneeName.text ;
        
        NSString *rest = newAddress.zip == NO ? @"false":@"true";
        
        NSNumber *number = @(newAddress.addressId );
        
        NSDictionary *dic = @{@"Id":  number,
                              @"ShopName":   newAddress.shopName,
                               @"ProvinceName":newAddress.provinceName,
                               @"City":  newAddress.city ,
                              @"CNEE": newAddress.cnee,
                               @"AddressDetail":  newAddress.addressDetail ,
                               @"Name":  newAddress.name,
                               @"Weixin":   newAddress.weixin ,
                               @"Mobile":   newAddress.mobile ,
                               @"Zip":  newAddress.zip ,
                               @"Rest":  rest ,
                               @"StartTime":newAddress.startTime ,
                               @"EndTime":newAddress.endTime,
                               @"CustomerId":auser.coustomerId
                               };
        
//        
//        [DataService getdataService:[AllFunction UpdateAdress] andparams:dic succeed:^(id response) {
//            
//            
//            NSLog(@"更新statusCode%@",response[@"statusCode"]);
//            NSLog(@"statusMessage:%@",response[@"statusMessage"]);
//            
////            NSLog(@"添加Id  %@",response[@"data"]);
//            
//        } failed:^(id error) {
//            
//        }];
        
        [DataService getLaunchdataService:[AllFunction UpdateAdress] andparams:dic succeed:^(id response) {
        
        
//                    NSLog(@"更新statusCode%@",response[@"statusCode"]);
//                    NSLog(@"更新地址statusMessage:%@",response[@"statusMessage"]);
//        
//                    NSLog(@"添加Id  %@",response[@"data"]);
            
            if ([response[@"statusMessage"] isEqualToString:@"更新成功"]) {
                [[NSUserDefaults  standardUserDefaults]setObject:dic forKey:@"DefaultAddress"];
                //
                UIAlertController  *con = [UIAlertController alertControllerWithTitle:@"更新成功" message:nil
                                                                       preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction   *cancle  = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
                [con addAction:cancle];
                [self presentViewController:con animated:YES completion:nil];
                
                
                [self.navigationController  dismissViewControllerAnimated:YES completion:nil];
            

            
            }
            
        
                } failed:^(id error) {
                    
                }];
    }

}


- (void)finishDidSelectDatePicker:(WMCustomDatePicker *)datePicker date:(NSDate *)date
{
    if ([date compare:[NSDate date]] == NSOrderedDescending) {
        self.timeStr = [self dateFromString:date withFormat:@"HH:mm"];
    }
    
}

//根据date返回string
- (NSString *)dateFromString:(NSDate *)date withFormat:(NSString *)format {
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:format];
    NSString *dateStr = [inputFormatter stringFromDate:date];
    return dateStr;
}

-(UIScrollView *)scrollView
{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 30, self.view.frame.size.width,self.view.frame.size.height-30)];
        _scrollView.scrollEnabled = YES;
    }
    return _scrollView;
}

-(UILabel *)labelProvince
{
    if (_labelProvince == nil) {
        _labelProvince = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 30)];
        _labelProvince.font = [UIFont systemFontOfSize:14];
        _labelProvince.text = @"省份：";
        _labelProvince.textAlignment = NSTextAlignmentRight;
//        _labelProvince
        
    }
    return _labelProvince;
}


-(UITextField *)textFieldProvince
{
    if (_textFieldProvince == nil) {
        _textFieldProvince= [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.labelProvince.frame), 5, 200, 28)];
        
        
        UIButton  *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 10)];
        [rightButton setBackgroundImage:[UIImage imageNamed:@"收货地址_03.png"] forState:UIControlStateNormal];
        
        [rightButton addTarget:self action:@selector(provinceList:) forControlEvents:UIControlEventTouchUpInside];
        _textFieldProvince.rightViewMode = UITextFieldViewModeAlways;
        _textFieldProvince.rightView = rightButton;
        _textFieldProvince.borderStyle = UITextBorderStyleRoundedRect;
        _textFieldProvince.delegate = self;
        _textFieldProvince.tag = 10000;
    }
    return _textFieldProvince;
}

//procincelist  get click
-(void)provinceList:(UIButton *)sender
{
    CustomPopOverView *view1 = [[CustomPopOverView alloc]initWithBounds:CGRectMake(0, 0, 120, 200) titleMenus:self.provinceArray];
    view1.delegate = self;
    view1.containerBackgroudColor = [UIColor grayColor];
    [view1 showFrom:sender alignStyle:CPAlignStyleCenter];
}
// provincelist popover
-(void)popOverView:(CustomPopOverView *)pView didClickMenuIndex:(NSInteger)index
{
    NSLog(@"%@",self.provinceArray[index]);
    
    
    self.textFieldProvince.text = self.provinceArray[index];
    [pView dismiss];
}
-(UILabel *)labelCity
{
    if (_labelCity == nil) {
        _labelCity = [[UILabel alloc]initWithFrame:CGRectMake(10,CGRectGetMaxY(self.labelProvince.frame)+10, 100, 30)];
        
        _labelCity.text = @"城市：";
        _labelCity.font = [UIFont systemFontOfSize:14];
        _labelCity.textAlignment = NSTextAlignmentRight;
        
    }
    return _labelCity;
}


-(UITextField *)textFieldCity
{
    if (_textFieldCity == nil) {
        _textFieldCity= [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.labelCity.frame),CGRectGetMaxY(self.textFieldProvince.frame)+11, 200, 28)];
        
        _textFieldCity.placeholder = @"手动填写城市";
        _textFieldCity.font = [UIFont systemFontOfSize:14];
        _textFieldCity.borderStyle = UITextBorderStyleRoundedRect;
        _textFieldCity.delegate = self;
        _textFieldCity.tag = 1001;
    }
    return _textFieldCity;
}



-(UILabel *)labelConsigneeName//收件人姓名
{
    if (_labelConsigneeName == nil) {
        _labelConsigneeName = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.labelCity.frame)+10, 100, 30)];
        _labelConsigneeName.text = @"收货人姓名：";
        _labelConsigneeName.font = [UIFont systemFontOfSize:14];
        _labelConsigneeName.textAlignment = NSTextAlignmentRight;
        
    }
    return _labelConsigneeName;
}


-(UITextField *)textFieldConsigneeName
{
    if (_textFieldConsigneeName == nil) {
        _textFieldConsigneeName= [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.labelConsigneeName.frame), CGRectGetMaxY(self.textFieldCity.frame)+11, 200, 28)];
        
        _textFieldConsigneeName.borderStyle = UITextBorderStyleRoundedRect;
        
        _textFieldConsigneeName.delegate = self;
        _textFieldConsigneeName.tag = 1002;
    }
    return _textFieldConsigneeName;
}

-(UILabel *)labelWeChatID//微信号
{
    if (_labelWeChatID == nil) {
        _labelWeChatID = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.labelConsigneeName.frame)+10, 100, 30)];
        
        _labelWeChatID.text = @"微信号：";
        _labelWeChatID.font = [UIFont systemFontOfSize:14];
        
        _labelWeChatID.textAlignment = NSTextAlignmentRight;
        
    }
    return _labelWeChatID;
}


-(UITextField *)textFieldWeChatID
{
    if (_textFieldWeChatID == nil) {
        _textFieldWeChatID= [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.labelConsigneeName.frame), CGRectGetMaxY(self.textFieldConsigneeName.frame)+11, 200, 28)];
        
        _textFieldWeChatID.borderStyle = UITextBorderStyleRoundedRect;
        _textFieldWeChatID.delegate = self;
    }
    return _textFieldWeChatID;
}


-(UILabel *)labelPhoneNumber//手机号码
{
    if (_labelPhoneNumber == nil) {
        _labelPhoneNumber = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.labelWeChatID.frame)+10, 100, 30)];
        _labelPhoneNumber.text = @"手机号码：";
        _labelPhoneNumber.font = [UIFont systemFontOfSize:14];
        
        _labelPhoneNumber.textAlignment = NSTextAlignmentRight;
        
    }
    return _labelPhoneNumber;
}


-(UITextField *)textFieldPhoneNumber
{
    if (_textFieldPhoneNumber == nil) {
        _textFieldPhoneNumber= [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.labelWeChatID.frame), CGRectGetMaxY(self.textFieldWeChatID.frame)+11, 200, 28)];
        
//        _textFieldPhoneNumber.tag = 1000;
        _textFieldPhoneNumber.borderStyle = UITextBorderStyleRoundedRect;
        _textFieldPhoneNumber.delegate =self;
        _textFieldPhoneNumber.keyboardType = UIKeyboardTypePhonePad;
        _textFieldPhoneNumber.tag = 1003;
        
    }
    return _textFieldPhoneNumber;
}


-(UILabel *)labelStoreName//商店名称
{
    if (_labelStoreName == nil) {
        _labelStoreName = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.labelPhoneNumber.frame)+10, 100, 30)];
  
        _labelStoreName.text = @"商店名称：";
        _labelStoreName.font = [UIFont systemFontOfSize:14];
        _labelStoreName.textAlignment = NSTextAlignmentRight;
        
    }
    return _labelStoreName;
}


-(UITextField *)textFieldStoreName
{
    if (_textFieldStoreName == nil) {
        _textFieldStoreName= [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.labelStoreName.frame), CGRectGetMaxY(self.textFieldPhoneNumber.frame)+11, 200, 28)];
        
//        _textFieldStoreName.tag = 1000;
        _textFieldStoreName.borderStyle = UITextBorderStyleRoundedRect;
        _textFieldStoreName.delegate =self;
    }
    return _textFieldStoreName;
}


-(UILabel *)labelPostcode//邮编
{
    if (_labelPostcode == nil) {
        _labelPostcode = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.labelStoreName.frame)+10, 100, 30)];
        
        _labelPostcode.text = @"邮编：";
        _labelPostcode.font = [UIFont systemFontOfSize:14];
        _labelPostcode.textAlignment = NSTextAlignmentRight;
        
    }
    return _labelPostcode;
}


-(UITextField *)textFieldPostcode
{
    if (_textFieldPostcode == nil) {
        _textFieldPostcode= [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.labelStoreName.frame), CGRectGetMaxY(self.textFieldStoreName.frame)+11, 200, 28)];
        
//        _textFieldPostcode.tag = 1001;
        _textFieldPostcode.borderStyle = UITextBorderStyleRoundedRect;
        _textFieldPostcode.delegate =self;
        _textFieldPostcode.tag = 1004;
        
        
        _textFieldPhoneNumber.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _textFieldPostcode;
}


-(UILabel *)labelDetailAddress
{
    if (_labelDetailAddress == nil) {
        _labelDetailAddress = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.labelPostcode.frame)+10, 100, 30)];
        _labelDetailAddress.text = @"详细地址：";
        _labelDetailAddress.font = [UIFont systemFontOfSize:14];
        _labelDetailAddress.textAlignment = NSTextAlignmentRight;
        
    }
    return _labelDetailAddress;
}


-(UITextView *)textViewDetailAddress//详细地址
{
    if (_textViewDetailAddress == nil) {
        _textViewDetailAddress= [[UITextView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.labelPostcode.frame), CGRectGetMaxY(self.labelPostcode.frame)+20, 200, 90)];
        _textViewDetailAddress.delegate =self;
        _textViewDetailAddress.layer.cornerRadius = 5;
        _textViewDetailAddress.layer.borderWidth = 1;
        _textViewDetailAddress.layer.borderColor=[UIColor colorWithRed:0.5683 green:0.5809 blue:0.5821 alpha:1.0].CGColor;
        
        _textViewDetailAddress.tag = 1005;
    }
    return _textViewDetailAddress;
}


-(UIButton *)buttonRest
{
    if (_buttonRest == nil) {
        _buttonRest = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.labelDetailAddress.frame), CGRectGetMaxY(self.textViewDetailAddress.frame)+10, 22, 22)];
        
        [_buttonRest setBackgroundImage:[UIImage imageNamed:@"收货地址_10.png"] forState:UIControlStateNormal];
        _isRest = NO;
        
        [_buttonRest addTarget:self action:@selector(ifRest:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
    }
    return  _buttonRest;
}
//判断是否要午休
-(void)ifRest:(UIButton *)sender
{
    if ( !_isRest ) {
        [_buttonRest setBackgroundImage:[UIImage imageNamed:@"收货地址_07.png"] forState:UIControlStateNormal];
        _isRest = YES;
    }
    else
    {
        [_buttonRest setBackgroundImage:[UIImage imageNamed:@"收货地址_10.png"] forState:UIControlStateNormal];
        _isRest = NO;
    }
}

-(UILabel *)labelRest
{
    if (_labelRest == nil) {
        _labelRest = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.buttonRest.frame)+10, CGRectGetMaxY(self.textViewDetailAddress.frame)+10, 90, 32)];
        _labelRest.font = [UIFont systemFontOfSize:14];
        _labelRest.text = @"中午休息";
    }
    return _labelRest;
}


-(UILabel *)labelDeliveryTime
{
    if (_labelDeliveryTime == nil) {
        _labelDeliveryTime = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.buttonRest.frame)+10, 90, 32)];
        _labelDeliveryTime.text = @"发货时间：";
        _labelDeliveryTime.font = [UIFont systemFontOfSize:14];
        
        _labelDeliveryTime.textAlignment = NSTextAlignmentRight;
        
    }
    return _labelDeliveryTime;

}



-(UITextField *)textFieldBegin
{
    if (_textFieldBegin == nil) {
        _textFieldBegin = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.labelPostcode.frame), CGRectGetMaxY(self.buttonRest.frame)+20, 90, 20)];

        _textFieldBegin.placeholder = @"开始时间";
        _textFieldBegin.font = [UIFont systemFontOfSize:14];
        _textFieldBegin.delegate =self;
        _textFieldBegin.tag = 101;
        
        _textFieldBegin.borderStyle = UITextBorderStyleRoundedRect;
        
    }
    return _textFieldBegin;
}

-(UITextField *)textFieldEnd
{
    if (_textFieldEnd == nil) {
        _textFieldEnd = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.labelTo.frame), CGRectGetMaxY(self.buttonRest.frame)+20, 90, 20)];
        _textFieldEnd.placeholder = @"结束时间";
        _textFieldEnd.font = [UIFont systemFontOfSize:14];
        _textFieldEnd.delegate = self;
        _textFieldEnd.tag = 102;
        _textFieldEnd.borderStyle = UITextBorderStyleRoundedRect;
        
        
    }
    return _textFieldEnd;
}


-(UILabel *)labelTo
{
    if (_labelTo == nil) {
        _labelTo = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.textFieldBegin.frame), CGRectGetMaxY(self.buttonRest.frame)+10, 40, 32)];
        _labelTo.text = @"--";
        _labelTo.textAlignment = NSTextAlignmentCenter;
    }
    return _labelTo;

}







-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if (textField.tag != 101 && textField.tag != 102  ) {
        return YES;

    }
    return NO;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField;
{
    if (textField.tag != 101 && textField.tag != 102 && textField.tag != 10000) {
        return YES;
        
    }
    else if(textField.tag == 10000)
        
    {
        [textField resignFirstResponder];
        return NO;
    }

    else{
        
        self.pickerView.top = self.view.height-260+44;
        
        [self.pickerView bringSubviewToFront:_scrollView];
        
        if (textField.tag == 101) {
            _flag = NO;//开始时间  flag为no
            
            NSLog(@"%f",self.scrollView.center.y);
           NSLog(@"%f",(CGRectGetMaxY(self.view.frame)-30)/2);
            
            if (self.scrollView.center.y-15 == CGRectGetMaxY(self.view.frame)/2) {
                [UIView animateWithDuration:0.4 animations:^{
                    
                    self.scrollView.center = CGPointMake(self.scrollView.center.x, self.scrollView.center.y-110);
                }];
            }
            
        }
        else{
            
            _flag = YES;
            
            NSLog(@"%f",CGRectGetMaxY(self.view.frame));
            
            NSLog(@"%f",self.scrollView.frame.origin.y);
            
            NSLog(@"%f",self.scrollView.size.height);
            NSLog(@"%f",self.scrollView.center.y);
            if (self.scrollView.center.y-15 == CGRectGetMaxY(self.view.frame)/2) {
                [UIView animateWithDuration:0.4 animations:^{
                    
                    self.scrollView.center = CGPointMake(self.scrollView.center.x, self.scrollView.center.y-110);
                }];
            }

        }
        
        return NO;
    }

}

//4.过滤无效字符
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

//textView代理
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    [UIView animateWithDuration:0.4 animations:^{
        self.scrollView.center = CGPointMake(self.scrollView.center.x, self.scrollView.center.y-100);
    }];

    
    return  YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    [UIView animateWithDuration:0.4 animations:^{
        self.scrollView.center = CGPointMake(self.scrollView.center.x, self.scrollView.center.y+100);
    }];
    [textView  resignFirstResponder];
    return YES;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
