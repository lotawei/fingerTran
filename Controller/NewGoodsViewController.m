//
//  NewGoodsViewController.m
//  指尖叫货
//
//  Created by rimi on 16/6/22.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "NewGoodsViewController.h"
#import "AppDelegate.h"
#import "LLHProdoct.h"
#import "UIImageView+WebCache.h"
#import "DetailsGoodViewController.h"
#import "ShowViewDelegate.h"
#import "ShopViewController.h"
@interface NewGoodsViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,CellProtocol,ShowViewDelegate>

@end

@implementation NewGoodsViewController







-(NSMutableArray *)products
{
    
        _products = [NSMutableArray   arrayWithCapacity:0];
        AppDelegate  *app = [UIApplication  sharedApplication].delegate;
        NSArray   * pros = app.auser.scanproducts ;
        for (LLHProdoct  *apro in pros) {
            if (apro.isnewgoods) {
                [_products addObject:apro];
            }
        }
    
    return _products;
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    AppDelegate   *app = [UIApplication   sharedApplication].delegate;
   
    [app.auser changcount:self.products];
    
    CartShopView   * aview =  app.shopview;
    aview.delegate = self;
    [self.collectionview   reloadData];
      aview.ordertotal.text = [NSString  stringWithFormat:@"%.2f",[app.auser orderprice]];
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

-(void)viewDidLayoutSubviews
{
    AppDelegate   *app= [UIApplication sharedApplication].delegate;
    CartShopView   *aview =      app.shopview;
    aview.ordertotal.text = [NSString  stringWithFormat:@"%.2f",[app.auser orderprice]];
    aview.delegate = self;
    self.collectionview.backgroundColor = [UIColor  whiteColor];
   
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 40)];
    label.text = @"本月新品";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor colorWithRed:0.2f green:0.55f blue:1.0f alpha:1];
    
    self.navigationItem.titleView = label;
    
    //添加右边navigation的button
    UIBarButtonItem *barbutton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"分类@2x.png"] style:UIBarButtonItemStylePlain target:self action:@selector(classify:)];
    self.navigationItem.rightBarButtonItem = barbutton;
    
    [self.view  addSubview:self.collectionview];
    
}

-(void)classify:(UIBarButtonItem *)sender
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ProductCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ProductCell" forIndexPath:indexPath];
    NSInteger    loc = 2*indexPath.section + indexPath.row;
    if (loc==self.products.count) {
        cell.hidden = YES ;
        
    
        
        
        return cell;
    }
   
    LLHProdoct   *pro = self.products[loc];
    cell.delegate = self;
    cell.hidden = NO ;
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
    
    cell.discountPrice.text = [NSString stringWithFormat:@"%.2f",pro.price*(10-pro.discount)/10];
    cell.discountUnit.hidden = NO;
    cell.takeOutLine.hidden = NO;
    
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
    NSLog(@"%ld啊实打实的",self.products.count);
    
    acart.ordertotal.text = [NSString  stringWithFormat:@"%.2f",[appdele.auser orderprice]];
   
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
    [self.collectionview  reloadData];
    CartShopView   *acart =appdele.shopview;
    
    acart.ordertotal.text = [NSString  stringWithFormat:@"%.2f",[appdele.auser orderprice]];

    
    
    
    
    
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
