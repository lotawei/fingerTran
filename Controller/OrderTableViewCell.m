//
//  OrderTableViewCell.m
//  指尖叫货
//
//  Created by hjp on 16/6/22.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "OrderTableViewCell.h"

@implementation OrderTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    [self loadAddressView];
    
    return self;
}


-(void)loadAddressView
{
//    self.contentView.backgroundColor = [UIColor grayColor];
    _labelOrderIDTitle = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, 60, 30)];
    
    _labelOrderIDTitle.textAlignment = NSTextAlignmentLeft;
    _labelOrderIDTitle.text = @"订单号：";
//    _labelOrderIDTitle.textColor = [UIColor redColor];
    _labelOrderIDTitle.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_labelOrderIDTitle];
    
    
    _labelOrderID= [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_labelOrderIDTitle.frame), 20, 150, 30)];
    _labelOrderID.textAlignment = NSTextAlignmentLeft;
    _labelOrderID.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_labelOrderID];
    
    
    
    _labelOrderPrice = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_labelOrderID.frame)+30, 20, 90, 30)];
    
    _labelOrderPrice.textAlignment = NSTextAlignmentLeft;
    _labelOrderPrice.textColor = [UIColor redColor];
    _labelOrderPrice.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_labelOrderPrice];
    
    
    
    
    
    
    _labelDate = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(_labelOrderPrice.frame), 150, 30)];
    _labelDate.textAlignment = NSTextAlignmentLeft;
    _labelDate.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_labelDate];
    
    
    _labelQuantity = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_labelOrderID.frame)+30, CGRectGetMaxY(_labelOrderPrice.frame), 350, 30)];
    _labelQuantity.textAlignment = NSTextAlignmentLeft;
    _labelQuantity.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_labelQuantity];
    
}

-(void)setOrderDic:(NSDictionary *)orderDic
{
    _orderDic = orderDic;
    
    if (_orderDic ) {
        //        _labelName.text = @"姓名：";
        _labelOrderID.text = _orderDic[@"id"];
        _labelOrderPrice.text =  [NSString stringWithFormat:@"€ %@", _orderDic[@"price"]];
        _labelDate.text = _orderDic[@"date"];
        _labelQuantity.text =[NSString stringWithFormat:@"X %@",_orderDic[@"quantity"]];
        
        
        
        //        _labelName.text = @"胡金平";
        //        _labelPhoneNumber.text = @"18328443716";
        //        _labelAddress.text = @"成都市，哈哈哈哈哈哈哈哈";
        
    }
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
