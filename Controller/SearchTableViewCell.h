//
//  SearchTableViewCell.h
//  指尖叫货
//
//  Created by rimi on 16/6/25.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLHProdoct.h"

@interface SearchTableViewCell : UITableViewCell
@property(nonatomic,strong) UIImageView *imageProduct;
@property(nonatomic,strong)UILabel *labelProduct;
@property(nonatomic,strong)UILabel *labelPrice;
@property(nonatomic,strong)UILabel *labelDiscountPrice;
@property(nonatomic,strong)UILabel *labelUnit;

@property(nonatomic,strong)UILabel *seperatorLine;

@property(nonatomic,strong)LLHProdoct *product;

@end
