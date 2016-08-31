//
//  NewGoodsViewController.h
//  指尖叫货
//
//  Created by rimi on 16/6/22.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellProtocol.h"
#import "ProductCell.h"
#import "CartShopView.h"
@interface NewGoodsViewController : UIViewController


@property(nonatomic,strong)  UICollectionView   *collectionview;

@property  (nonatomic,strong) NSMutableArray   *products;




/**
 *  协议
 */



@end
