//
//  SearchTableViewCell.m
//  指尖叫货
//
//  Created by rimi on 16/6/25.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "SearchTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation SearchTableViewCell
@synthesize product = _product;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    [self loadAddressView];
    
    return self;
}


-(void)loadAddressView
{
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    _imageProduct = [[UIImageView alloc]initWithFrame:CGRectMake(30, 20, 50, 50)];
    
    [self.contentView addSubview:_imageProduct];
    
    
    _labelProduct = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_imageProduct.frame)+30, 20, 200, 20)];
    
    _labelProduct.textAlignment = NSTextAlignmentLeft;
    _labelProduct.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_labelProduct];
    
    
    _labelPrice= [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_imageProduct.frame)+30,CGRectGetMaxY(_imageProduct.frame)-20,30,20)];
    _labelPrice.textAlignment = NSTextAlignmentLeft;
    _labelPrice.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_labelPrice];
    
    
    
    _labelDiscountPrice = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_labelPrice.frame)+30,CGRectGetMaxY(_imageProduct.frame)-20,70,20)];
    _labelDiscountPrice.textAlignment = NSTextAlignmentCenter;
    _labelDiscountPrice.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_labelDiscountPrice];
    
    
    
    _labelUnit = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_labelDiscountPrice.frame)+30,CGRectGetMaxY(_imageProduct.frame)-20,30,20)];
    _labelUnit.textAlignment = NSTextAlignmentLeft;
    _labelUnit.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_labelUnit];
    
    _seperatorLine = [[UILabel alloc]initWithFrame:CGRectMake(0, 84, 375, 1)];
    _seperatorLine.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:_seperatorLine];
    
    
}

-(void)setProduct:(LLHProdoct *)product
{
    _product = product;
    
    if (_product ) {
        //        _labelName.text = @"姓名：";
        
        
        
        
        [_imageProduct  sd_setImageWithURL:[NSURL URLWithString:_product.imageUrl] placeholderImage:[UIImage  imageNamed:@"place.png"]];
        _labelProduct.text = _product.categoryTitle !=nil  ? _product.categoryTitle :@"";
        _labelPrice.text = [NSString stringWithFormat:@"%.2f",_product.price];
        _labelDiscountPrice.text = [NSString stringWithFormat:@"%.2f",_product.discountprice];
        _labelUnit.text = [NSString stringWithFormat:@"%ld",_product.package];
 
        
        
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
