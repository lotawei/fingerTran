//
//  ProductCell.m
//  指尖叫货
//
//  Created by rimi on 16/6/24.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "ProductCell.h"

@implementation ProductCell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.clickNumberLabel.layer.cornerRadius = CGRectGetWidth(self.clickNumberLabel.frame)/2;
    self.clickNumberLabel.layer.masksToBounds = YES;
    self.clickNumberLabel.backgroundColor = [UIColor redColor];
    self.clickNumberLabel.textAlignment = NSTextAlignmentCenter;
    self.clickNumberLabel.textColor = [UIColor whiteColor];
    
    [self.reduceButton addTarget:self action:@selector(reduce:) forControlEvents:UIControlEventTouchUpInside];
    [self.addButton addTarget:self action:@selector(add:) forControlEvents:UIControlEventTouchUpInside];
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
