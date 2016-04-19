//
//  MyViewController.m
//  App
//
//  Created by Gaiminghui on 16/4/7.
//  Copyright © 2016年 company. All rights reserved.
//

#import "MyViewController.h"
#import "RegisterViewController.h"
#import "LoginViewController.h"
#import "TabBarViewController.h"
#import "LandingViewController.h"
#import "MessageViewControoler.h"
#import "MyLoanViewController.h"
#import "SetingViewController.h"
#import "QuestionViewController.h"
#import "UserViewController.h"
//贷款产品
#import "ProductViewController.h"

#import "FlagButton.h"

//#import "TableViewCell.h"
@interface MyViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableview1;
@property(nonatomic,assign)BOOL islogin;


@end

@implementation MyViewController
-(void)viewWillAppear:(BOOL)animated{
    //即将出现时浮现tabbar
    AppDelegate *delegate=[UIApplication sharedApplication].delegate;
    delegate.myTabar.hidden=NO;
    
       //本地读取头像
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
    if (data) {
    
    UIImage *youImage = [UIImage imageWithData:data];
    self.userImagView.image=youImage;
    

    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_BG_APP;

    
    
    //判断是否登录
    self.islogin=YES;
    [self judgeIsLogin];
    [self makeAllView];
    
   
    // Do any additional setup after loading the view from its nib.
}
-(void)makeAllView{
    //自定义邮件消息按钮
    UIView *homeButtonView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 55, 40)];
    UIImageView *homeButtonImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 24, 16)];
    homeButtonImageView.image = [UIImage imageNamed:@"邮件"];
    //UIButton *homeButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 48, 32)];
    FlagButton *homeButton=[[FlagButton alloc]initWithFrame:CGRectMake(0, 0, 48, 32)];
    [homeButton makeFlag];
    
    homeButton.backgroundColor = [UIColor clearColor];
    [homeButton addTarget:self action:@selector(messageClick) forControlEvents:UIControlEventTouchUpInside];
    [homeButtonView addSubview:homeButtonImageView];
    [homeButtonView addSubview:homeButton];
    
    //创建right按钮
    UIBarButtonItem *homeButtonItem = [[UIBarButtonItem alloc]initWithCustomView:homeButtonView];
    self.navigationItem.rightBarButtonItem=homeButtonItem;

    //用户头像手势
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapclick)];
    self.userImagView.userInteractionEnabled=YES;
    [self.userImagView addGestureRecognizer:tap];
    
    
    
    //tableview
    NSInteger heit=0;
    if (self.view.frame.size.width==320) {
        heit=320;
        
    }else{
        heit= self.view.frame.size.width;
    }
    self.tableview1=[[UITableView alloc]initWithFrame:CGRectMake(0, self.registerBtn.frame.origin.y+self.registerBtn.frame.size.height, kScreenWidth, BOUND_H(self.view)-280) style:UITableViewStyleGrouped];
    self.tableview1.delegate=self;
    self.tableview1.dataSource=self;
    
    self.tableview1.backgroundColor=[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    //self.tableview1.separatorStyle=UITableViewScrollPositionNone;
    [self.view addSubview:self.tableview1];

    
}
-(void)tapclick{
    //用户头像
    if (self.islogin) {
        //进入用户头像页面
        UserViewController *vc=[[UserViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        //否则无响应
        return;
    }
    
}
#pragma mark-------------tableveiwdelegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // UITableViewCell *cell = (MyTableViewCell*)[tableView  dequeueReusableCellWithIdentifier:CellIdentifier];
    
    static NSString *CellIdentifier = @"mycell";
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        
//        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([TableViewCell class])
//                                              owner:self
//                                            options:nil] objectAtIndex:0];
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        if (indexPath.section==0 && indexPath.row==0) {
            cell.imageView.image=[UIImage imageNamed:@"我的贷款"];
            cell.textLabel.text =@"我的贷款";
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }else if (indexPath.section==0 && indexPath.row==1){
            cell.imageView.image=[UIImage imageNamed:@"贷款产品"];
            cell.textLabel.text =@"贷款产品";
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;

            
        }else if (indexPath.section==1){
            cell.imageView.image=[UIImage imageNamed:@"自助答疑"];
            cell.textLabel.text =@"自助答疑";
           
            
        }else if (indexPath.section==2){
            cell.imageView.image=[UIImage imageNamed:@"设置"];
            cell.textLabel.text =@"设置";
            
        }
       

        
    }
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    return cell;
    
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
    return 44.0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"%ld",indexPath.row);
    if (indexPath.section==0 && indexPath.row==0) {
        //未登录，先去登录
        
        if (self.islogin==NO) {
          [BVTToastView show:@"您还没有登录，请先登录！"];
        }else{
        
        MyLoanViewController *vc=[[MyLoanViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        }
    }
    if (indexPath.section==0 && indexPath.row==1) {
        ProductViewController *vc=[[ProductViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];

    }
    if (indexPath.section==1) {
        //自助答疑
        QuestionViewController *vc=[[QuestionViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.section==2) {
        //设置
        SetingViewController *vc=[[SetingViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }

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
//登录注册按钮
- (IBAction)registerClick:(id)sender {
    if (self.islogin==NO) {
    
   
        LandingViewController *VC=[[LandingViewController alloc]init];
    
        [self.navigationController pushViewController:VC animated:YES];
    
    }else{
        self.registerBtn.userInteractionEnabled=NO;
        
    }

}
//消息按钮
-(void)messageClick{
    NSLog(@"message");
    
    if (self.islogin==NO) {
        [BVTToastView show:@"您还没有登录，请先登录！"];
    }else{
    MessageViewControoler *vc=[[MessageViewControoler alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    }
    
}
- (void)judgeIsLogin{
    
    //接口判断是否是商户
//    NSString *accessToken = [[NSUserDefaults standardUserDefaults]objectForKey:kAccessToken];
//    if (accessToken == nil || [accessToken isEqualToString:@""]) {
//        //未登录
//        self.islogin=NO;
//        
//    } else {
//        //已登录
//        self.islogin=YES;
//        self.bacgourImgView.image=[UIImage imageNamed:@"登录后"];
//        self.registerBtn.titleLabel.text=@"13333444433";
//
//    }
    if (self.islogin==YES) {
    
        //已登录
        self.islogin=YES;
        self.bacgourImgView.image=[UIImage imageNamed:@"登录后"];
        self.registerBtn.titleLabel.text=@"13333444433";
        [self.registerBtn setTitle:@"13333444433" forState:UIControlStateNormal];
        
    }

}

@end
