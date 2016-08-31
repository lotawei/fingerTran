//
//  DetailsGoodViewController.m
//  指尖叫货
//
//  Created by rimi on 16/6/23.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "DetailsGoodViewController.h"
#import "AppDelegate.h"
#import "UIImageView+WebCache.h"
#import "CartShopView.h"
#import "ShopViewController.h"


@interface DetailsGoodViewController ()<ShowViewDelegate>
{
    CGPoint    originalcenter;
    CGAffineTransform     originaltrans;
}
@property(nonatomic)   BOOL   ismalll;
@end

@implementation DetailsGoodViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"商品详情";
   AppDelegate   *app= [UIApplication sharedApplication].delegate;
   [self.view addSubview:app.shopview];
    [self.img setUserInteractionEnabled:YES];
    self.img.tag = 1100;
    [self.img setMultipleTouchEnabled:YES];
   originaltrans  = self.img.transform  ;
      originalcenter =self.img.center;
    
    
    UITapGestureRecognizer   *atap = [[UITapGestureRecognizer  alloc]initWithTarget:self action:@selector(atap:)];
    [self.img addGestureRecognizer:atap];
    
    
}
-(void)viewDidLayoutSubviews
{
    self.acount.clipsToBounds  = YES ;
    self.acount.layer.cornerRadius = 15.0;
}
//点击手势
-(void)atap:(UITapGestureRecognizer*)atap
{
    
    if (_ismalll!=YES) {
        _ismalll = YES ;
        
        [UIView   animateWithDuration:0.5 animations:^{
            
            self.view.backgroundColor = [UIColor  blackColor];
            
            
            for (UIView  *aview in self.view.subviews) {
                if (aview.tag != 1100) {
                    aview.hidden = YES ;
                }
            }
            self.img.center = self.view.center;
        }];
        [self   addGestureRecognizerToView:self.img];
        
        
    }
    else
    {
        [UIView   animateWithDuration:0.5 animations:^{
            
            self.view.backgroundColor = [UIColor  whiteColor];
            
            for (UIView  *aview in self.view.subviews) {
                if (aview.tag != 1100) {
                    aview.hidden = NO ;
                }
            }
            
            self.img.center = originalcenter;
            self.img.transform = originaltrans;
        }];
        _ismalll = NO;
        [self   removeGuesture:self.img];
         [self.view setNeedsDisplay];
    }
   
    
}



-(void)setpro
{
    
    if(self.apro.procount <= 0)
    {
        self.acount.text = @"";
        self.acount.hidden = YES;
    }
    else{
        self.acount.text =  [NSString  stringWithFormat:@"%ld",self.apro.procount];
        self.acount.hidden = NO;

    }
    
    
    self.proname.text = self.apro.categoryTitle;
    self.procode.text = self.apro.goodsCode;
    self.probarcode.text = self.apro.barcode ;
    self.proprice.text = [NSString  stringWithFormat:@"€%.2f",self.apro.price];
    self.propackage.text = [NSString  stringWithFormat:@"%ld",self.apro.package];
    self.prototalprice.text  =[NSString  stringWithFormat:@"%.2f",self.apro.procount * self.apro.price];
    
    
    
    
    [self.img sd_setImageWithURL:[NSURL  URLWithString:self.apro.imageUrl ] placeholderImage:[UIImage  imageNamed:@"place.png"]];
    
    
    
    if (self.apro.discount > 0) {
        self.discount.hidden = NO;
        self.takeoutLine.hidden = NO;
        self.discount.text = [NSString stringWithFormat:@"-%ld ",self.apro.discount];
    }
    else{
        self.takeoutLine.hidden = YES;
        self.discount.hidden = YES;
        self.discount.text = @"";

    }
    
    if (self.apro.discount > 0) {
        self.afterDiscountPrice.hidden = NO;
        self.afterDiscountPrice.text = [NSString stringWithFormat:@"€%.2f",self.apro.price*(10-self.apro.discount)/10];
    }
    else{
        self.afterDiscountPrice.hidden = YES;
        self.afterDiscountPrice.text = @"";
        
    }
    
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)removeGuesture:(UIView *)view
{
    
    NSArray    *guestures=view.gestureRecognizers;
    
    
    for (UIGestureRecognizer   *ges in guestures) {
        if (![ges isKindOfClass:[UITapGestureRecognizer   class]]) {
            [view removeGestureRecognizer:ges];
            
        }
    }
    
    
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    NSLog(@"我要消失啊");
    AppDelegate   *app= [UIApplication sharedApplication].delegate;

    [app.auser addOrderPro:self.apro];
    [app.auser addScanPro:self.apro];
    NSLog(@"面打算%ld",app.auser.scanproducts.count);
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    AppDelegate   *app= [UIApplication sharedApplication].delegate;
    CartShopView   *aview = app.shopview;
    aview.ordertotal.text = [NSString  stringWithFormat:@"%.2f",app.auser.orderprice];
    aview.delegate = self;
    
    
    
    NSString    *goodscode = app.goodscode ;
    NSArray     *arr= app.auser.scanproducts;
    for (LLHProdoct  *pro in arr) {
        if ([pro.goodsCode isEqualToString:goodscode]) {
            self.apro = pro;
            [self  setpro];
            return ;
        }
    }
    

}


- (IBAction)add:(id)sender {
    

     AppDelegate   *appdele = [UIApplication  sharedApplication].delegate ;
    NSInteger     pack = [self.propackage.text  integerValue]    ;
    NSInteger     result = [self.acount.text  integerValue] + pack;
    
    self.apro.procount = result;
    [appdele.auser addOrderPro:self.apro];
    
    [self  setpro];
    
    CartShopView   *aview = appdele.shopview;
    aview.ordertotal.text = [NSString  stringWithFormat:@"%.2f", appdele.auser.orderprice];
    [aview setShopHidden];
    
}
- (IBAction)decrease:(id)sender {
    
    AppDelegate   *appdele = [UIApplication  sharedApplication].delegate ;
    
    NSInteger     pack = [self.propackage.text  integerValue]    ;
    NSInteger     result = [self.acount.text  integerValue] - pack;
    
    if (result  <=  0  ) {
        self.apro.procount = 0 ;
        [appdele.auser deletePro:self.apro];
        result = 0;
        [self  setpro];
        
        CartShopView   *aview = appdele.shopview;
        aview.ordertotal.text = [NSString  stringWithFormat:@"%.2f", appdele.auser.orderprice];
        return  ;
    }
    self.apro.procount = result;
    [appdele.auser addOrderPro:self.apro];
    
    [self  setpro];
    
    CartShopView   *aview = appdele.shopview;
    aview.ordertotal.text = [NSString  stringWithFormat:@"%.2f", appdele.auser.orderprice];
    
    [aview setShopHidden];
    
}
-(void)cartshopdetails:(CartShopView *)aview
{
    ShopViewController   *cart = [[ShopViewController  alloc]init];
    [self.navigationController pushViewController:cart animated:YES];
}


//手势
- (void) addGestureRecognizerToView:(UIView *)view
{
    // 旋转手势
    UIRotationGestureRecognizer *rotationGestureRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotateView:)];
    [view addGestureRecognizer:rotationGestureRecognizer];
    
    // 缩放手势
    UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchView:)];
    [view addGestureRecognizer:pinchGestureRecognizer];
    
    // 移动手势
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panView:)];
    [view addGestureRecognizer:panGestureRecognizer];
}

// 处理旋转手势
- (void) rotateView:(UIRotationGestureRecognizer *)rotationGestureRecognizer
{
    UIView *view = rotationGestureRecognizer.view;
    if (rotationGestureRecognizer.state == UIGestureRecognizerStateBegan || rotationGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        view.transform = CGAffineTransformRotate(view.transform, rotationGestureRecognizer.rotation);
        [rotationGestureRecognizer setRotation:0];
    }
}

// 处理缩放手势
- (void) pinchView:(UIPinchGestureRecognizer *)pinchGestureRecognizer
{
    UIView *view = pinchGestureRecognizer.view;
    if (pinchGestureRecognizer.state == UIGestureRecognizerStateBegan || pinchGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        view.transform = CGAffineTransformScale(view.transform, pinchGestureRecognizer.scale, pinchGestureRecognizer.scale);
        pinchGestureRecognizer.scale = 1;
    }
}

// 处理拖拉手势
- (void) panView:(UIPanGestureRecognizer *)panGestureRecognizer
{
    UIView *view = panGestureRecognizer.view;
    if (panGestureRecognizer.state == UIGestureRecognizerStateBegan || panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [panGestureRecognizer translationInView:view.superview];
        [view setCenter:(CGPoint){view.center.x + translation.x, view.center.y + translation.y}];
        [panGestureRecognizer setTranslation:CGPointZero inView:view.superview];
    }
}


@end
