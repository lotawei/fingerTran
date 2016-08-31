//
//  CateGoryDetailController.h
//  指尖叫货
//
//  Created by rimi on 16/6/28.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ProductCell ;
@interface CateGoryDetailController : UIViewController


@property (nonatomic,strong)NSString *categoryTitle;

@property(nonatomic,strong)  UICollectionView   *collectionview;
@property(nonatomic,strong)  NSMutableArray     *products;
@property(nonatomic)   CGRect     original;
-(void)addPackage:(ProductCell*)cell;
-(void)reducePackage:(ProductCell*)cell;

@end
