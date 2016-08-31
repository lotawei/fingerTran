//
//  ProductCell.h
//  指尖叫货
//
//  Created by rimi on 16/6/24.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AllGoodsViewController.h"
#import "CellProtocol.h"
@interface ProductCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *clickNumberLabel;
@property (weak, nonatomic) IBOutlet UIImageView *productImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *packageLabel;



@property (weak, nonatomic) IBOutlet UIButton *reduceButton;
@property (weak, nonatomic) IBOutlet UIButton *addButton;

@property (weak, nonatomic) IBOutlet UILabel *discountUnit;

@property (weak, nonatomic) IBOutlet UILabel *discountPrice;

@property (weak, nonatomic) IBOutlet UILabel *takeOutLine;





@property (weak, nonatomic) id<CellProtocol>  delegate;
@end
