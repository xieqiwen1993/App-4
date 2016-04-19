//
//  MessageViewControoler.m
//  App
//
//  Created by Gaiminghui on 16/4/11.
//  Copyright © 2016年 company. All rights reserved.
//

#import "MessageViewControoler.h"
#import "MessageTableViewCell.h"
#import "DetailViewController.h"
#import "DetailViewMessViewController.h"
#import "EditView.h"
@interface MessageViewControoler ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView * tableview1;
@property(nonatomic,strong)EditView *homeButtonView;
@property(nonatomic,retain)NSMutableArray *cellsArr;

@end

@implementation MessageViewControoler

-(void)viewWillAppear:(BOOL)animated{
    //即将出现时隐藏tabbar
    AppDelegate *delegate=[UIApplication sharedApplication].delegate;
    delegate.myTabar.hidden=YES;
    self.cellsArr=[[NSMutableArray alloc]init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    self.title=@"消息";

    
    //消息角标
    [self makeMessageFlag];
    
    NSInteger heit=0;
    if (self.view.frame.size.width==320) {
        heit=320;
        
    }else{
        heit= self.view.frame.size.width;
    }
    self.tableview1=[[UITableView alloc]initWithFrame:CGRectMake(20,64, kScreenWidth-40, kScreenHeight-44-64) style:UITableViewStyleGrouped];
    self.tableview1.delegate=self;
    self.tableview1.dataSource=self;
    
    self.tableview1.backgroundColor=[UIColor clearColor];
    //self.tableview1.separatorStyle=UITableViewScrollPositionNone;
    self.tableview1.showsVerticalScrollIndicator=NO;
    [self.view addSubview:self.tableview1];

    // Do any additional setup after loading the view from its nib.
}
-(void)makeMessageFlag{
    
    
    self.readBtn.hidden=YES;
    self.deleteBtn.hidden=YES;
    self.homeButtonView=[[EditView alloc]initWithFrame:CGRectMake(0, 0, 55, 40)];
    
    [self.homeButtonView.homeButton addTarget:self action:@selector(messageClick) forControlEvents:UIControlEventTouchUpInside];
    
    //创建right按钮
    UIBarButtonItem *homeButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.homeButtonView];
    self.navigationItem.rightBarButtonItem=homeButtonItem;
    

}
//编辑按钮
-(void)messageClick{
    if (!self.homeButtonView.isEdit) {
        [self.homeButtonView maketitleWith:@"完成"];

    }else{
        [self.homeButtonView maketitleWith: @"编辑"];
    }
    self.homeButtonView.isEdit=!self.homeButtonView.isEdit;
    self.readBtn.hidden=!self.readBtn.hidden;
    self.deleteBtn.hidden=!self.deleteBtn.hidden;
    
    for (MessageTableViewCell *cell in self.cellsArr) {
        cell.editBtn.hidden=!cell.editBtn.hidden;
        
    }
    
    
    
}

#pragma mark--------tableviewdelegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // UITableViewCell *cell = (MyTableViewCell*)[tableView  dequeueReusableCellWithIdentifier:CellIdentifier];
    
    //static NSString *CellIdentifier = @"cell";
    NSString *CellIdentifier = [NSString stringWithFormat:@"tipCellIdentifier%ld",indexPath.row];
    
    MessageTableViewCell *cell = (MessageTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        
                cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([MessageTableViewCell class])
                                                      owner:self
                                                    options:nil] objectAtIndex:0];
       // cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        
       cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.editBtn.hidden=YES;
        [cell.editBtn addTarget:self action:@selector(editClcik:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [self.cellsArr addObject:cell];
    
    return cell;
    
}
//
-(void)editClcik:(id)sender{
    UIButton *btn=(UIButton *)sender;
    btn.backgroundColor=[UIColor cyanColor];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 2;
    }
    else{
        return 1;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110.0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0,0,tableView.frame.size.width,20)];
    label.textAlignment = NSTextAlignmentCenter;
    label.font=[UIFont systemFontOfSize:14];
    label.text=[NSString stringWithFormat:@"系统消息%ld",section];
    
    return label;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DetailViewMessViewController *vc=[[DetailViewMessViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
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

- (IBAction)readClick:(id)sender {
}

- (IBAction)deleteClcik:(id)sender {
}
@end
