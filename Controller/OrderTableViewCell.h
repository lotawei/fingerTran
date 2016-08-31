//
//  OrderTableViewCell.h
//  指尖叫货
//
//  Created by hjp on 16/6/22.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderTableViewCell : UITableViewCell

@property (nonatomic,strong)UILabel *labelOrderIDTitle;
@property(nonatomic,strong)UILabel *labelOrderID;
@property (nonatomic,strong)UILabel *labelOrderPrice;
@property(nonatomic,strong)UILabel *labelDate;
@property (nonatomic,strong)UILabel *labelQuantity;


@property(nonatomic,strong)NSDictionary *orderDic;
@end
