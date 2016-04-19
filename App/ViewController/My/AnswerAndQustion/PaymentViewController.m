//
//  PaymentViewController.m
//  App
//
//  Created by Gaiminghui on 16/4/15.
//  Copyright © 2016年 company. All rights reserved.
//

#import "PaymentViewController.h"
#import "MyData.h"
@interface PaymentViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *dataArray;
    NSArray *dataArray1;
    NSMutableArray *boolArr;
    UITableView *myTableView;
}
@property(nonatomic,copy)NSMutableArray *arrIsselect;

@end

@implementation PaymentViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    self.title=@"还款问题";
    //[self makeInitview];
    [self make];
    
    // Do any additional setup after loading the view from its nib.
}
-(void)make{
    dataArray = [[NSMutableArray alloc] init];
    boolArr=[[NSMutableArray alloc]init];
    _arrIsselect=[[NSMutableArray alloc]init];
    // 添加数据
    dataArray=@[@"如何还款?",@"还款失败怎么办？",@"我可以用现金还款吗？",@"如何查询自己的还款？"];
    dataArray1=@[@"   如何还款?",@"   还款失败怎么办？",@"   我可以用现金还款吗？",@"   如何查询自己的还款？"];
    //boolArr=@[@"0",@"0",@"0",@"0"];
    for (int i=0; i<dataArray.count; i++) {
        MyData *data=[[MyData alloc]init];
        [boolArr addObject:data];
        
        [_arrIsselect addObject:@"no"];
    }
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 10, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
    myTableView.dataSource = self;
    myTableView.delegate = self;
    myTableView.rowHeight = 80;
    [self.view addSubview:myTableView];
}
// 组数
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return [dataArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
// 根据状态来判断是否显示该组，隐藏组把组的行数设置为0即可
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //return 1;
    MyData *data=[boolArr objectAtIndex:section];
    if ([data isShow]) {
        UIImageView *view=(UIImageView*)[self.view viewWithTag:section+100];
        view.image=[UIImage imageNamed:@"展开"];
        
        return  1;
    }else{
        UIImageView *view=(UIImageView*)[self.view viewWithTag:section+100];
        view.image=[UIImage imageNamed:@"收起"];
        return  0;
    }
}
// 添加每行显示的内容
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName ];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellName];
    }
    cell.backgroundColor=[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    cell.textLabel.text=[dataArray objectAtIndex:indexPath.section];
    cell.textLabel.font=[UIFont  systemFontOfSize:13];
    return cell;
    
    
    
}
// 定义头标题的视图，添加点击事件
- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //头部view
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    view.backgroundColor=[UIColor whiteColor];
    
    UILabel *lal=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 220, 30)];
    NSString *title=[dataArray1 objectAtIndex:section];
    lal.textAlignment=NSTextAlignmentLeft;
    lal.text=title;
    [view addSubview:lal];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(280, 5, 20, 20);
    btn.tag = section;
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor clearColor];
    
    
    MyData *data=[boolArr objectAtIndex:section];
    if ([data isShow]) {
        
        [btn setBackgroundImage:[UIImage imageNamed:@"展开"] forState:UIControlStateNormal];
        
    }else{
        
        [btn setBackgroundImage:[UIImage imageNamed:@"收起"] forState:UIControlStateNormal];
    }
    
    
    [view addSubview:btn];
    
    btn.titleLabel.textColor=[UIColor redColor];
    return view;
}
- (void) btnClick:(UIButton *)btn
{
    MyData *data = [boolArr objectAtIndex:btn.tag];
    // 改变组的显示状态
    if ([data isShow]) {
        
        [data setIsShow:NO];
    }else{
        
        [data setIsShow:YES];
    }
    
    
    // 刷新点击的组标题，动画使用卡片
    [myTableView reloadSections:[NSIndexSet indexSetWithIndex:btn.tag] withRowAnimation:UITableViewRowAnimationFade];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
