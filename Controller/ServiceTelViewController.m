//
//  ServiceTelViewController.m
//  指尖叫货
//
//  Created by rimi on 16/6/24.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "ServiceTelViewController.h"
#import "ServiceTelTableViewCell.h"
#import "DataService.h"
#import "AllFunction.h"


@interface ServiceTelViewController ()<UITableViewDelegate,UITableViewDataSource>




@end

@implementation ServiceTelViewController
-(NSMutableArray *)telArray
{
    if (_telArray==nil) {
        _telArray =[NSMutableArray  arrayWithCapacity:0];
    }
    return _telArray ;
}
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
        
        _tableView.delegate = self;
        _tableView.dataSource =self;
        _tableView.separatorColor = [UIColor brownColor];
        _tableView.separatorStyle =UITableViewCellSeparatorStyleSingleLine;
        
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 40)];
    label.text = @"客服电话";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor colorWithRed:0.2f green:0.55f blue:1.0f alpha:1];
    
    self.navigationItem.titleView = label;
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                         forBarMetrics:UIBarMetricsDefault];
    
    _telArray = [NSMutableArray array];

    
    [DataService  getdataService:[AllFunction PhoneList ] andparams:nil  succeed:^(id response) {
        
        NSArray   *arr =    response[@"data"];
        for (NSDictionary *adic in arr) {
            [_telArray  addObject:adic];
            
            [self.tableView  reloadData];
        }
        NSLog(@"respond:%@",self.telArray);

    } failed:^(id error) {
        
    }];
    [self.view addSubview:self.tableView];

    NSLog(@"外面 %@",self.telArray);
}




-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.telArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.f;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 10.f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *dataSourceIdentify = @"dataSource";
    ServiceTelTableViewCell *cell = (ServiceTelTableViewCell *)[tableView dequeueReusableCellWithIdentifier:dataSourceIdentify];//从缓存中获取与重用
    NSDictionary *telDic = self.telArray[indexPath.row];
    if (! cell) {
        cell = [[ServiceTelTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:dataSourceIdentify];
    }
    cell.telDic = telDic;
    
    return  cell;
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
