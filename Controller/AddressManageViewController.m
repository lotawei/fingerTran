//
//  AddressManageViewController.m
//  指尖叫货
//
//  Created by rimi on 16/6/22.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "AddressManageViewController.h"

#import "ReceiverAddressViewController.h"
#import "DataService.h"
#import "AllFunction.h"
#import "AppDelegate.h"
#import "LLHUser.h"
#import "LLHAddress.h"



@interface AddressManageViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSMutableArray *addressArary;

@property(nonatomic,strong)NSIndexPath *indexPath;


@end

@implementation AddressManageViewController
-(void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 40)];
    label.text = @"地址管理";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor colorWithRed:0.2f green:0.55f blue:1.0f alpha:1];
    
    self.navigationItem.titleView = label;
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                         forBarMetrics:UIBarMetricsDefault];

    //添加右边navigation的button
    UIBarButtonItem *barbutton = [[UIBarButtonItem alloc]initWithTitle:@"新增地址" style:0 target:self action:@selector(addAddress:)];
    
    self.navigationItem.rightBarButtonItem = barbutton;
    

    AppDelegate    *app = [UIApplication  sharedApplication].delegate;
    LLHUser        *auser = app.auser;
    

    
    
    
    //网上获取推荐列表
    NSMutableDictionary   *adic  = [NSMutableDictionary  dictionary];
    [adic setObject:auser.coustomerId forKey:@"customerId"];
    [adic setObject:@0 forKey:@"onlyDefault"];
    
    
    
//    [DataService  getdataService:[AllFunction  GetAddress] andparams:adic succeed:^(id response) {
//        
//    
//        NSArray *arr = response[@"data"];
//        
////        _addressArary = response[@"data"];
//      
////        NSLog(@"%@",response[@"data"]);
//        _addressArary = [NSMutableArray array];
//        for (NSDictionary  *dic in arr) {
//            LLHAddress *address = [LLHAddress addrWithdic:dic];
//            
//            [_addressArary addObject:address];
//            
////            NSLog(@"addressarray respond%ld",_addressArary.count);
//            [self.tableView  reloadData];
//        }
//        
//        
//        
//    } failed:^(id error) {
//        
//    }];
    [DataService  getLaunchdataService:[AllFunction  GetAddress] andparams:adic succeed:^(id response) {
        
    
        NSArray *arr = response[@"data"];
        
        //        _addressArary = response[@"data"];
        
        //        NSLog(@"%@",response[@"data"]);
        _addressArary = [NSMutableArray array];
        for (NSDictionary  *dic in arr) {
            LLHAddress *address = [LLHAddress addrWithdic:dic];
            
            [_addressArary addObject:address];
            
            //            NSLog(@"addressarray respond%ld",_addressArary.count);
            [self.tableView  reloadData];
        }
        
        
        
    } failed:^(id error) {
        
    }];
    
    
    
    [self.view addSubview:self.tableView];
    
//    NSLog(@"数据hdkfhd");
    
    
}

-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width , self.view.bounds.size.height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.separatorColor = [UIColor brownColor];
    }
    
    return  _tableView;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//    NSLog(@"%ld",_addressArary.count);
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   return _addressArary.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10.f;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120.f;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *dataSourceIdentify = @"dataSource";
    AddressTableViewCell *cell = (AddressTableViewCell *)[tableView dequeueReusableCellWithIdentifier:dataSourceIdentify];//从缓存中获取与重用
    
    
    LLHAddress *cellAddress = _addressArary[indexPath.row];
//    NSLog(@"%@",_addressArary[indexPath.section]);
    if ( cell==nil) {
        cell = [[AddressTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:dataSourceIdentify];
    }
    
//    cell.addressDic = @{@"name":@"hu",@"phoneNumber":@"13323247897",@"address":@"chengdushidshivsdjhs"};
//    NSLog(@"%@",cellAddress);
    
    cell.address = cellAddress;
    cell.celldelegate = self;
    
    return  cell;
    
}


//告诉  可以编辑
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}



-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{

//     
//    LLHAddress *addressDic = self.addressArary[indexPath.section];
//    NSDictionary *dic = @{@"addressId":@(addressDic.addressId)};
//    
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        [DataService getLaunchdataService:[AllFunction DeleteAddress] andparams:dic succeed:^(id response) {
//            NSLog(@"删除:%@",response[@"statusMessage"]);
//            
//            
//            
//            [self.addressArary removeObjectAtIndex:indexPath.row];
//            
//            
////            NSLog(@"地址数组%@",self.addressArary);
//            
//            [self.tableView reloadData];
//            
//            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationMiddle];
//            
//        } failed:^(id error) {
//            
//        }];
    
        
        
        
//    }
}

//    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //删除对应的数据  再删cell
        
        
//        [array removeObjectAtIndex:indexPath.row];
        
//        if (array.count == 0) {
//            //            [self.dataSourceDictionary removeObjectForKey:letter];
////            [self.headerLetterArray removeObjectAtIndex:indexPath.section];
//            [tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationAutomatic];
//            
//        }
//        else{
////            self.dataSourceDictionary[letter] = array;
        
            
            
            //删除cell
//            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationMiddle];
//        }
//        
//    }
//    
//
//    
//}


//-(void)addToolBar
//{
//    self.toolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(300, 400, 50, 40)];
//    [self.view addSubview:self.toolbar];
////    [self.]
//    
//    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(add)];
//    
//    NSArray *buttonArray = [NSArray arrayWithObjects:addButton,nil];
//    
//    self.toolbar.items = buttonArray;
//}



-(void)addAddress:(UIBarButtonItem *)sender
{
    NSLog(@"hksdf");
    ReceiverAddressViewController  *ravc = [[ReceiverAddressViewController alloc]init];
    [self.navigationController pushViewController:ravc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



///设置默认地址

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSLog(@"%@",NSHomeDirectory());

    LLHAddress *addressDic = self.addressArary[indexPath.row];
    
    NSLog(@"%@",addressDic);
    NSDictionary *dic = @{@"addressId":@(addressDic.addressId)};
    [DataService  getLaunchdataService:[AllFunction  SetDefaultAddress] andparams:dic succeed:^(id response) {
        NSLog(@"设置默认地址:%@",response[@"statusMessage"]);
        
        for (int i = 0; i<self.addressArary.count; i++) {
            if (i == indexPath.row) {//把当前点击的cell设为默认地址
                LLHAddress *address =  self.addressArary[indexPath.row];
                NSMutableDictionary   *dic =[LLHAddress  dicWithAddress:address];
                address.isDefaultAddress = NO;
                [self.addressArary replaceObjectAtIndex:indexPath.row withObject:address];
                [[NSUserDefaults  standardUserDefaults]setObject:dic forKey:@"DefaultAddress"];
                UIAlertController  *con = [UIAlertController alertControllerWithTitle:
                                                                              @"设置成功！" message:nil
                                                                       preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction   *cancle  = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
                [con addAction:cancle];
                [self presentViewController:con animated:YES completion:nil];
                
                
            }
            else{
                
                LLHAddress *address =  self.addressArary[i];
                address.isDefaultAddress = YES;
                [self.addressArary replaceObjectAtIndex:i withObject:address];
                
            }
        }
        
        
        
        
        
        [self.tableView reloadData];
        
    } failed:^(id error) {
        UIAlertController  *con = [UIAlertController alertControllerWithTitle:
                                   @"设置失败！" message:nil
                                                               preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction   *cancle  = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [con addAction:cancle];
        [self presentViewController:con animated:YES completion:nil];
    }];
    
}




-(void)pass:(AddressTableViewCell *)cell
{
    
    
    self.indexPath  =[self.tableView  indexPathForCell:cell ];
    ReceiverAddressViewController *ravc = [[ReceiverAddressViewController alloc]init];
    ravc.updateAddress = self.addressArary[self.indexPath.section];
    
    [self.navigationController pushViewController:ravc animated:YES];
    
    
}



@end
