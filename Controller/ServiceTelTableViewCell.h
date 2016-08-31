//
//  ServiceTelTableViewCell.h
//  指尖叫货
//
//  Created by rimi on 16/6/24.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ServiceTelTableViewCell : UITableViewCell
@property(nonatomic,strong)UILabel *telTitle;
@property(nonatomic,strong)UILabel *tel;
@property(nonatomic,strong)UIButton *call;

@property(nonatomic,strong)NSDictionary *telDic;

@end
