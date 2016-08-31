//
//  CateGoryViewController.m
//  指尖叫货
//
//  Created by rimi on 16/6/22.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "CateGoryViewController.h"
#import "AllFunction.h"
#import "AppDelegate.h"
#import "DetailsGoodViewController.h"
#import "SlideHeadView.h"
#import "NewGoodsViewController.h"
#import "DiscountViewController.h"
#import "AllGoodsViewController.h"
#import "LLHCateGoryPro.h"
#import "UIImageView+WebCache.h"
#import "SearchTableViewCell.h"
#import "DataService.h"
#import "CateGoryCell.h"
#import "SVProgressHUD.h"
#import "KindofViewController.h"

@interface CateGoryViewController ()<UITableViewDelegate,UITableViewDataSource>



@end

@implementation CateGoryViewController

-(NSMutableDictionary *)muludic
{
    if (_muludic==nil) {
        _muludic= [NSMutableDictionary   dictionaryWithCapacity:0];
    }
    return _muludic;
}

-(NSString *)yijiTitile
{
    if (_yijiTitile==nil) {
        _yijiTitile = @"";
    }
    return _yijiTitile;
}

-(ShowView *)categery
{
    if (_categery == nil) {
        _categery = [[NSBundle  mainBundle]loadNibNamed:@"ShowView" owner:self options:nil].firstObject;
        [_categery setFrame:CGRectMake(CGRectGetMaxX(self.allgoods.frame)+10, 70, 80, 60)];
        _categery.imageview.image = [UIImage imageNamed:@"首页_分类.png"];
        _categery.tag = 1002;
        
        UITapGestureRecognizer  *atap = [[UITapGestureRecognizer  alloc]initWithTarget:self action:@selector(gotodetail:)];
        [_categery addGestureRecognizer:atap];
    }
    return _categery;
}
-(ShowView *)dicountgoods
{
    if (_dicountgoods == nil) {
        _dicountgoods = [[NSBundle  mainBundle]loadNibNamed:@"ShowView" owner:self options:nil].firstObject;
        [_dicountgoods setFrame:CGRectMake(CGRectGetMaxX(self.newgoods.frame)+10, 70, 80, 60)];
        _dicountgoods.imageview.image = [UIImage imageNamed:@"折扣促销.png"];
        _dicountgoods.tag = 1004;
        
        UITapGestureRecognizer  *atap = [[UITapGestureRecognizer  alloc]initWithTarget:self action:@selector(gotodetail:)];
        [_dicountgoods addGestureRecognizer:atap];
    }
    return _dicountgoods;
}
-(ShowView *)newgoods
{
    if (_newgoods == nil) {
        _newgoods = [[NSBundle  mainBundle]loadNibNamed:@"ShowView" owner:self options:nil].firstObject;
        [_newgoods setFrame:CGRectMake(CGRectGetMaxX(self.categery.frame)+10, 70, 80, 60)];
        _newgoods.imageview.image = [UIImage imageNamed:@"本月新品.png"];
        _newgoods.tag = 1003;
        UITapGestureRecognizer  *atap = [[UITapGestureRecognizer  alloc]initWithTarget:self action:@selector(gotodetail:)];
        
        [_newgoods addGestureRecognizer:atap];
        
        
        
        
    }
    return _newgoods;
}
-(ShowView *)allgoods
{
    if (_allgoods == nil) {
        _allgoods = [[NSBundle  mainBundle]loadNibNamed:@"ShowView" owner:self options:nil].firstObject;
        [_allgoods setFrame:CGRectMake(8,70, 80, 60)];
        _allgoods.imageview.image = [UIImage imageNamed:@"全部商品.png"];
        _allgoods.tag = 1001;
        
        UITapGestureRecognizer  *atap = [[UITapGestureRecognizer  alloc]initWithTarget:self action:@selector(gotodetail:)];
        [_allgoods addGestureRecognizer:atap];
        
        
    }
    return _allgoods;
}


-(NSMutableArray *)yijiarr
{
    if (_yijiarr==nil) {
        _yijiarr = [NSMutableArray  arrayWithCapacity:0];
        
    }
    return _yijiarr;
}
-(NSMutableArray *)products
{
    if (_products==nil) {
        _products=[NSMutableArray  arrayWithCapacity:0];
    }
    return _products;
}
-(UITableView*)tab1
{
    if (_tab1 == nil) {
        _tab1 = [[UITableView   alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.allgoods.frame), 120, 500) style:UITableViewStylePlain];
        _tab1.separatorStyle = NO;
        _tab1.tag = 1001;
        _tab1.backgroundColor = [UIColor whiteColor];
        _tab1.delegate = self;
        _tab1.dataSource = self;
    }
    return _tab1 ;
}
-(UITableView *)tab2
{
    if (_tab2==nil) {
        _tab2 = [[UITableView   alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.tab1.frame), CGRectGetMaxY(self.allgoods.frame), CGRectGetMaxY(self.view.frame)-CGRectGetWidth(self.tab1.frame), 500) style:UITableViewStylePlain];
        _tab2.separatorStyle = NO;
        _tab2.delegate = self;
        _tab2.dataSource= self;
        _tab2.tag = 1002;
        [_tab2  registerNib:[UINib  nibWithNibName:@"CateGoryCell" bundle:nil] forCellReuseIdentifier:@"CateGoryCell"];
    }
    return _tab2;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor  whiteColor];
    // Do any additional setup fter loading the view.
    [self.view addSubview:self.allgoods];
    [self.view addSubview:self.newgoods];
    [self.view addSubview:self.dicountgoods];
    [self.view addSubview:self.categery];
    
   
    [self.view addSubview:self.tab1];
    [self.view addSubview:self.tab2];
    
    //获取一级分类 名称
    [DataService  getdataService:[AllFunction  Category] andparams:nil succeed:^(id response) {
        NSArray  *arr = response[@"data"];
        for (NSDictionary   *adic in arr) {
            NSString   *str = adic[@"Title"];
            [self.yijiarr addObject:str
             ];
            [self.tab1   reloadData];
            //将数据取出来做成字典
            NSArray   *arr = adic[@"Children"];
 
            NSMutableArray   *pros = [NSMutableArray  arrayWithCapacity:0];
            for (NSDictionary  *dic in arr) {
                LLHCateGoryPro   *apro  = [LLHCateGoryPro categoryWithdic:dic];
                [pros  addObject:apro  ];
            }
            [self.muludic  setObject:pros forKey:str];
        }
        
        
        
    } failed:^(id error) {
        UIAlertController  *con = [UIAlertController alertControllerWithTitle:@"获取分类失败" message:nil
                                                               preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction   *cancle  = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [con addAction:cancle];
        [self presentViewController:con animated:YES completion:nil];
    }];
    
    //left
//    UISwipeGestureRecognizer   *left =[[UISwipeGestureRecognizer  alloc]initWithTarget:self action:@selector(left)];
//    
//    left.direction =  UISwipeGestureRecognizerDirectionLeft;
//    
//    //right
//      UISwipeGestureRecognizer   *right =[[UISwipeGestureRecognizer  alloc]initWithTarget:self action:@selector(right)];
//    right.direction =  UISwipeGestureRecognizerDirectionRight;
//    
//    
//    
//    
//    [self.view addGestureRecognizer:left];
//    [self.view addGestureRecognizer:right];
    
    
    
}
//
//-(void)left
//{
//    [UIView  animateWithDuration:0.5 animations:^{
//        
//        self.tab1.transform = CGAffineTransformMakeTranslation(-100, CGRectGetMaxY(self.allgoods.frame));
//
//    }];
//}
//
//-(void)right
//{
//    [UIView  animateWithDuration:0.5 animations:^{
//        
//        [self.tab1   setFrame:CGRectMake(-100, 100, 150, 400) ];
//    
//    }];
//}



-(void)gotodetail:(UITapGestureRecognizer *)sender
{
    ShowView   * ah = (ShowView*)sender.view;
    
    //所有商品列表
    if (ah.tag == 1001) {
        [self.navigationController  pushViewController:[[AllGoodsViewController  alloc]init] animated:YES];
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

//
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return   1;

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView.tag == 1001)
    {
        return self.yijiarr.count;
    }
    else  if(tableView.tag ==1002)
    {
        return  self.products.count;
    }
    return 0;
}
-(UITableViewCell* )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static  NSString *identity = @"yijicell";
     UITableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:identity];
    if (tableView.tag == 1001) {

       cell = [tableView dequeueReusableCellWithIdentifier:identity];
        if (cell==nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identity];
            
        }
        cell.textLabel.text = self.yijiarr[indexPath.row];
        cell.backgroundColor = [UIColor colorWithRed:0.8617 green:0.9633 blue:0.936 alpha:1.0];
      
        return cell;
        
    }
    else if(tableView.tag == 1002)
    {
    static  NSString *dentity = @"CateGoryCell";
        
   
       CateGoryCell     *bcell = [tableView dequeueReusableCellWithIdentifier:dentity];
        if (cell==nil) {
               bcell = [tableView dequeueReusableCellWithIdentifier:dentity];
        }
        LLHCateGoryPro   *apro =  self.products[indexPath.row];
   
        bcell.title.text = apro.title;
       
        [bcell.img sd_setImageWithURL:[NSURL  URLWithString:apro.imageUrl] placeholderImage:[UIImage  imageNamed:@"place.png"]];
        bcell.total.text = [NSString  stringWithFormat:@"%ld",apro.total];
        
     
        return bcell;
        
    }
    
    return nil ;


}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //
    
    if (tableView.tag == 1001) {
        
        self.yijiTitile = self.yijiarr[indexPath.row];
        NSArray    *products = [self.muludic objectForKey:_yijiTitile];
        [self.products removeAllObjects];
        for (LLHCateGoryPro  *apro in products) {
            [self.products addObject:apro];
        }
        [self.tab2 reloadData];
        return  ;

    }
    else if(tableView.tag == 1002)
    {
        
        
//        LLHCateGoryPro    *pro = self.products[indexPath.row];
//        NSString   *key = self.yijiarr[indexPath.row];
        NSLog(@"%@",self.yijiTitile);
        NSArray    *products = [NSArray arrayWithArray:[self.muludic objectForKey:self.yijiTitile]];

        
        AppDelegate   *app = [UIApplication   sharedApplication].delegate;
        [app.catedic removeAllObjects];
        [app.catedic setObject:products forKey:self.yijiTitile];
        
        app.pos = indexPath.row;
        app.oneLevelTitle = self.yijiTitile;
        
        KindofViewController   *kind = [[KindofViewController   alloc]init];
        [self.navigationController   pushViewController:kind animated:YES];
        
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 1002) {
        return 80;
    }
    return 70;
}


@end
