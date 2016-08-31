//
//  OrderListDetailsViewController.m
//  指尖叫货
//
//  Created by rimi on 16/6/29.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "OrderListDetailsViewController.h"
#import  "SearchTableViewCell.h"
@interface OrderListDetailsViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation OrderListDetailsViewController

-(void)viewDidLoad
{
    
    [self.tableview registerClass:[SearchTableViewCell  class] forCellReuseIdentifier:@"dataSource"];
    
    
    
    [self  setinfo ];
    
}
-(void)setinfo
{
    self.orderid.text = @"12312414";
    self.yunfei.text = 0;
    self.acount.text  =  @"0";
    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    
    return  0;

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        
        static NSString *dataSourceIdentify = @"dataSource";
        SearchTableViewCell *sechTVCell = (SearchTableViewCell *)[tableView dequeueReusableCellWithIdentifier:dataSourceIdentify];
        
        LLHProdoct *product = self.orderlist.goodList[indexPath.row];
        
        
        if (! sechTVCell) {
            sechTVCell = [[SearchTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:dataSourceIdentify];
        }
        sechTVCell.product = product;
        
        return  sechTVCell;
        
    
}


@end
