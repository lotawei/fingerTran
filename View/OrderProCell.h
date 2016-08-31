//
//  OrderProCell.h
//  指尖叫货
//
//  Created by lotawei on 16/6/26.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellProtocol.h"
@interface OrderProCell : UITableViewCell


@property(weak,nonatomic) id<CellProtocol>     delegate;
@property (weak, nonatomic) IBOutlet UIButton *reduce;
@property (weak, nonatomic) IBOutlet UIImageView *proimg;

@property (weak, nonatomic) IBOutlet UILabel *proname;
@property (weak, nonatomic) IBOutlet UIButton *add;
@property (weak, nonatomic) IBOutlet UILabel *proprice;

@property (weak, nonatomic) IBOutlet UILabel *acount;

@property (weak, nonatomic) IBOutlet UILabel *pack;



@end
