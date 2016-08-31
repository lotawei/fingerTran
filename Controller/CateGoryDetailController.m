//
//  CateGoryDetailController.m
//  指尖叫货
//
//  Created by rimi on 16/6/28.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "CateGoryDetailController.h"
#import "ProductCell.h"
#import "AppDelegate.h"
#import "DataService.h"
#import "AllFunction.h"
#import "LLHProdoct.h"
#import "SVProgressHUD.h"
#import "CartShopView.h"
#import "ShowViewDelegate.h"
#import "CartShopView.h"
#import "UIImageView+WebCache.h"
#import "DetailsGoodViewController.h"
#import "ShopViewController.h"
#import "CartShopView.h"
#import "SVPullToRefresh.h"

@interface CateGoryDetailController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,CellProtocol,ShowViewDelegate,UIScrollViewDelegate>

@property(nonatomic)  int   page  ;

@end

@implementation CateGoryDetailController
-(NSMutableArray *)products
{
    if (_products==nil) {
        _products = [NSMutableArray  arrayWithCapacity:0];
    }
    return _products;
    
    
}


-(UICollectionView *)collectionview
{
    if (_collectionview==nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        _collectionview.backgroundColor  = [UIColor  redColor];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, 375, 575) collectionViewLayout:layout];
        [_collectionview registerNib:[UINib nibWithNibName:@"ProductCell" bundle:nil] forCellWithReuseIdentifier:@"ProductCell"];
        _collectionview.delegate = self;
        _collectionview.dataSource = self;
        _collectionview.alwaysBounceVertical = YES;
        
    }
    return _collectionview;
}

-(void)viewWillAppear:(BOOL)animated
{
    self.collectionview.backgroundColor = [UIColor  whiteColor];
    AppDelegate   *app= [UIApplication sharedApplication].delegate;
    
    
    
    app.shopview.delegate  = self;
    [app.auser  changcount:self.products];
    app.shopview.ordertotal.text = [NSString stringWithFormat:@"%.2f",[app.auser   orderprice]];
    [self.collectionview  reloadData];
    [self.view addSubview:app.shopview];
    [self.view  bringSubviewToFront:app.shopview];
    self.original = app.shopview.frame;
   [app.shopview setFrame:CGRectMake(20, 450, 60, 60)];
    
    
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [SVProgressHUD  dismiss];
}
-(void)viewDidDisappear:(BOOL)animated
{
    
    AppDelegate   *app = [UIApplication   sharedApplication].delegate;
    for (LLHProdoct  *pro in self.products) {
        [app.auser  addOrderPro:pro];
    }
    [app.shopview setFrame:self.original];
    
}


-(void)viewDidLoad
{
    AppDelegate   *app = [UIApplication   sharedApplication].delegate;
    [self.view  addSubview:self.collectionview];
    
    NSNumber   *number  = [NSNumber  numberWithInt:self.page+1];
    
    NSDictionary *params = @{@"categoryTitle":self.categoryTitle,
                            @"pageIndex":number,
                            @"pageSize":@(20)
                             };
    
    
    [DataService   getdataService:[AllFunction  GetListByCategory] andparams:params succeed:^(id response) {
        [SVProgressHUD  show];
        
        NSArray   *allpro =response[@"data"][0][@"List"];
        for (NSDictionary  *dic  in allpro) {
            LLHProdoct   *apro = [LLHProdoct  proWithdic:dic];
            [self.products  addObject:apro];
            
        }
        [app.auser   changcount:self.products];
        [SVProgressHUD  dismiss];
        [self.collectionview  reloadData];
    } failed:^(id error) {
        
    }];
    //注册上拉刷新功能
    __weak CateGoryDetailController *weakSelf = self;
    
    [self.collectionview addInfiniteScrollingWithActionHandler:^{
        if (weakSelf.page<11) {
            weakSelf.page ++;
            [weakSelf insertRowAtBottom];
        }
        
        
    }];
    
    
    
}

-(void)insertRowAtBottom
{
    __weak CateGoryDetailController *weakSelf = self;
    NSNumber   *number  = [NSNumber  numberWithInt:weakSelf.page];
    
    NSDictionary *params = @{@"categoryTitle":self.categoryTitle,
                             @"pageIndex":number,
                             @"pageSize":@(20)
                             };
    
    [DataService   getdataService:[AllFunction  GetListByCategory] andparams:params succeed:^(id response) {
        
        
        NSArray   *allpro =response[@"data"][0][@"List"];
        for (NSDictionary  *dic  in allpro) {
            LLHProdoct   *apro = [LLHProdoct  proWithdic:dic];
            [weakSelf.products  addObject:apro];
            
        }
        [weakSelf.collectionview  reloadData];
        [weakSelf.collectionview.infiniteScrollingView  stopAnimating];
    } failed:^(id error) {
        
    }];
    
    
}




- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 2;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.products.count/2;
}

//每格上的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ProductCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ProductCell" forIndexPath:indexPath];
    NSInteger    loc = 2*indexPath.section + indexPath.row;
    
    LLHProdoct   *pro = self.products[loc];
    cell.delegate = self;
    
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
    
    [self.collectionview  reloadData];
    [acart setShopHidden];
}


-(void)reducePackage:(ProductCell*)cell
{
    AppDelegate   *appdele = [UIApplication  sharedApplication].delegate ;
    NSIndexPath    *path = [self.collectionview   indexPathForCell:cell];
    NSInteger    loc = path.row + path.section *2 ;
    LLHProdoct   *apro   =self.products[loc];
    
    
    NSInteger     pack = [cell.packageLabel.text  integerValue]    ;
    NSInteger     result = [cell.clickNumberLabel.text  integerValue] - pack;
    
    if (result  <=  0  ) {
        apro.procount = 0 ;
        [appdele.auser deletePro:apro];
        result = 0;
        CartShopView   *acart =appdele.shopview;
        acart.ordertotal.text = [NSString  stringWithFormat:@"%.2f",[appdele.auser orderprice]];
        
        
        [self.collectionview  reloadData];
        return  ;
    }
    apro.procount = result;
    [appdele.auser addOrderPro:apro];
    CartShopView      *acart =appdele.shopview;
    
    acart.ordertotal.text = [NSString  stringWithFormat:@"%.2f",[appdele.auser orderprice]];
    
    
    [self.collectionview  reloadData];
    
    [acart setShopHidden];
    
    
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger    loc = indexPath.row + indexPath.section *2 ;
    LLHProdoct   *pro = self.products[loc];
    AppDelegate    *app  = [UIApplication  sharedApplication].delegate;
    app.goodscode = pro.goodsCode ;
    [app.auser addScanPro:pro];
    DetailsGoodViewController  *details= [[[NSBundle mainBundle]loadNibNamed:@"DetailsGoodViewController" owner:nil options:nil] firstObject];
    [self.navigationController   pushViewController:details animated:YES];
}
-(void)cartshopdetails:(CartShopView*)aview
{
    ShopViewController  *shop = [[ShopViewController  alloc]init];
    [self.navigationController  pushViewController:shop animated:YES];
    
    
}


@end
