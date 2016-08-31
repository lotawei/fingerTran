//
//  CellProtocol.h
//  指尖叫货
//
//  Created by rimi on 16/6/24.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <Foundation/Foundation.h>
@class  ProCollectionCell;
@class  ProductCell ;
@protocol CellProtocol <NSObject>
-(void)reducePackage:(id)cell;
-(void)addPackage:(id)cell;
@optional






@end
