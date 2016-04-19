//
//  MoneyMessageViewController.m
//  App
//
//  Created by Gaiminghui on 16/4/12.
//  Copyright © 2016年 company. All rights reserved.
//

#import "MoneyMessageViewController.h"
#import "FirstpageView.h"
#import "MoneyMessageTableViewCell.h"
#import "MoneyDetailViewController.h"
#define count 5

@interface MoneyMessageViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView * tableview1;


@end

@implementation MoneyMessageViewController

-(void)viewWillAppear:(BOOL)animated{
    //即将出现时隐藏tabbar
    AppDelegate *delegate=[UIApplication sharedApplication].delegate;
    delegate.myTabar.hidden=YES;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    self.title=@"财富快讯";
    
    [self prepareScollView];
    [self preparePageView];
    //防止自动上下偏移
    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    

    self.tableview1=[[UITableView alloc]initWithFrame:CGRectMake(0,220, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
    self.tableview1.delegate=self;
    self.tableview1.dataSource=self;
    
    self.tableview1.backgroundColor=[UIColor clearColor];
    //self.tableview1.separatorStyle=UITableViewScrollPositionNone;
    self.tableview1.showsVerticalScrollIndicator=NO;
    self.tableview1.panGestureRecognizer.delaysTouchesBegan = self.tableview1.delaysContentTouches;
    [self.view addSubview:self.tableview1];

    

    // Do any additional setup after loading the view from its nib.
}
#pragma  mark---------banner轮播图

- (void)prepareScollView {
    CGFloat scrollW = [UIScreen mainScreen].bounds.size.width;
    CGFloat scrollH = 150;
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, scrollW, scrollH)];
    scrollView.delegate = self;
    
    for (int i = 0; i < count; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        NSString *name = @"财富快讯";
        imageView.image = [UIImage imageNamed:name];
        CGFloat imageX = scrollW * (i + 1);
        imageView.frame = CGRectMake(imageX, 0, scrollW, scrollH);
        [scrollView addSubview:imageView];
    }
    
    UIImageView *firstImage = [[UIImageView alloc] init];
    firstImage.image = [UIImage imageNamed:@"财富快讯"];
    firstImage.frame = CGRectMake(0, 0, scrollW, scrollH);
    [scrollView addSubview:firstImage];
    scrollView.contentOffset = CGPointMake(scrollW, 0);
    
    UIImageView *lastImage = [[UIImageView alloc] init];
    lastImage.image = [UIImage imageNamed:@"财富快讯"];
    lastImage.frame = CGRectMake((count + 1) * scrollW, 0, scrollW, scrollH);
    [scrollView addSubview:lastImage];
    scrollView.contentSize = CGSizeMake((count + 2) * scrollW, 0);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    [self addTimer];
    
}

-(void)preparePageView {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat pageW = 100;
    UIPageControl *pageView = [[UIPageControl alloc] initWithFrame:CGRectMake((width - pageW) * 0.5, 190, pageW, 4)];
    pageView.numberOfPages = count;
    pageView.currentPageIndicatorTintColor = [UIColor redColor];
    pageView.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageView.currentPage = 0;
    [self.view addSubview:pageView];
    self.pageView = pageView;
}

- (void)addTimer{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    [runLoop addTimer:self.timer forMode:NSRunLoopCommonModes];
}

-(void)nextImage {
    CGFloat width = self.scrollView.frame.size.width;
    NSInteger index = self.pageView.currentPage;
    if (index == count + 1) {
        index = 0;
    } else {
        index++;
    }
    [self.scrollView setContentOffset:CGPointMake((index + 1) * width, 0)animated:YES];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat width = self.scrollView.frame.size.width;
    int index = (self.scrollView.contentOffset.x + width * 0.5) / width;
    if (index == count + 2) {
        index = 1;
    } else if(index == 0) {
        index = count;
    }
    self.pageView.currentPage = index - 1;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.timer invalidate];
    self.timer = nil;
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self addTimer];
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [self scrollViewDidEndDecelerating:scrollView];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat width = self.scrollView.frame.size.width;
    int index = (self.scrollView.contentOffset.x + width * 0.5) / width;
    if (index == count + 1) {
        [self.scrollView setContentOffset:CGPointMake(width, 0) animated:NO];
    } else if (index == 0) {
        [self.scrollView setContentOffset:CGPointMake(count * width, 0) animated:NO];
    }
}
#pragma mark--------tableviewdelegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // UITableViewCell *cell = (MyTableViewCell*)[tableView  dequeueReusableCellWithIdentifier:CellIdentifier];
    
    static NSString *CellIdentifier = @"cell";
    
    MoneyMessageTableViewCell *cell = (MoneyMessageTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([MoneyMessageTableViewCell class])
                                              owner:self
                                            options:nil] objectAtIndex:0];
        // cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    
    
    return cell;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

        return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110.0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 20;
    
}
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 20;
//}
//-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    
//    
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0,0,tableView.frame.size.width,20)];
//    label.textAlignment = NSTextAlignmentCenter;
//    label.font=[UIFont systemFontOfSize:14];
//    label.text=[NSString stringWithFormat:@"系统消息%ld",section];
//    
//    return label;
//    
//}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MoneyDetailViewController *vc=[[MoneyDetailViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
//
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
