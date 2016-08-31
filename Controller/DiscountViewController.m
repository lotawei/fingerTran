//
//  DiscountViewController.m
//  指尖叫货
//
//  Created by rimi on 16/6/22.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "DiscountViewController.h"
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
#import "ShopViewController.h"
#import "DetailsGoodViewController.h"
#import "SVProgressHUD.h"
#import "SVPullToRefresh.h"


@interface DiscountViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,CellProtocol,ShowViewDelegate>

@property(nonatomic)   int   page;
@end

@implementation DiscountViewController

-(NSMutableArray *)products
{
    if (_products==nil) {
        _products = [NSMutableArray  arrayWithCapacity:0];
    }
    return _products;
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    AppDelegate   *app = [UIApplication   sharedApplication].delegate;
    [app.auser changcount:self.products];
    
    app.shopview.delegate = self;
    [self.collectionview   reloadData];
   
    app.shopview.ordertotal.text = [NSString stringWithFormat:@"%.2f",[app.auser   orderprice]];
    [self.view addSubview:app.shopview];
    
    [self.view  bringSubviewToFront:app.shopview];
    
    
}
-(UICollectionView *)collectionview
{
    if (_collectionview==nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        _collectionview.backgroundColor  = [UIColor  redColor];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, 375, 675) collectionViewLayout:layout];
        [_collectionview registerNib:[UINib nibWithNibName:@"ProductCell" bundle:nil] forCellWithReuseIdentifier:@"ProductCell"];
        _collectionview.delegate = self;
        _collectionview.dataSource = self;
        
    }
    return _collectionview;
}


- (void)viewDidLoad {
    [super viewDidLoad];
     AppDelegate   *app = [UIApplication   sharedApplication].delegate;
    self.view.backgroundColor = [UIColor whiteColor];
    
//    AppDelegate   *app = [UIApplication  sharedApplication].delegate;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 40)];
    label.text = @"折扣促销";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor colorWithRed:0.2f green:0.55f blue:1.0f alpha:1];
    
    self.navigationItem.titleView = label;
    
    //添加右边navigation的button
    UIBarButtonItem *barbutton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"分类@2x.png"] style:UIBarButtonItemStylePlain target:self action:@selector(classify:)];
    self.navigationItem.rightBarButtonItem = barbutton;
    
    
    NSNumber *number = [NSNumber numberWithInt:self.page+1];
    [self.view  addSubview:self.collectionview];
    [SVProgressHUD  show];
    NSDictionary *dic = @{@"goodsStatusCode":@"3",
                          @"pageIndex":number,
                          @"pageSize":@20,
                          };
    
    [DataService   getdataService:[AllFunction  GetListByStatus] andparams:dic succeed:^(id response) {
          [SVProgressHUD  show];
        NSArray   *allpro =response[@"data"][0][@"List"];
        for (NSDictionary  *dic  in allpro) {
            LLHProdoct   *apro = [LLHProdoct  proWithdic:dic];
            [self.products  addObject:apro];
        }
        [SVProgressHUD  dismiss];
        [self.collectionview  reloadData];
    } failed:^(id error) {
        [SVProgressHUD  dismiss];
    }];
//    NSLog(@"%@",self.products);
    
    //注册上拉刷新功能
    __weak DiscountViewController *weakSelf = self;
    
    [self.collectionview addInfiniteScrollingWithActionHandler:^{
        if (weakSelf.page<11) {
            weakSelf.page ++;
            [weakSelf insertRowAtBottom];
        }

         [weakSelf.collectionview.infiniteScrollingView  stopAnimating];
//        [_tableView.pullToRefreshView setTitle:@"下拉以刷新" forState:SVPullToRefreshStateTriggered];
//        [_tableView.pullToRefreshView setTitle:@"不要命的加载中..." forState:SVPullToRefreshStateLoading];
    }];


    [self.view addSubview:app.shopview];
}

-(void)insertRowAtBottom
{
    __weak DiscountViewController *weakSelf = self;
    NSNumber   *number  = [NSNumber  numberWithInt:weakSelf.page];
    NSDictionary *dic = @{@"goodsStatusCode":@"3",
                          @"pageIndex":number,
                          @"pageSize":@20,
                          };
    
    [DataService   getdataService:[AllFunction  GetListByStatus] andparams:dic succeed:^(id response) {
        
        
        NSArray   *allpro =response[@"data"][0][@"List"];
        if (allpro.count <= 0) {
            [weakSelf.collectionview.pullToRefreshView setTitle:@"刷新完了呀" forState:SVPullToRefreshStateStopped];

        }
        for (NSDictionary  *dic  in allpro) {
            LLHProdoct   *apro = [LLHProdoct  proWithdic:dic];
            [weakSelf.products  addObject:apro];
            
        }
        [weakSelf.collectionview  reloadData];
        [weakSelf.collectionview.infiniteScrollingView  stopAnimating];
    } failed:^(id error) {
        
        
        
    }];
    

    
    
     [weakSelf.collectionview.infiniteScrollingView  stopAnimating];
}




-(void)classify:(UIBarButtonItem *)sender
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}




- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 2;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.products.count/2;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [SVProgressHUD  dismiss];
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
    
    
//    NSLog(@"%.2f",pro.discountprice);
//    NSLog(@"%ld",pro.discount);
    
    cell.discountPrice.text = [NSString stringWithFormat:@"%.2f",pro.price*(10-pro.discount)/10];
    cell.discountUnit.hidden = NO;
    cell.takeOutLine.hidden = NO;
    
    return cell;
}
-(void)viewDidLayoutSubviews
{
    AppDelegate   *app= [UIApplication sharedApplication].delegate;
    CartShopView   *aview =      [app.window  viewWithTag:1995];
    aview.ordertotal.text = [NSString  stringWithFormat:@"%.2f",[app.auser orderprice]];
    aview.delegate = self;
    [app.window bringSubviewToFront:[app.window  viewWithTag:1995]];
    self.collectionview.backgroundColor = [UIColor  whiteColor];
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
    NSIndexPath    *path = [self.collectionview   indexPathForCell:cell];
    NSInteger    loc = path.row + path.section *2 ;
    LLHProdoct   *apro   =self.products[loc];
    AppDelegate   *appdele = [UIApplication  sharedApplication].delegate ;
    
    NSInteger     pack = [cell.packageLabel.text  integerValue]    ;
    NSInteger     result = [cell.clickNumberLabel.text  integerValue] + pack;
    apro.procount = result ;
    [appdele.auser addOrderPro:apro];
    
    [self.collectionview  reloadData];
    CartShopView   *acart =appdele.shopview;
    
    acart.ordertotal.text = [NSString  stringWithFormat:@"%.2f",[appdele.auser orderprice]];
    [acart setShopHidden];
}


-(void)reducePackage:(ProductCell*)cell
{
    NSIndexPath    *path = [self.collectionview   indexPathForCell:cell];
    NSInteger    loc = path.row + path.section *2 ;
    LLHProdoct   *apro   =self.products[loc];
    AppDelegate   *appdele = [UIApplication  sharedApplication].delegate ;
    
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
    CartShopView   *acart =appdele.shopview;
    
    acart.ordertotal.text = [NSString  stringWithFormat:@"%.2f",[appdele.auser orderprice]];
    
    [acart setShopHidden];
    [self.collectionview  reloadData];
    
    
    
    
    
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
