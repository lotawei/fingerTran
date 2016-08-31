//
//  AllGoodsViewController.h
//  指尖叫货
//
//  Created by rimi on 16/6/22.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ProductCell ;
@interface AllGoodsViewController : UIViewController
@property(nonatomic,strong)  UICollectionView   *collectionview;
@property(nonatomic,strong)  NSMutableArray     *products;

-(void)addPackage:(ProductCell*)cell;
-(void)reducePackage:(ProductCell*)cell;
@end
