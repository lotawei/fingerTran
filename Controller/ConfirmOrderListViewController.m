//
//  ConfirmOrderListViewController.m
//  指尖叫货
//
//  Created by rimi on 16/6/29.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "ConfirmOrderListViewController.h"
#import "AppDelegate.h"
#import "AllFunction.h"
#import "DataService.h"
#import "AddressManageViewController.h"
#import "LLHOrder.h"
#import "LLHProdoct.h"
#import "SVProgressHUD.h"
#import "IndexViewController.h"
@interface ConfirmOrderListViewController ()

@end

@implementation ConfirmOrderListViewController

-(void)viewDidLoad
{
    
   
}
-(void)viewWillAppear:(BOOL)animated
{
     [self   setinfo];
}
-(void)viewDidLayoutSubviews
{
    self.liuyan.layer.borderWidth = 1;
    self.address.layer.borderWidth = 1;
    self.liuyan.layer.cornerRadius = 5;
    self.address.layer.cornerRadius = 5;
}

-(void)setinfo
{
      AppDelegate   *app = [UIApplication  sharedApplication].delegate;
     NSDictionary   *dic = [[NSUserDefaults   standardUserDefaults] objectForKey:@"DefaultAddress"];
    self.address.text = dic[@"AddressDetail"] ;
    
    
    self.tel.text = dic[@"Mobile"];
    self.lianxiren.text = dic[@"Name"];
    
//    
//    self.address.text =  address.addressDetail;
//    
//    
//    self.tel.text = address.mobile;
//    self.lianxiren.text = address.name;
    //
  
    
    
    self.xiaoji.text  = [NSString  stringWithFormat:@"%.2f",[app.auser orderprice]];
    self.yunfei.text =[NSString  stringWithFormat:@"%.2f",app.auser.yunfei];
    
    self.heji.text  =[NSString  stringWithFormat:@"%.2f",app.auser.xiandanjine];
    
    
    
    
    
    
    
}
- (IBAction)xiadan:(id)sender {
    AppDelegate    *app= [UIApplication  sharedApplication].delegate;
//    CustomerId : "", /*string 客户端用户ID，不是用户名，IPAD版不用传递这个参数*/
//    CustomerName : "", /*string 客户端登录名*/
//    CNEE : "", /*string 收货人*/
//    ShopName : "", /*string 店铺名*/
//    Mobile : "", /*string 联系电话*/
//    Weixin : "", /*string  微信*/
//    Zip : "", /*string 邮编*/
//    ProvinceName : "", /*string 省份名*/
//    CityName : "", /*string 城市名*/
//    AddressDetail : "", /*string 详细地址*/
//    Rest : false, /*bool  是否午休*/
//    StartTime : "09:00", /*timespan 送货时间段-开始*/
//    EndTime : "22:30", /*timespan 送货时间段-结束*/
//    SalemanId : -1, /*int  销售人员ID */
//    IsSalemanOrder : false, /*bool  IPAD传递true，手机传递false*/
//    Remark : "", /*string 备注*/
//    GoodsList ： [
//                 {
//                     GoodsCode : "" , /*string 商品编码*/
//                     Quantity : 1   /*int 订购数量*/
//                 },
//                 {
//                     GoodsCode : "" ,
//                     Quantity : 1
//                 }
//                 ]
    
    NSNumber   *number =  [NSNumber  numberWithInt:1];
    NSMutableDictionary    *params = [NSMutableDictionary   dictionary];
    NSDictionary  *dic = [[NSUserDefaults  standardUserDefaults]objectForKey:@"DefaultAddress"];
    
   
    
//    [params setObject:app.auser.coustomerId forKey:@"CustomerId"];
//    [params setObject:app.auser.loginName forKey:@"CustomerName"];
//    [params   setObject:address.name forKey:@"CNEE"];
//    [params   setObject:address.mobile forKey:@"Mobile"];
//    [params  setObject:address.weixin forKey:@"Weixin"];
//    
//    [params  setObject:address.zip forKey:@"Zip"];
//    [params  setObject:address.provinceName forKey:@"ProvinceName"];
//    [params  setObject:address.city forKey:@"CityName"];
//    [params  setObject:address.addressDetail forKey:@"AddressDetail"];
//    
//    
//    [params  setObject:number forKey:@"Rest"];
//    
//    [params  setObject:address.startTime forKey:@"StartTime"];
//    [params  setObject:address.endTime forKey:@"EndTime"];
//    [params  setObject:@"-1" forKey:@"SalemanId"];
//    [params  setObject:@"false" forKey:@"IsSalemanOrder"];
//    [params  setObject:self.liuyan.text forKey:@"Remark"];
//    
//    [params  setObject:address.shopName forKey:@"ShopName"];
//    
    [params setObject:app.auser.coustomerId forKey:@"CustomerId"];
     [params setObject:app.auser.loginName forKey:@"CustomerName"];
    [params   setObject:dic[@"Name"] forKey:@"CNEE"];
    [params   setObject:dic[@"Mobile"] forKey:@"Mobile"];
    [params  setObject:dic[@"Weixin"] forKey:@"Weixin"];
    
     [params  setObject:dic[@"Zip"] forKey:@"Zip"];
    [params  setObject:dic[@"ProvinceName"] forKey:@"ProvinceName"];
    [params  setObject:dic[@"City"] forKey:@"CityName"];
    [params  setObject:dic[@"AddressDetail"] forKey:@"AddressDetail"];
 

    [params  setObject:number forKey:@"Rest"];

    [params  setObject:dic[@"StartTime"] forKey:@"StartTime"];
    [params  setObject:dic[@"EndTime"] forKey:@"EndTime"];
    [params  setObject:@"-1" forKey:@"SalemanId"];
    [params  setObject:@"false" forKey:@"IsSalemanOrder"];
    [params  setObject:self.liuyan.text forKey:@"Remark"];
    
     [params  setObject:dic[@"ShopName"] forKey:@"ShopName"];
    
    NSMutableArray   *products =  [NSMutableArray  arrayWithCapacity:0];
    
    
    for ( LLHProdoct  *apro in app.auser.orderproducts) {
        
        
        NSDictionary   *dic = [LLHProdoct  dicWithPro:apro];
       
        [products addObject:dic];
    }
    [params setObject:products forKey:@"GoodsList"];
    
    
    NSData    *data = [self    toJSONData:params];
    NSString   *jsonString = [[NSString alloc] initWithData:data
                                                                      encoding:NSUTF8StringEncoding];
    
//    [params  setObject:products  forKey:@"GoodsList"];

//    [DataService   getdataService:[AllFunction  AddOrderList] andparams:jsonString succeed:^(id response) {
//     
//            NSLog(@"%@",response);
//        
//    } failed:^(id error) {
//        
//    }];
    
    NSDictionary *dicJson = @{@"orderData":jsonString
                          
                          };
    
    
    [SVProgressHUD   show];
    
    [DataService   getLaunchdataService:[AllFunction  AddOrderList] andparams:dicJson succeed:^(id response) {
       
        NSLog(@"%@",response);
        if ([response[@"statusCode"] integerValue]==1) {
            [SVProgressHUD   dismiss];
            
            //清空购物车
                    AppDelegate   *app = [UIApplication   sharedApplication].delegate;
            
            
                    [app.auser.orderproducts removeAllObjects];
                    [app.auser.scanproducts removeAllObjects];
            
            NSLog(@"%@",app.auser.orderproducts);
      
                UIAlertController  *con = [UIAlertController alertControllerWithTitle:@"下单成功" message:nil
                                                                       preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction   *cancle  = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                    UIStoryboard     *main = [UIStoryboard   storyboardWithName:@"Main" bundle:nil];
                    
                    UINavigationController    *root = [main  instantiateViewControllerWithIdentifier:@"RootViewController"];
                    app.window.rootViewController = root;
                    [self.navigationController  presentViewController:root animated:YES completion:nil];
                }];
            
             [con addAction:cancle];
            
                [self presentViewController:con animated:YES completion:nil];
            
        }
        else
        {
            UIAlertController  *con = [UIAlertController alertControllerWithTitle:@"下单失败" message:nil
                                                                   preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction   *cancle  = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
            
            [con addAction:cancle];
            [self presentViewController:con animated:YES completion:nil];
        }
        
        
    } failed:^(id error) {
          [SVProgressHUD   dismiss];
        UIAlertController  *con = [UIAlertController alertControllerWithTitle:@"下单失败" message:nil
                                                               preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction   *cancle  = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
            UIStoryboard     *main = [UIStoryboard   storyboardWithName:@"Main" bundle:nil];
            
            UINavigationController    *root = [main  instantiateViewControllerWithIdentifier:@"RootViewController"];
            app.window.rootViewController = root;
            [self.navigationController  presentViewController:root animated:YES completion:nil];
        }];
        
        [con addAction:cancle];
        [self presentViewController:con animated:YES completion:nil];

        
    }];
    
    
    
    
}
- (NSData *)toJSONData:(id)theData{
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:theData
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    if ([jsonData length] > 0 && error == nil){
        return jsonData;
    }else{
        return nil;
    }
}
- (IBAction)xiugai:(id)sender {
    
    AddressManageViewController   *update = [[AddressManageViewController  alloc ]init];
    [self.navigationController pushViewController:update animated:YES];
   
}



@end
