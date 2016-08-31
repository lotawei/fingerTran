//
//  AllFunction.h
//  指尖叫货
//
//  Created by lotawei on 16/6/19.
//  Copyright © 2016年 lw. All rights reserved.
//
//#define BASEURL  @"http://jh.wzjkj.com"
////商品分类获取列表
//#define GetListByCategory    @"/Goods/GetListByCategory"
////商品状态获取列表
//#define  GetListByStatus   @"/Goods/GetListByStatus"
////搜索商品
//#define FindList  @"/Goods/FindList"
////获取分类列表
//#define  Category   @"/Category/GetList"
////获取省份列表
//#define Province    @"/Province/GetList"
////获取注册用户
//#define Register    @"/Customer/Register"
////登录与否
//#define  Login      @"/Customer/Login"
////添加收货地址
//#define  AddAddress  @"/Customer/AddAddress"
////删除收货地址
//#define  DeleteAddress   @"/Customer/DeleteAddress"
////更新收货地址
//#define UpdateAdress  @"/Customer/UpdateAdress"
////得到地址信息
//#define GetAddress   @"/Customer/GetAdress"
//
////默认地址信息
//#define  SetDefaultAddress  @"/Customer/SetDefaultAddress"
////修改密码
//#define  ChangePassword   @"/Customer/ChangePassword"
//
////运费列表
//#define Freight    @"/Freight/GetList"
//
////上传订单列表信息
//#define AddOrderList   @"/Order/AddOrder"
////获取订单列表
//#define GetOrderList  @"/Order/GetList"
////添加订单返回的结果
//#define TZ   @"/TZ/GetList"
//
////滚动视图
//#define GetSliderList  @"/Slider/GetList"
//
////获取客服电话
//#define  PhoneList   @"/Phone/GetList"
//
//
////简介
//
//#define  GetContent  @"/Remark/GetContent"
////找回密码
//#define ResetPassword  @"/Customer/ResetPassword"
#import <Foundation/Foundation.h>

@interface AllFunction : NSObject
+(NSString *)GetListByCategory;
+(NSString *)GetListByStatus;
+(NSString *)FindList;
+(NSString *)Category;
+(NSString *)Province;
+(NSString *)Register;
+(NSString *)Login;
+(NSString *)AddAddress;
+(NSString *)DeleteAddress;
+(NSString *)UpdateAdress;
+(NSString *)SetDefaultAddress;
+(NSString *)ChangePassword;
+(NSString *)AddOrderList;
+(NSString *)GetOrderList;
+(NSString *)Freight;
+(NSString *)TZ;
+(NSString *)GetSliderList;
+(NSString *)PhoneList;
+(NSString *)GetContent;
+(NSString *)ResetPassword;
+(NSString *)BaseUrl;
+(NSString *)GetAddress;

+(NSString *)AddressUrl;
@end
