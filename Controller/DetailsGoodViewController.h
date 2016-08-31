//
//  DetailsGoodViewController.h
//  指尖叫货
//
//  Created by rimi on 16/6/23.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLHProdoct.h"
@interface DetailsGoodViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *acount;
@property (strong,nonatomic)  LLHProdoct   *apro ;
@property (strong, nonatomic) IBOutlet UILabel *propackage;
@property (strong, nonatomic) IBOutlet UILabel *probarcode;
- (IBAction)decrease:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *procode;
- (IBAction)add:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *prototalprice;

@property (strong, nonatomic) IBOutlet UILabel *proprice;
@property (strong, nonatomic) IBOutlet UIImageView *img;
@property (strong, nonatomic) IBOutlet UILabel *proname;

@property (weak, nonatomic) IBOutlet UILabel *discount;
@property (weak, nonatomic) IBOutlet UILabel *afterDiscountPrice;
@property (weak, nonatomic) IBOutlet UILabel *takeoutLine;

@end
