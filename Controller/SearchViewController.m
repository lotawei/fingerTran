//
//  SearchViewController.m
//  指尖叫货
//
//  Created by rimi on 16/6/20.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "SearchViewController.h"
#import "AppDelegate.h"
#import "SearchTableViewCell.h"
#import "DataService.h"
#import "AllFunction.h"
#import "LLHProdoct.h"
#import "DetailsGoodViewController.h"
#import "SVPullToRefresh.h"


@interface SearchViewController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>

@property(nonatomic)int page;
@property (nonatomic)BOOL isSearched;//是否处于搜索状态
@property(nonatomic,strong) NSMutableArray *searchGoodArray;
@property(nonatomic,strong) NSMutableArray *searchHistoriesArray;

@end

@implementation SearchViewController

-(NSMutableArray *)searchGoodArray
{
    if (!_searchGoodArray) {
        _searchGoodArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _searchGoodArray;
}


-(NSMutableArray *)searchHistoriesArray
{
    if (!_searchHistoriesArray) {
        _searchHistoriesArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _searchHistoriesArray;
}

-(UISearchBar*)mysearchbar
{
    if (_mysearchbar ==nil) {
        UISearchBar *searchBar = [[UISearchBar alloc] init];
//        UIColor *color =  self.navigationController.navigationBar.barTintColor;
        
        searchBar.frame = CGRectMake(20, 0, 200, 32);
        
        [searchBar setBackgroundImage:[UIImage imageNamed:@"输入框@2x.png"]];
        searchBar.placeholder = @"|搜索你想要的东西    ";
        
        _mysearchbar = searchBar;
        _mysearchbar.returnKeyType =  UIReturnKeyGo;
        _mysearchbar.delegate = self;
    }
    return _mysearchbar;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.mysearchbar resignFirstResponder];
}


//初始化历史记录数组
-(void)setHisArr
{
    NSArray *arr = [[NSUserDefaults standardUserDefaults]objectForKey:@"histories"];
    if (arr) {
        self.searchHistoriesArray = [NSMutableArray arrayWithArray:arr];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor  whiteColor];
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 35)];//allocate titleView
    
    UIColor *color =  self.navigationController.navigationBar.barTintColor;
    [titleView setBackgroundColor:color];
    
    [titleView addSubview:self.mysearchbar];
    
    //Set to titleView
    [self.navigationItem.titleView sizeToFit];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"搜索" style:UIBarButtonItemStyleDone target:self action:@selector(gosearch)];
    self.navigationItem.titleView = titleView;
    
    
    [self setHisArr];
    [self.view addSubview:self.tableview];
}

//在显示历史记录的情况下  添加历史记录header
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.isSearched) {
        return  nil;
    }
    else
    {
        UIView *viewHeader = [[UIView alloc]init];
        UILabel *gapLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 10, 22)];
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(gapLabel.frame) , 10, 90, 22)];
        
        titleLabel.textColor=[UIColor grayColor];
        titleLabel.font = [UIFont systemFontOfSize:13];
        //    titleLabel.backgroundColor = [UIColor whiteColor];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.text=@"历史记录";
        [viewHeader addSubview:gapLabel];
        [viewHeader addSubview:titleLabel];
        
        viewHeader.backgroundColor = [UIColor whiteColor];
        return viewHeader;

    }
}
//设置header的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.isSearched) {
        return 0.f;
    }
    else{
        return 32.f;
    }
}

//在历史记录的的情况下，显示清除历史记录的button按钮
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (self.isSearched) {
        return nil;
    }
    else{
        if (self.searchHistoriesArray.count > 0) {
            UIView *viewFooter = [[UIView alloc]init];
            
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 90, 40)];
            
            UIButton *clearHis = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label.frame), 0, 200, 40)];
            [clearHis setBackgroundImage:[UIImage imageNamed:@"清除历史记录@2x.png"] forState:UIControlStateNormal];
            
            [clearHis addTarget:self action:@selector(clearHistory:) forControlEvents:UIControlEventTouchUpInside];
            
            UILabel *label2 = [[UILabel alloc ]initWithFrame:CGRectMake(CGRectGetMaxX(clearHis.frame), 0, 100, 30)];
            
            [viewFooter addSubview:label];
            [viewFooter addSubview:clearHis];
            [viewFooter addSubview:label2];
            
//            viewFooter.backgroundColor = [UIColor whiteColor];
            return viewFooter;

        }
        else
        {
            return nil;
        }
       
    }
}

//button清楚历史记录的点击事件
-(void)clearHistory:(UIButton *)sender
{
    [self.searchHistoriesArray removeAllObjects];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"histories"];
    
    [sender removeFromSuperview];
    [self.tableview reloadData];
}



//在显示历史记录的情况下   设置底部的高度
-(CGFloat )tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (self.isSearched) {
        return  0.f;
    }
    else
    {
        if (self.searchHistoriesArray.count > 0) {
            return  40.f;
        }
        else{
            return 0.f;
        }
    }
}

//从网络中获取搜索框的商品
-(void)getGoodFromNet:(NSString *)string
{
    
    NSDictionary *params = @{@"keyword": string,
                             @"pageIndex":@1,
                             @"pageSize":@(20)
                            };
    [DataService getdataService:[AllFunction FindList] andparams:params succeed:^(id response) {
        
        NSArray *array = response[@"data"][0][@"List"];
        NSLog(@"返回数组的长度%ld",array.count);
        
        
        
        if (array.count > 0) {
            [self.searchGoodArray removeAllObjects];
            
            
            for (NSDictionary *dic in array) {
                LLHProdoct    *pro = [LLHProdoct  proWithdic:dic];
                
                [self.searchGoodArray addObject:pro];
                [self.tableview  reloadData];
            }
            
            if (![self.searchHistoriesArray containsObject:string]) {
                [self.searchHistoriesArray addObject:string];
                [[NSUserDefaults standardUserDefaults]setObject:self.searchHistoriesArray forKey:@"histories"];
            }
        }
        
        
        else
        {
            UIAlertController  *con = [UIAlertController alertControllerWithTitle:@"搜索失败" message:nil
                                                                   preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction   *cancle  = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
            [con addAction:cancle];
        }
        
        
    } failed:^(id error) {
        
    }];
    
    
    //注册上拉刷新功能
    __weak SearchViewController *weakSelf = self;
    
    [self.tableview addInfiniteScrollingWithActionHandler:^{
        if (weakSelf.page<11) {
            weakSelf.page ++;
            [weakSelf insertRowAtBottom];
        }
        
        
    }];

   
}

-(void)insertRowAtBottom
{
    __weak SearchViewController *weakSelf = self;
    NSNumber   *number  = [NSNumber  numberWithInt:weakSelf.page];
    NSMutableDictionary  *params = [NSMutableDictionary  dictionaryWithCapacity:0];
    [params setObject:number forKey:@"pageIndex"];
    [DataService   getdataService:[AllFunction  GetListByStatus] andparams:params succeed:^(id response) {
        
        
        NSArray   *allpro =response[@"data"][0][@"List"];
        for (NSDictionary  *dic  in allpro) {
            LLHProdoct   *apro = [LLHProdoct  proWithdic:dic];
            [weakSelf.searchGoodArray  addObject:apro];
            
        }
        [weakSelf.tableview  reloadData];
        [weakSelf.tableview.infiniteScrollingView  stopAnimating];
    } failed:^(id error) {
        
    }];
    
    
}




-(void)gosearch
{
    if ([self.mysearchbar.text isEqualToString:@""]) {//搜索框上面内容为空
        //弹出一个提示
        
        UIAlertController  *con = [UIAlertController alertControllerWithTitle:@"填写为空" message:nil
                                                               preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction   *cancle  = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [con addAction:cancle];
    }
    
    else{
        
        NSString *string = self.mysearchbar.text;
        [self getGoodFromNet:string];
        self.isSearched = YES;
    }
}

-(UITableView *)tableview
{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableview.dataSource = self;
        _tableview.delegate = self;
        _tableview.separatorColor = [UIColor grayColor];
        _tableview.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
//        _tableview.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
        
    }
    return _tableview;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.isSearched) {
        return self.searchGoodArray.count;
    }
    else{
       return  self.searchHistoriesArray.count;
        
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isSearched) {//点击搜索后的显示出来的商品
        
        static NSString *dataSourceIdentify = @"dataSource";
        SearchTableViewCell *sechTVCell = (SearchTableViewCell *)[tableView dequeueReusableCellWithIdentifier:dataSourceIdentify];
        
        LLHProdoct *product = self.searchGoodArray[indexPath.row];
        
        
        if (! sechTVCell) {
            sechTVCell = [[SearchTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:dataSourceIdentify];
        }
        sechTVCell.product = product;
        
        return  sechTVCell;

    }
    else//显示历史记录列表
    {
        static NSString *dataSourceIdentify = @"dataSourceCell";
        
        NSString *historyCell = self.searchHistoriesArray[indexPath.row];
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:dataSourceIdentify];
        
        if (! cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:dataSourceIdentify];
        }
        NSLog(@"%@",historyCell);
        cell.textLabel.text = historyCell;
        return  cell;
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isSearched) {
        return  85.f;

    }
    else{
        return 50.f;
    }
}

//告诉  可以编辑
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


//选中哪一行
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isSearched) {
        
        LLHProdoct   *apro = self.searchGoodArray[indexPath.row];
        AppDelegate  *app = [UIApplication  sharedApplication].delegate;
        
        [app.auser  addScanPro:apro];
        app.goodscode = apro.goodsCode;
        DetailsGoodViewController  *details= [[[NSBundle mainBundle]loadNibNamed:@"DetailsGoodViewController" owner:nil options:nil] firstObject];
        
        [self.navigationController   pushViewController:details animated:YES];
        
    }
    else{
        
        NSString *string = self.searchHistoriesArray[indexPath.row];
        self.isSearched = YES;
        [self getGoodFromNet:string];
        self.mysearchbar.text = string;
    }
}


- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar;
{
    return YES;
}

-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
