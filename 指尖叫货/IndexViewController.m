//
//  ViewController.m
//  指尖叫货
//
//  Created by rimi on 16/6/19.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "IndexViewController.h"
#import "SearchViewController.h"
#import  "UIImageView+WebCache.h"
#import "LLHProdoct.h"
#import "DataService.h"
#import "AllFunction.h"
#import "SVProgressHUD.h"
#import "MineViewController.h"
#import "zuixingonggaoViewController.h"
#import "AppDelegate.h"
#import "DetailsGoodViewController.h"
#import "AllGoodsViewController.h"
#import "CateGoryViewController.h"
#import "NewGoodsViewController.h"
#import "DiscountViewController.h"
#import "CellProtocol.h"
#import "CartShopView.h"
#import "ProductCell.h"

#import "ShopViewController.h"
@interface IndexViewController ()<SDCycleScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,CellProtocol,ShowViewDelegate>

- (IBAction)gosearch:(UIBarButtonItem *)sender;
- (IBAction)goMine:(UIBarButtonItem *)sender;

@end



@implementation IndexViewController

-(NSMutableArray *)imgurls
{
    if (_imgurls==nil) {
        _imgurls = [NSMutableArray   arrayWithCapacity:0];
    }
    return _imgurls;
}
-(NSMutableArray *)urls
{
    if (_urls==nil) {
        _urls = [NSMutableArray   arrayWithCapacity:0];
    }
    return _urls;
}
-(NSMutableArray *)gonggaocontent
{
    if (_gonggaocontent==nil) {
        _gonggaocontent = [NSMutableArray   arrayWithCapacity:0];
    }
    return _gonggaocontent;
}
-(NSMutableArray *)gonggaodic
{
    if (_gonggaodic==nil) {
        _gonggaodic = [NSMutableArray   arrayWithCapacity:0];
    }
    return _gonggaodic;
}
-(NSMutableArray *)tuijiansparr
{
    if (_tuijiansparr==nil) {
        _tuijiansparr =  [[NSMutableArray  alloc]initWithCapacity:0];
    }
    return _tuijiansparr;
}
-(SDCycleScrollView*)scrollview
{
    
    
    
    
    if (_scrollview == nil ) {
        SDCycleScrollView *cycleScrollView = [[SDCycleScrollView alloc]init];
       
            
        
      
       cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 180) shouldInfiniteLoop:YES imageNamesGroup:nil];
        cycleScrollView.placeholderImage = [UIImage  imageNamed:@"defaultIcon.png"];
        cycleScrollView.delegate = self;
        cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated   ;
        cycleScrollView.pageControlDotSize=CGSizeMake(8.0, 10.0);
        cycleScrollView.currentPageDotColor = [UIColor blackColor];
    
        cycleScrollView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        //         --- 轮播时间间隔，默认1.0秒，可自定义
        cycleScrollView.autoScrollTimeInterval = 3.0;
        _scrollview = cycleScrollView;
    }
    return _scrollview;
}
-(UILabel*)alab
{
    if (_alab==nil) {
        
        _alab = [[UILabel  alloc]initWithFrame:CGRectMake(8, 245, 100, 40)];
        _alab.text = @"最新公告";
        _alab.textColor = [UIColor  redColor];
        _alab.font = [UIFont systemFontOfSize:20];
    }
    return _alab;
}
-(SDCycleScrollView *)gonggao
{
    if (_gonggao == nil) {
        SDCycleScrollView *cyclelale = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(CGRectGetMaxX(self.alab.frame)+40, 245,250, 40) delegate:self placeholderImage:nil];
        cyclelale.scrollDirection = UICollectionViewScrollDirectionVertical;
        cyclelale.onlyDisplayText = YES;
        cyclelale.titleLabelTextFont = [UIFont systemFontOfSize:14];
        cyclelale.titleLabelTextColor = [ UIColor  blueColor];
        
        cyclelale.titleLabelBackgroundColor = [UIColor whiteColor];
        NSMutableArray *titlesArray = [NSMutableArray new];
        [titlesArray addObject:@"打广告就这么多字，多了加钱！"];
        [titlesArray addObject:@"看你这么吊就是要广告呗！"];
        cyclelale.titlesGroup = [titlesArray copy];
        _gonggao = cyclelale;
        
    }
    return _gonggao;
}
-(ShowView *)allgoods
{
    if (_allgoods == nil) {
        _allgoods = [[NSBundle  mainBundle]loadNibNamed:@"ShowView" owner:self options:nil].firstObject;
        [_allgoods setFrame:CGRectMake(8, CGRectGetMaxY(self.gonggao.frame), 80, 60)];
        _allgoods.imageview.image = [UIImage imageNamed:@"全部商品.png"];
        _allgoods.tag = 1001;
       
        UITapGestureRecognizer  *atap = [[UITapGestureRecognizer  alloc]initWithTarget:self action:@selector(gotodetail:)];
        [_allgoods addGestureRecognizer:atap];
        
        
    }
    return _allgoods;
}





-(void)gotodetail:(UITapGestureRecognizer *)sender
{
    ShowView   * ah = (ShowView*)sender.view;
    NSLog(@"%ld",ah.tag);
    //所有商品列表
    if (ah.tag == 1001) {
        [self.navigationController  pushViewController:[[AllGoodsViewController  alloc]init] animated:YES];
    }
    
    //分类列表
    if (ah.tag == 1002) {
          [self.navigationController  pushViewController:[[CateGoryViewController  alloc]init] animated:YES];
    }
    //新品
    if (ah.tag == 1003) {
                  [self.navigationController  pushViewController:[[NewGoodsViewController  alloc]init] animated:YES];
    }
    //折扣
    if (ah.tag == 1004) {
                  [self.navigationController  pushViewController:[[DiscountViewController  alloc]init] animated:YES];
    }
    
    
}

-(ShowView *)newgoods
{
    if (_newgoods == nil) {
        _newgoods = [[NSBundle  mainBundle]loadNibNamed:@"ShowView" owner:self options:nil].firstObject;
        [_newgoods setFrame:CGRectMake(CGRectGetMaxX(self.categery.frame)+10, CGRectGetMaxY(self.gonggao.frame), 80, 60)];
        _newgoods.imageview.image = [UIImage imageNamed:@"本月新品.png"];
        _newgoods.tag = 1003;
          UITapGestureRecognizer  *atap = [[UITapGestureRecognizer  alloc]initWithTarget:self action:@selector(gotodetail:)];
        
        [_newgoods addGestureRecognizer:atap];
    }
    return _newgoods;
}
-(ShowView *)dicountgoods
{
    if (_dicountgoods == nil) {
        _dicountgoods = [[NSBundle  mainBundle]loadNibNamed:@"ShowView" owner:self options:nil].firstObject;
        [_dicountgoods setFrame:CGRectMake(CGRectGetMaxX(self.newgoods.frame)+10, CGRectGetMaxY(self.gonggao.frame), 80, 60)];
        _dicountgoods.imageview.image = [UIImage imageNamed:@"折扣促销.png"];
        _dicountgoods.tag = 1004;
        
          UITapGestureRecognizer  *atap = [[UITapGestureRecognizer  alloc]initWithTarget:self action:@selector(gotodetail:)];
        [_dicountgoods addGestureRecognizer:atap];
    }
    return _dicountgoods;
}
-(ShowView *)categery
{
    if (_categery == nil) {
        _categery = [[NSBundle  mainBundle]loadNibNamed:@"ShowView" owner:self options:nil].firstObject;
        [_categery setFrame:CGRectMake(CGRectGetMaxX(self.allgoods.frame)+10, CGRectGetMaxY(self.gonggao.frame), 80, 60)];
        _categery.imageview.image = [UIImage imageNamed:@"首页_分类.png"];
        _categery.tag = 1002;
        
          UITapGestureRecognizer  *atap = [[UITapGestureRecognizer  alloc]initWithTarget:self action:@selector(gotodetail:)];
        [_categery addGestureRecognizer:atap];
    }
    return _categery;
}

-(UICollectionView *)collectionview
{
    if (_collectionview==nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        _collectionview.backgroundColor  = [UIColor  redColor];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.tuijian.frame), 375,CGRectGetHeight(self.view.frame)-CGRectGetMaxY(self.tuijian.frame) ) collectionViewLayout:layout];
        [_collectionview registerNib:[UINib nibWithNibName:@"ProductCell" bundle:nil] forCellWithReuseIdentifier:@"ProductCell"];
        _collectionview.delegate = self;
        _collectionview.dataSource = self;
        
    }
    return _collectionview;
}

-(UIView *)tuijian
{
    if (_tuijian==nil) {
        _tuijian = [[NSBundle  mainBundle]loadNibNamed:@"tuijian" owner:self options:nil].firstObject;
        [_tuijian setFrame:CGRectMake(0, CGRectGetMaxY(self.allgoods.frame), 375, 50)];
        
     
    }
    return _tuijian;
}

-(NSMutableArray *)products
{
    if (_products==nil) {
        _products = [NSMutableArray  arrayWithCapacity:0];
    }
    return _products;
}

-(void)viewDidLayoutSubviews
{
    AppDelegate   *app= [UIApplication sharedApplication].delegate;
    CartShopView   *aview =  app.shopview;
    aview.ordertotal.text = [NSString  stringWithFormat:@"%.2f",app.auser.orderprice];
    aview.delegate = self;
    aview.hidden = NO;
      self.collectionview.backgroundColor = [UIColor  whiteColor];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 40)];
    label.text = @"万达百货";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor colorWithRed:0.2f green:0.55f blue:1.0f alpha:1];
    
    self.navigationItem.titleView = label;
    [self.view addSubview:self.alab];
    
    [self.view addSubview:self.scrollview];
    
    
    [self.view addSubview:self.allgoods];
    [self.view  addSubview:self.categery];
    [self.view  addSubview:self.newgoods];
    [self.view  addSubview:self.dicountgoods];
    [self.view addSubview:self.tuijian];
    [self.view  addSubview:self.collectionview];
    
    self.view.backgroundColor  = [UIColor   whiteColor];
    
    [self.view addSubview:self.gonggao];
    
    
    
    AppDelegate   *app= [UIApplication sharedApplication].delegate;
    
    
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    [DataService   getdataService: [AllFunction  GetSliderList] andparams:nil succeed:^(id response) {
        NSArray   *arr = response[@"data"];
        NSString   *urlbase = [AllFunction   BaseUrl];
        for (NSDictionary  *dic in arr) {
            NSURL   *imurl = [NSURL  URLWithString:[urlbase stringByAppendingString:dic[@"ImageUrl"]]];
            [self.imgurls addObject:imurl];
            NSString   *url =dic[@"LinkUrl"];
            if (url!=nil&&  ![url isEqual:[NSNull  null]]) {
                NSURL   *linkurl = [NSURL  URLWithString:url];
                [self.urls addObject:linkurl];
            }
            
            
            
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            
            self.scrollview.imageURLStringsGroup = self.imgurls;
            self.scrollview.tag = 117;
        });
        
        
        
    } failed:^(id error) {
        
    }];
    
    [DataService   getdataService:[AllFunction  TZ] andparams:nil succeed:^(id response) {
        NSArray    *arr = response[@"data"];
        
        for (NSDictionary  *dic in arr) {
            [self.gonggaodic addObject:dic];
            NSString   *content = dic[@"Content"];
            if (content!=nil&&![content isEqual:[NSNull  null]]) {
                [self.gonggaocontent addObject:content];
            }
            
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSMutableArray *titlesArray = [NSMutableArray arrayWithCapacity:0];
            for (NSDictionary  *dic in self.gonggaodic) {
                [titlesArray addObject:dic[@"Title"]];
                
            }
            
            self.gonggao.titlesGroup = titlesArray;
            self.gonggao.tag = 118;
        });
        
        
    } failed:^(id error) {
        
    }];
    
    
    
    
    //网上获取推荐列表
    //只要获取到商品  就扔到我的 所有产品中
    
    
    [DataService  getdataService:[AllFunction GetListByStatus ] andparams:[NSDictionary  dictionaryWithObjects:@[@"1"] forKeys:@[@"goodsStatusCode"]] succeed:^(id response) {
        [SVProgressHUD  show];
        NSArray   *proarr  = response[@"data"][0][@"List"];
        
        for (NSDictionary *dic in proarr) {
            LLHProdoct    *pro = [LLHProdoct  proWithdic:dic];
            pro.isnewgoods = YES;
          
            [self.products addObject:pro];
            
        }
       
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.collectionview reloadData];
        });
        
        [self  stop];
        
        
        
    } failed:^(id error) {
        [self  stop];
    }];
    
    [self.view  addSubview:app.shopview];
}
-(void)stop
{
    [SVProgressHUD  dismiss];
}

-(void)viewWillAppear:(BOOL)animated
{
    
    
     AppDelegate   *app = [UIApplication   sharedApplication].delegate;
    
    
    [app.auser changcount:self.products];
    [self.collectionview   reloadData];
    [self.view addSubview:app.shopview];
    [self.view  bringSubviewToFront:app.shopview];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:nil];
    [app.shopview setFrame:app.original];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [self stop];
  
    AppDelegate   *app = [UIApplication   sharedApplication].delegate;
    for (LLHProdoct  *pro in self.products) {
        
        [app.auser   addScanPro:pro];
        [app.auser  addOrderPro:pro];
        NSLog(@"%@",pro.goodsCode);
    }
    NSLog(@"浏览的商品个数%ld",app.auser.scanproducts.count);
    
    
    
 
    
    
}

- (IBAction)gosearch:(UIBarButtonItem *)sender {
    
    [self.navigationController  pushViewController:[[SearchViewController  alloc]init] animated:YES];
    
}

- (IBAction)goMine:(UIBarButtonItem *)sender {
    
    
    [self.navigationController   pushViewController:[[MineViewController alloc]init] animated:YES];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if ((section+1)*2>self.products.count) {
        return 1;
    }
    
    return 2;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.products.count/2 + self.products.count%2;
}

//每格上的内容
- (ProductCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ProductCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ProductCell" forIndexPath:indexPath];
    NSInteger    loc = 2*indexPath.section + indexPath.row   ;
    if (loc==self.products.count) {
        cell.hidden = YES;
        
        LLHProdoct   *apro = self.products[loc-1];
        [self.products removeObject:apro];
        return cell;
    }
    
    LLHProdoct   *pro = self.products[loc];
    cell.delegate = self;
      cell.hidden = NO;
    [cell.productImage sd_setImageWithURL:[NSURL URLWithString:pro.imageUrl]    placeholderImage:[UIImage  imageNamed:@"place.png"]];
    if(pro.procount <= 0)
    {
        cell.clickNumberLabel.hidden = YES;
          cell.clickNumberLabel.text  = @"";

    }
    else
    {
        cell.clickNumberLabel.hidden = NO;
        cell.clickNumberLabel.text  = [NSString  stringWithFormat:@"%ld",pro.procount];
    }
//    cell.clickNumberLabel.text  = [NSString  stringWithFormat:@"%ld",pro.procount];

    cell.priceLabel.text = [NSString  stringWithFormat:@"%.2f", pro.price];
    cell.packageLabel.text = [NSString stringWithFormat:@"%ld",pro.package];
    cell.nameLabel.text = pro.categoryTitle;
    
    if (pro.discount != 0) {
        cell.discountPrice.text = [NSString stringWithFormat:@"%.2f",pro.price*(10-pro.discount)/10];
        cell.discountUnit.hidden = NO;
        cell.takeOutLine.hidden = NO;
    }
    else
    {
        cell.discountPrice.text = @"";
        cell.discountUnit.hidden = YES;
        cell.takeOutLine.hidden = YES;
    }
    
    
    return cell;
}

//每一格的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(175, 200);
}

//每一格之间的相对位置
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(3,3, 3, 3);
}


- (void)addPackage:(ProductCell *)cell
{
    AppDelegate   *appdele = [UIApplication  sharedApplication].delegate ;
    NSIndexPath    *path = [self.collectionview   indexPathForCell:cell];
    NSInteger    loc = path.row + path.section *2 ;
    LLHProdoct   *apro   =self.products[loc];
    
    
    NSInteger     pack = [cell.packageLabel.text  integerValue]    ;
    NSInteger     result = [cell.clickNumberLabel.text  integerValue] + pack;
    apro.procount = result ;
    [appdele.auser addOrderPro:apro];
    
    CartShopView   *acart =appdele.shopview;
    
    acart.ordertotal.text = [NSString  stringWithFormat:@"%.2f",[appdele.auser orderprice]];
    [acart setShopHidden];
    
    [self.collectionview  reloadData];
}


-(void)reducePackage:(ProductCell*)cell
{
    AppDelegate   *appdele = [UIApplication  sharedApplication].delegate ;
    NSIndexPath    *path = [self.collectionview   indexPathForCell:cell];
    NSInteger    loc = path.row + path.section *2 ;
    LLHProdoct   *apro   =self.products[loc];
    
    
    NSInteger     pack = [cell.packageLabel.text  integerValue]    ;
    NSInteger     result = [cell.clickNumberLabel.text  integerValue] - pack;
    
    if (result  <= 0  ) {
        apro.procount = 0 ;
        [appdele.auser deletePro:apro];
        result = 0;
        [self.collectionview  reloadData];
        CartShopView   *acart =appdele.shopview;
        
        acart.ordertotal.text = [NSString  stringWithFormat:@"%.2f",[appdele.auser orderprice]];
        [acart setShopHidden];
        return  ;
    }
    apro.procount = result;
    [appdele.auser addOrderPro:apro];
    CartShopView   *acart =appdele.shopview;
    
    acart.ordertotal.text = [NSString  stringWithFormat:@"%.2f",[appdele.auser orderprice]];
    
    [acart setShopHidden];
    [self.collectionview  reloadData];
    
    
    
    
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger    loc = indexPath.row + indexPath.section *2 ;
    NSLog(@"%ld,%ld",indexPath.section,indexPath.row);
    LLHProdoct   *pro = self.products[loc];
    AppDelegate    *app  = [UIApplication  sharedApplication].delegate;
    app.goodscode = pro.goodsCode ;
    pro.isnewgoods = YES;
    [app.auser  addScanPro:pro];
    DetailsGoodViewController  *details= [[[NSBundle mainBundle]loadNibNamed:@"DetailsGoodViewController" owner:nil options:nil] firstObject];
    [self.navigationController   pushViewController:details animated:YES];
}
-(void)cartshopdetails:(CartShopView*)aview
{
    ShopViewController  *shop = [[ShopViewController  alloc]init];
    [self.navigationController  pushViewController:shop animated:YES];
    
    
}

-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    
    
    if (cycleScrollView.tag == 117) {
        NSInteger    urlcount = self.urls.count;
        if (index>urlcount-1) {
            return;
        }
        
        [[UIApplication sharedApplication] openURL:self.urls[index]];
    }
    else  if(cycleScrollView.tag == 118)
    {
        zuixingonggaoViewController  *zuixin = [[zuixingonggaoViewController  alloc]init];
        
        
        
        zuixin.text =self.gonggaocontent[index];
        [self.navigationController  pushViewController:zuixin animated:YES];
        
    }
    
    
    
}



@end
