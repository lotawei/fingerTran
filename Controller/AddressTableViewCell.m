//
//  AddressTableViewCell.m
//  指尖叫货
//
//  Created by rimi on 16/6/22.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "AddressTableViewCell.h"
#import "AddressManageViewController.h"

@implementation AddressTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    [self loadAddressView];
    
    return self;
}


-(void)loadAddressView
{
    self.contentView.backgroundColor = [UIColor whiteColor];
    _labelNameTitle = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, 60, 30)];
    
    _labelNameTitle.textAlignment = NSTextAlignmentLeft;
    _labelNameTitle.text = @"姓名：";
//    _labelNameTitle.textColor = [UIColor redColor];
    _labelNameTitle.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_labelNameTitle];
    
    
    _labelName= [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_labelNameTitle.frame), 20, 60, 30)];
    _labelName.textAlignment = NSTextAlignmentLeft;
    _labelName.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_labelName];
    
    
    
    _labelPhoneNumberTitle = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_labelName.frame)+30, 20, 90, 30)];
    
    _labelPhoneNumberTitle.textAlignment = NSTextAlignmentCenter;
    _labelPhoneNumberTitle.text = @"电话号码：";
    _labelPhoneNumberTitle.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_labelPhoneNumberTitle];
    
    _labelPhoneNumber = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_labelPhoneNumberTitle.frame), 20, 100, 30)];
    _labelPhoneNumber.textAlignment = NSTextAlignmentLeft;
    _labelPhoneNumber.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_labelPhoneNumber];
    
    
    
    
    
    _labelAddress = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(_labelNameTitle.frame), 350, 30)];
    _labelAddress.textAlignment = NSTextAlignmentLeft;
    _labelAddress.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_labelAddress];
    
    
    _labelIsDefault = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(_labelAddress.frame), 60, 30)];
    _labelIsDefault.text = @"[默认]";
    _labelIsDefault.textAlignment = NSTextAlignmentLeft;
    _labelIsDefault.textColor = [UIColor colorWithRed:0.2f green:0.55f blue:1.0f alpha:1];
    [self.contentView addSubview:_labelIsDefault];
    
    _buttonUpdate = [[UIButton alloc]initWithFrame:CGRectMake(300, CGRectGetMaxY(_labelAddress.frame), 60, 30)];
    [_buttonUpdate setTitle:@"修改" forState:UIControlStateNormal];
    _buttonUpdate.backgroundColor = [UIColor colorWithRed:0.2f green:0.55f blue:1.0f alpha:1];
    
    _buttonUpdate.layer.cornerRadius = 5;
    [_buttonUpdate addTarget:self action:@selector(up) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_buttonUpdate];
    
}

-(void)up
{
    [self.celldelegate   pass:self];
}

-(void)setAddress:(LLHAddress *)address
{
    _address = address;
    
    if (_address ) {
        //        _labelName.text = @"姓名：";
        _labelName.text = _address.name;
        NSLog(@"labelname :%@",_address.name);
        _labelPhoneNumber.text = _address.mobile;
        _labelAddress.text = _address.addressDetail;
        
        
    
        
        if (!_address.isDefaultAddress) {
            _labelIsDefault.hidden = NO;
            NSLog(@"是默认");
        }
        else
        {
            NSLog(@"并不是默认");
            _labelIsDefault.hidden = YES;
        }
        //        _labelName.text = @"胡金平";
        //        _labelPhoneNumber.text = @"18328443716";
        //        _labelAddress.text = @"成都市，哈哈哈哈哈哈哈哈";
        
    }

}

//-(void)setAddressDic:(LLHAddress *)address
//{
//    _address = address;
//    
//    if (_address ) {
////        _labelName.text = @"姓名：";
//        _labelName.text = _address.name;
//        NSLog(@"labelname :%@",_address.name);
//        _labelPhoneNumber.text = _address.mobile;
//        _labelAddress.text = _address.addressDetail;
//        
////        _labelName.text = @"胡金平";
////        _labelPhoneNumber.text = @"18328443716";
////        _labelAddress.text = @"成都市，哈哈哈哈哈哈哈哈";
//        
//    }
//}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
