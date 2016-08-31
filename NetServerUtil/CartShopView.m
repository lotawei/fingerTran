//
//  CartShopView.m
//  指尖叫货
//
//  Created by rimi on 16/6/25.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "CartShopView.h"

@implementation CartShopView
-(void)awakeFromNib
{
//    self.Orderpros = [NSMutableArray  arrayWithCapacity:0];
    [super awakeFromNib];
    self.layer.cornerRadius = 30;
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer  *atap  = [[UITapGestureRecognizer  alloc]initWithTarget:self action:@selector(details)];
    
    [self   addGestureRecognizer:atap];
    
}

-(void)details
{
    [self.delegate  cartshopdetails:self];
}

- (UILabel *)ordertotal
{
    NSLog(@"取值。。");
    return _ordertotal;
}




-(void)setShopHidden
{
    NSInteger money =  [self.ordertotal.text integerValue];
    if (money <= 0) {
        self.ordertotal.hidden = YES;
        self.textLabel.hidden = YES;
        self.moneyUnit.hidden = YES;
        
    }
    else
    {
        self.ordertotal.hidden = NO;
        self.textLabel.hidden = NO;
        self.moneyUnit.hidden = NO;
    }
}


@end
