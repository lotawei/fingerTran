//
//  CateGoryCell.h
//  指尖叫货
//
//  Created by lotawei on 16/6/27.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CateGoryCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *total;

@end
