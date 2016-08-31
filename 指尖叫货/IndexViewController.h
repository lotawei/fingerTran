//
//  ViewController.h
//  指尖叫货
//
//  Created by rimi on 16/6/19.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShowView.h"
#import "CellProtocol.h"
#import "SDCycleScrollView.h"

@class ProCollectionCell;
@interface IndexViewController : UIViewController
//@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
//@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;
//@property (nonatomic, strong) NSTimer *timer;
@property(nonatomic,strong)  UIScrollView  *totalscroll;
@property(nonatomic,strong)   SDCycleScrollView   *gonggao;

@property(nonatomic,strong)   UILabel   *alab;
@property(nonatomic,strong)  SDCycleScrollView  *scrollview;
//四个小东西
@property(nonatomic,strong) ShowView   *allgoods;
@property(nonatomic,strong) ShowView   *categery;
@property(nonatomic,strong)  ShowView   *newgoods;
@property(nonatomic,strong)  ShowView    *dicountgoods;

//推荐商品 列表下

@property(nonatomic,strong)  UIView   *tuijian ;



@property(nonatomic,strong) NSMutableArray   *products;


@property(nonatomic,strong)  UICollectionView   *collectionview;

//推荐商品 列表获取
@property(nonatomic,strong) NSMutableArray  *tuijiansparr;

//公告信息

@property(nonatomic,strong)   NSMutableArray   *gonggaodic;
@property(nonatomic,strong)   NSMutableArray   *gonggaocontent;

//轮播图片数组
@property(nonatomic,strong)    NSMutableArray     *imgurls;

@property(nonatomic,strong)    NSMutableArray      *urls;




@end

