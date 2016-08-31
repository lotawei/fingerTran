//
//  CartShopView.h
//  指尖叫货
//
//  Created by rimi on 16/6/25.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShowViewDelegate.h"
#import "LLHProdoct.h"
@interface CartShopView : UIView
@property (strong, nonatomic) IBOutlet UILabel *ordertotal;

@property (weak, nonatomic) IBOutlet UILabel *textLabel;

@property (weak, nonatomic) IBOutlet UILabel *moneyUnit;

@property (nonatomic,weak)  id<ShowViewDelegate>  delegate;
//@property (nonatomic,strong)  NSMutableArray *Orderpros ;


-(void)setShopHidden;
@end
