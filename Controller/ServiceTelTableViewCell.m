//
//  ServiceTelTableViewCell.m
//  指尖叫货
//
//  Created by rimi on 16/6/24.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "ServiceTelTableViewCell.h"

@implementation ServiceTelTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    [self loadAddressView];
    
    return self;
}


-(void)loadAddressView
{
    self.contentView.backgroundColor = [UIColor whiteColor];
    _telTitle = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, 120, 50)];
    
    _telTitle.textAlignment = NSTextAlignmentLeft;
    _telTitle.text = @"客服电话：";
//    _telTitle.textColor = [UIColor redColor];
    _telTitle.font = [UIFont systemFontOfSize:17];
    [self.contentView addSubview:_telTitle];
    
    
    _tel= [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_telTitle.frame), 20, 150, 50)];
    _tel.textAlignment = NSTextAlignmentLeft;
    _tel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_tel];
    
    
    
    _call = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_tel.frame)+30, 20, 30, 30)];
    
    
    [self.contentView addSubview:_call];
    
    
    
    
    
    }

-(void)setTelDic:(NSDictionary *)telDic
{
    _telDic = telDic;
    if (_telDic) {
        _telTitle.text = [NSString stringWithFormat:@"客服电话%ld：",[telDic[@"Id"]integerValue]];
        _tel.text = telDic[@"PhoneNumber"];
        [_call setBackgroundImage:[UIImage imageNamed:@"iconfont-dianhua-(1)@2x.png"] forState:UIControlStateNormal];
    }
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}





@end
