




//
//  OrderProCell.m
//  指尖叫货
//
//  Created by lotawei on 16/6/26.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "OrderProCell.h"

@implementation OrderProCell

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.acount.layer.cornerRadius = CGRectGetWidth(self.acount.frame)/2;
    self.acount.layer.masksToBounds = YES;
    self.acount.backgroundColor = [UIColor redColor];
    self.acount.textAlignment = NSTextAlignmentCenter;
    self.acount.textColor = [UIColor whiteColor];
    
    [self.reduce addTarget:self action:@selector(reduce:) forControlEvents:UIControlEventTouchUpInside];
    [self.add addTarget:self action:@selector(add:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)add:(UIButton *)sender
{
    
    [self.delegate addPackage:self];
    
}

- (void)reduce:(UIButton *)sender
{
    [self.delegate  reducePackage:self];
}

@end
