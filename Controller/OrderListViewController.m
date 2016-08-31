//
//  OrderListViewController.m
//  指尖叫货
//
//  Created by rimi on 16/6/22.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "OrderListViewController.h"
#import "OrderTableViewCell.h"
#import "DataService.h"
#import "AllFunction.h"
#import "AppDelegate.h"
#import "LLHOrder.h"
#import "SVPullToRefresh.h"
#import "OrderListDetailsViewController.h"


@interface OrderListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSMutableArray *orderArray;

@property(nonatomic)int page;
@end

@implementation OrderListViewController

-(NSMutableArray *)orderArray
{
    if (!_orderArray) {
        _orderArray = [[NSMutableArray alloc]initWithCapacity:0];
    }
    return _orderArray;
}

-(void)getOrderFromNet
{
    AppDelegate    *app = [UIApplication  sharedApplication].delegate;
    NSString *customerId = app.auser.coustomerId;
    
    NSNumber   *number  = [NSNumber  numberWithInt:self.page+1];
    NSDictionary *dic = @{@"status":self.status,
                          @"customerId":customerId,
                          @"pageIndex":number,
                          @"pageSize":@20,
                          @"salemanId":@""
                          };
//    NSLog(@"%@===%@",[AllFunction GetOrderList],dic);
    [DataService getLaunchdataService:[AllFunction GetOrderList] andparams:dic succeed:^(id response) {
      
        
        NSArray *orderArr = response[@"data"][0][@"List"];
        NSLog(@"%@",orderArr);
        
        for (int i = 0; i<orderArr.count; i++) {
             LLHOrder *order = [LLHOrder orderWithdic:orderArr[i]];
          
            
            [self.orderArray addObject:order];
            
            [self.tableView reloadData];
        }
        
//        NSLog(@"获取数据中 的self  order array  %@",self.orderArray);
        
//        for (NSDictionary *dic in orderArr) {
//            LLHOrder *order = [LLHOrder orderWithdic:dic];
//            
//            NSLog(@"goodlist ============%@",order.goodList);
////            NSLog(@"goodlist ============  %@",orderArr[i][@"GoodsList"]);
//            
//            [self.orderArray addObject:order];
//            [self.tableView  reloadData];
//        }
        
//        NSLog(@"%@",self.orderArray);
        
    } failed:^(id error) {
        
    }];
    
    
    //注册上拉刷新功能
    __weak OrderListViewController *weakSelf = self;
    
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        if (weakSelf.page<11) {
            weakSelf.page ++;
            [weakSelf insertRowAtBottom];
        }
        
        [weakSelf.tableView.infiniteScrollingView  stopAnimating];
        //        [_tableView.pullToRefreshView setTitle:@"下拉以刷新" forState:SVPullToRefreshStateTriggered];
        //        [_tableView.pullToRefreshView setTitle:@"不要命的加载中..." forState:SVPullToRefreshStateLoading];
    }];

    
    
//    NSLog(@"self orderArray : %@",self.orderArray);
}

-(void)insertRowAtBottom
{
    __weak OrderListViewController *weakSelf = self;
    NSNumber   *number  = [NSNumber  numberWithInt:weakSelf.page];
    
    AppDelegate    *app = [UIApplication  sharedApplication].delegate;
    NSString *customerId = app.auser.coustomerId;
    NSDictionary *dic = @{@"status":self.status,
                          @"customerId":customerId,
                          @"pageIndex":number,
                          @"pageSize":@20,
                          @"salemanId":@""
                          };
    [DataService   getLaunchdataService:[AllFunction  GetOrderList] andparams:dic succeed:^(id response) {
        
        
        NSArray   *allorder =response[@"data"][0][@"List"];
        
        NSLog(@"__weak order %@",response[@"data"]);
        
        for (int i = 0; i<allorder.count; i++) {
            LLHOrder *order = [LLHOrder orderWithdic:allorder[i]];
            
            
            [weakSelf.orderArray addObject:order];
        }

        [weakSelf.tableView  reloadData];
        [weakSelf.tableView.infiniteScrollingView  stopAnimating];
    } failed:^(id error) {
        
    }];
    
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getOrderFromNet];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.tableView];
    
//    NSLog(@"%@",self.tableView);
    
    
}

-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetMaxX(self.view.frame), CGRectGetHeight(self.view.frame)-110) style:UITableViewStylePlain];
        
        _tableView.delegate = self;
        _tableView.dataSource =self;
        
    }
    return _tableView;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.orderArray.count;
//    return 1;
}

//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return 5.f;
//}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90.f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *dataSourceIdentify = @"dataSource";
    
    LLHOrder *order = self.orderArray[indexPath.row];
    
//    NSLog(@"%@",dic);
    
    OrderTableViewCell *cell = (OrderTableViewCell *)[tableView dequeueReusableCellWithIdentifier:dataSourceIdentify];//从缓存中获取与重用
    
    if ( cell==nil) {
        cell = [[OrderTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:dataSourceIdentify];
    }
    
    NSString *str1 = order.orderId;
    double price = 0;
    NSInteger quantity = 0;
    
    NSArray *goodlistarray = order.goodList;
    if (goodlistarray.count > 0) {
        for (LLHGoodsList *dic in goodlistarray) {
            price += [dic.amount doubleValue];
            quantity += dic.quantity;
        }
    }
    
    NSString *str2 = [NSString stringWithFormat:@"%.2f",price];
    NSString *str3 = order.addDate;
    NSString *str4 = [NSString stringWithFormat:@"%ld",quantity];
    
    
    NSLog(@"dingdanhao :%@, jiaqian  ,  shijian %@,  shuliang ",str1,str3);
    
    
    cell.orderDic = @{
                      @"id":str1,
                      @"price":str2,
                      @"date":str3,
                      @"quantity":str4
                      };
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return  cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
   LLHOrder    *order = self.orderArray[indexPath.row];
    
    OrderListDetailsViewController  *details= [[[NSBundle mainBundle]loadNibNamed:@"OrderListDetailsViewController" owner:nil options:nil] firstObject];
    details.orderlist = order;
    [self.navigationController   pushViewController:details animated:YES];
    
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
