//
//  AddressTableViewCell.h
//  指尖叫货
//
//  Created by rimi on 16/6/22.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLHAddress.h"
@class AddressManageViewController ;
@interface AddressTableViewCell : UITableViewCell

@property (nonatomic,strong)UILabel *labelNameTitle;
@property(nonatomic,strong)UILabel *labelName;
@property (nonatomic,strong)UILabel *labelPhoneNumberTitle;
@property(nonatomic,strong)UILabel *labelPhoneNumber;
@property (nonatomic,strong)UILabel *labelAddress;
@property(nonatomic,strong)UIButton *buttonUpdate;

@property(nonatomic,strong)UILabel *labelIsDefault;
@property(nonatomic,strong)LLHAddress *address;

@property(nonatomic,weak)  AddressManageViewController  *   celldelegate;




@end
