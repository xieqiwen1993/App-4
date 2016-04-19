//
//  TimedetailLoanViewController.m
//  App
//
//  Created by Gaiminghui on 16/4/12.
//  Copyright © 2016年 company. All rights reserved.
//

#import "TimedetailLoanViewController.h"
#import "TimeLoanTableViewCell.h"

@interface TimedetailLoanViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView * tableview1;

@end

@implementation TimedetailLoanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"还款明细";
    NSInteger heit=0;
    if (self.view.frame.size.width==320) {
        heit=320;
        
    }else{
        heit= self.view.frame.size.width;
    }
    self.tableview1=[[UITableView alloc]initWithFrame:CGRectMake(20,10, kScreenWidth-40, kScreenHeight) style:UITableViewStyleGrouped];
    self.tableview1.delegate=self;
    self.tableview1.dataSource=self;
    
    self.tableview1.backgroundColor=[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    //self.tableview1.separatorStyle=UITableViewScrollPositionNone;
    self.tableview1.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableview1.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.tableview1];

    // Do any additional setup after loading the view from its nib.
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // UITableViewCell *cell = (MyTableViewCell*)[tableView  dequeueReusableCellWithIdentifier:CellIdentifier];
    
    static NSString *CellIdentifier = @"cell";
    
    TimeLoanTableViewCell*cell = (TimeLoanTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([TimeLoanTableViewCell class])
                                              owner:self
                                            options:nil] objectAtIndex:0];
        // cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        
        cell.backgroundColor=[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    
    
    return cell;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 5;
    }
    else{
        return 1;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 140.0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0,0,tableView.frame.size.width,20)];
    label.textAlignment = NSTextAlignmentCenter;
    label.font=[UIFont systemFontOfSize:14];
    label.text=[NSString stringWithFormat:@"%ld年",section+2015];
    

    return label;
    
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
