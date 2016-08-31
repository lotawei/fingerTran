//
//  ShopViewController.m
//  指尖叫货
//
//  Created by rimi on 16/6/25.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "ShopViewController.h"
#import "AppDelegate.h"
#import "CartShopView.h"
#import "LLHProdoct.h"
#import "OrderProCell.h"
#import "CellProtocol.h"
#import "LLHProdoct.h"
#import "DataService.h"
#import "LoginViewController.h"
#import "UIImageView+WebCache.h"
#import "AllFunction.h"
#import "ConfirmOrderListViewController.h"
#import "DetailsGoodViewController.h"
#import "AddressManageViewController.h"
#import "ReceiverAddressViewController.h"
@interface ShopViewController ()

@end

@implementation ShopViewController



-(UIImageView *)xiadanimg
{
    if (_xiadanimg==nil) {
        _xiadanimg =[[UIImageView  alloc]initWithImage:[UIImage  imageNamed:@"下单.png"]];
        [_xiadanimg sizeToFit];

    }
    return _xiadanimg ;

}
-(OrderDeatilView *)orderview
{
    if (_orderview==nil) {
        _orderview = [[[NSBundle  mainBundle]loadNibNamed:@"OrderDeatilView" owner:nil options:nil] firstObject];
        [_orderview setFrame:CGRectMake(0, 70, 375, 200)];
    }
    return _orderview;

}

-(UITableView *)tableview
{
    if (!_tableview) {
        _tableview = [[UITableView  alloc]initWithFrame:CGRectMake(8, 250    , CGRectGetMaxX(self.view.frame),CGRectGetHeight(self.view.frame)-CGRectGetMaxY(self.orderview.frame)) style:UITableViewStylePlain];
//        _tableview.backgroundColor = [UIColor grayColor];
      
    }
    return _tableview ;
}



-(void)viewDidLayoutSubviews
{
    AppDelegate   *appdelegate  = [UIApplication  sharedApplication].delegate;
    
    
    CartShopView   *shopview =     [appdelegate.window viewWithTag:1995];
    shopview.hidden = YES;
    
    UIBarButtonItem  *image =[[UIBarButtonItem  alloc]initWithCustomView:self.xiadanimg];
  
 
    self.navigationItem.rightBarButtonItem = image;
    UIView   *titleview = [[UIView  alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
    titleview.backgroundColor = [UIColor  whiteColor];
    UILabel   *lab =  [[UILabel   alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
    lab.text = @"购物车";
    lab.font = [UIFont systemFontOfSize:20];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.textColor = [UIColor colorWithRed:0.2f green:0.55f blue:1.0f alpha:1];
    [titleview sizeToFit];
    titleview.backgroundColor = [UIColor  clearColor];
    [titleview addSubview:lab];
    
    
    self.navigationItem.titleView = titleview;
}
-(void)xiadan:(UITapGestureRecognizer*)sender
{
    //向服务器下单
    //1.  判断当前用户是否登录2.判断服武器是否能返回一个默认地址
    
    AppDelegate   * app = [UIApplication  sharedApplication].delegate;
    if (app.auser.isOnline) {
        //构造我的json   向服务器下单
        //查看是否有默认地址
        
    NSDictionary  *defaultaddr =    [[NSUserDefaults  standardUserDefaults]objectForKey:@"DefaultAddress"];
        
        
        
        if (defaultaddr==nil) {
            
            UIAlertController  *con = [UIAlertController alertControllerWithTitle:@"请先填写默认收货地址" message:nil
                                                                   preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction   *cancle  = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            [con addAction:cancle];
            UIAlertAction   *address  = [UIAlertAction  actionWithTitle:@"请设置收货地址" style:0 handler:^(UIAlertAction * _Nonnull action) {
                 AddressManageViewController  *dress =[[AddressManageViewController  alloc]init];
                [self.navigationController  pushViewController:dress animated:YES];
            }];
            [con addAction:address];
            
            [self presentViewController:con animated:YES completion:nil];
            
            }
        
   //有默认地址
    else{
        
        ConfirmOrderListViewController  *confirm= [[[NSBundle mainBundle]loadNibNamed:@"ConfirmOrderListViewController" owner:nil options:nil] firstObject];
        [self.navigationController   pushViewController:confirm animated:YES];
        }
    }
    else
    {
        UIAlertController  *con = [UIAlertController alertControllerWithTitle:@"你还未登录，请先登录" message:nil
                                                               preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction   *cancle  = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [con addAction:cancle];
        UIAlertAction   *login  = [UIAlertAction actionWithTitle:@"登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            LoginViewController  *login = [[LoginViewController alloc ]init];
            [self.navigationController  pushViewController:login animated:YES];
        }];
        [con addAction:login];
        
        
        [self presentViewController:con animated:YES completion:nil];
    }
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    AppDelegate   *app = [UIApplication  sharedApplication].delegate;
    

    [self.view addSubview:self.orderview];
    [self.view addSubview:self.tableview];
    [self.tableview   registerNib:[UINib  nibWithNibName:@"OrderProCell" bundle:nil] forCellReuseIdentifier:@"OrderProCell"];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    
    [self  yunfeicaculator:[app.auser orderprice]];
    //完成赋值操作
   
    [self  checkxiadan];
    
    UITapGestureRecognizer   *atap = [[UITapGestureRecognizer  alloc]initWithTarget:self action:@selector(xiadan:)];
    [self.xiadanimg addGestureRecognizer:atap];
    [self.tableview reloadData];
    
    
}
//将要出现的时候更改
-(void)viewWillAppear:(BOOL)animated
{
    [self.tableview reloadData];
    [self  setinfo];
    
    
    
}
-(void)viewWillDisappear:(BOOL)animated{
    AppDelegate   *app = [UIApplication  sharedApplication].delegate;
    app.auser.yunfei = self.yunfei;
    app.auser.xiandanjine = [self.orderview.totalprice.text doubleValue];
    
}
-(void)yunfeicaculator:(double)price
{
   
    [DataService   getdataService:[AllFunction   Freight] andparams:nil succeed:^(id response) {
       
        for (NSDictionary  *dic in response[@"data"]) {
            NSInteger   min  = [dic[@"MinMoney"] integerValue];
            NSInteger   max = [dic[@"MaxMoney"] integerValue];
            
            if (price==0) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.yunfei = 0;
                    [self  setinfo];
                });
               
            }
            if (price>=min&&price<=max) {
                dispatch_async(dispatch_get_main_queue(), ^{
                     self.yunfei = [dic[@"Price"] integerValue];
                    [self  setinfo];
                });
                
              
           
            }
            else{
            dispatch_async(dispatch_get_main_queue(), ^{
                self.yunfei = 0;
                [self  setinfo];
            });
            }
            
        }
        
        
        
        
        
        
    } failed:^(id error) {
        
    }];
    
   
    
}
-(void)setinfo
{
    
    AppDelegate   *app = [UIApplication  sharedApplication].delegate;
    
    
   
        self.orderview.shuliang.text = [NSString  stringWithFormat:@"%ld",[app.auser  ordercount]];
        self.orderview.xiaoji.text = [NSString  stringWithFormat:@"%.2f",[app.auser  orderprice]];
        self.orderview.totalprice.text =[NSString  stringWithFormat:@"%.2f",[app.auser  orderprice]+self.yunfei];
        
        
   
        self.orderview.yunfei.text =self.yunfei>0 ?[NSString  stringWithFormat:@"%ld",self.yunfei]:@"0";
        self.orderview.tishi.text =   self.yunfei>0 ?[NSString  stringWithFormat:@"%ld",self.yunfei]:@"免运费";
        

   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate    *app  = [UIApplication  sharedApplication].delegate;
    NSArray   *pros =  app.auser.orderproducts ;
    LLHProdoct   *pro = pros[indexPath.row];
  
    app.goodscode = pro.goodsCode ;
    [app.auser addScanPro:pro];
    DetailsGoodViewController  *details= [[[NSBundle mainBundle]loadNibNamed:@"DetailsGoodViewController" owner:nil options:nil] firstObject];
    [self.navigationController   pushViewController:details animated:YES];

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    
    AppDelegate   *appdelegate  = [UIApplication  sharedApplication].delegate;
    
    return appdelegate.auser.orderproducts.count;
}
-(OrderProCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    AppDelegate   *app = [UIApplication    sharedApplication].delegate;
  LLHProdoct  *pro =    app.auser.orderproducts[indexPath.row];
    OrderProCell   *cell =[tableView  dequeueReusableCellWithIdentifier:@"OrderProCell"] ;
    if (cell==nil) {
        cell = [[OrderProCell  alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"OrderProCell"];
        
    }
    cell.acount.tag = indexPath.row;
    cell.delegate = self;
    cell.proname.text = pro.title;
    cell.proprice.text = [NSString   stringWithFormat:@"%0.2f",pro.price];
    cell.pack.text =  [NSString   stringWithFormat:@"%ld",pro.package]; ;
    cell.acount.text =[NSString  stringWithFormat:@"%ld",pro.procount];
    [cell.proimg sd_setImageWithURL:[NSURL  URLWithString:pro.imageUrl] placeholderImage:[UIImage imageNamed:@"place.png"]];
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (void)addPackage:(OrderProCell *)cell
{
    
     AppDelegate   *appdele = [UIApplication  sharedApplication].delegate ;
    
    NSIndexPath    *path = [self.tableview   indexPathForCell:cell];
    
    NSArray   *arr = appdele.auser.orderproducts;
  
    if (arr.count>0) {
        LLHProdoct   *apro   =arr[path.row];
        
        
        NSInteger     pack = [cell.pack.text  integerValue]    ;
        NSInteger     result = [cell.acount.text  integerValue] + pack;
        apro.procount = result ;
        [appdele.auser addOrderPro:apro];
    }
    [self.tableview  reloadData];
    [self yunfeicaculator:[appdele.auser orderprice ] ];
    [  self checkxiadan ];
    
    
    
}


-(void)reducePackage:(OrderProCell*)cell
{
 

    AppDelegate   *appdele = [UIApplication  sharedApplication].delegate ;
    NSArray    *arr = appdele.auser.orderproducts;
    
    if (arr.count>0) {
        NSIndexPath    *path = [self.tableview  indexPathForCell:cell];
 
        
        LLHProdoct   *apro   =arr[path.row];
        
        
        NSInteger     pack = [cell.pack.text  integerValue]    ;
        NSInteger     result = [cell.acount.text  integerValue] - pack;
        
        if (result  <=  0  ) {
            apro.procount = 0 ;
            [appdele.auser deletePro:apro];
          
            result = 0;
            [self.tableview  reloadData];
            [self yunfeicaculator:[appdele.auser orderprice ] ];
            [  self checkxiadan ];
            return  ;
        }
        apro.procount = result;
        [appdele.auser addOrderPro:apro];
    }
   
    
    [self.tableview  reloadData];
        [self yunfeicaculator:[appdele.auser orderprice ] ];
       [  self checkxiadan ];
    
    
    
    
}
-(void)checkxiadan
{
      AppDelegate   *appdele = [UIApplication  sharedApplication].delegate ;
    NSArray    *arr = appdele.auser.orderproducts;
    if (arr) {
        self.xiadanimg.hidden =   arr.count==0  ? YES:NO ;
    }
    else
    {
       self.xiadanimg.hidden =  YES;
        
    }
    
}




@end
