//
//  LifeViewController.m
//  App
//
//  Created by Gaiminghui on 16/4/7.
//  Copyright © 2016年 company. All rights reserved.
//

#import "LifeViewController.h"
#import "FirstpageView.h"
#import "MoneyMessageViewController.h"
#import "SalerMessageViewController.h"
#import "ProductViewController.h"
#define count 5



@interface LifeViewController ()
{
    float step;
}

@end

@implementation LifeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //背景色
    UIImageView *backgroundView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-54)];
    backgroundView.backgroundColor=[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
   
    [self.view addSubview:backgroundView];
    
    [self prepareScollView];
    [self preparePageView];
    //防止轮播图自动上下偏移
    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    

    [self prepareContent];
    

//    
//    NSString * getUserInfoServiceAdress = [NSString stringWithFormat:kServerUrl,@"product/appoint"];
//    NSObject *ibj=[[NSObject alloc]init];
//    
//
//    [ibj post:getUserInfoServiceAdress parameters:@{@"accesstoken":@"",@"lastproductid":@""}
//      success:^(id response) {
//        NSLog(@"success!");
//    } failure:^(YLError *error) {
//        NSLog(@"success!");
//    }];
//
    
    
    // Do any additional setup after loading the view from its nib.
}
#pragma  mark----------主界面内容
-(void)prepareContent{
    
    for (int i=0; i<3; i++) {
        

//        if (i==0) {
//                    FirstpageView *Lview=[FirstpageView init];
//            Lview.imageView.image=[UIImage imageNamed:@"saler"];
//            Lview.titleLable.text=@"商家快讯";
//            Lview.contenLable.text=@"及时了解商家优惠促销活动，快人一步，占尽先机。";
//            Lview.tag=200+i;
//            Lview.frame=CGRectMake(20, 228+120*i,322, 106);
//            [self.view addSubview:Lview];
//
//
//            
//        }
//        if (i==1){
//            FirstpageView *Lview=[FirstpageView init];
//            Lview.imageView.image=[UIImage imageNamed:@"saler"];
//            Lview.titleLable.text=@"财富快讯";
//            Lview.contenLable.text=@"查询推荐有奖获奖名单，了解公司最新招聘。";
//            Lview.tag=200+i;
//            Lview.frame=CGRectMake(20, 228+120*i,322, 106);
//            [self.view addSubview:Lview];
//
//            
//        }else if(i==2){
//            FirstpageView *Lview=[FirstpageView init];
//            Lview.imageView.image=[UIImage imageNamed:@"saler"];
//            Lview.titleLable.text=@"贷款产品";
//            Lview.contenLable.text=@"专业的产品失算，让您对自己的投资做到全方位把握。";
//
//            
//        }
//        Lview.tag=200+i;
//        Lview.frame=CGRectMake(20, 228+120*i,322, 106);
//        [self.view addSubview:Lview];
        
    }
    NSInteger height=(BOUND_H(self.view)-260)/3-12;
    
    FirstpageView *Lview=[FirstpageView init];
    Lview.imageView.image=[UIImage imageNamed:@"saler"];
    Lview.titleLable.text=@"商家快讯";
    Lview.contenLable.text=@"及时了解商家优惠促销活动，快人一步，占尽先机。";
    Lview.frame=CGRectMake(20, 220,BOUND_W(self.view)-40, height);
    [self.view addSubview:Lview];
    UITapGestureRecognizer *getture1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
    [Lview addGestureRecognizer:getture1];
    UIView *singleTapView = [getture1 view];
    singleTapView.tag=400;
    
    
    FirstpageView *Lview1=[FirstpageView init];
    Lview1.imageView.image=[UIImage imageNamed:@"message"];
    Lview1.titleLable.text=@"财富快讯";
    Lview1.contenLable.text=@"查询推荐有奖获奖名单，了解公司最新招聘。";
    Lview1.frame=CGRectMake(20, Lview.frame.origin.y+height+6,BOUND_W(self.view)-40, height);
    [self.view addSubview:Lview1];
    UITapGestureRecognizer *getture2=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
    [Lview1 addGestureRecognizer:getture2];
    UIView *singleTapView1 = [getture2 view];
    singleTapView1.tag=401;


    FirstpageView *Lview2=[FirstpageView init];
    Lview2.tag=402;
    Lview2.imageView.image=[UIImage imageNamed:@"product"];
    Lview2.titleLable.text=@"贷款产品";
    Lview2.contenLable.text=@"专业的产品失算，让您对自己的投资做到全方位把握。";
    Lview2.frame=CGRectMake(20, Lview1.frame.origin.y+height+6,BOUND_W(self.view)-40, height);
    [self.view addSubview:Lview2];
    UITapGestureRecognizer *getture3=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
    [Lview2 addGestureRecognizer:getture3];
    UIView *singleTapView2 = [getture3 view];
    singleTapView2.tag=402;



    
    
}
-(void)tapClick:(UITapGestureRecognizer *)sender{
    
    UITapGestureRecognizer *singleTap = (UITapGestureRecognizer *)sender;
    //NSLog(@"%ld",[singleTap view].tag);
    
    
    if ([singleTap view].tag==400) {
        NSLog(@"点击商家快讯");
        
        SalerMessageViewController *vc=[[SalerMessageViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];

    }
    if ([singleTap view].tag==401) {
        NSLog(@"财富快讯");
        MoneyMessageViewController *vc=[[MoneyMessageViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];

        
    }
    if ([singleTap view].tag==402) {
        NSLog(@"贷款产品");
        ProductViewController *vc=[[ProductViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
}
#pragma  mark---------banner轮播图

- (void)prepareScollView {
    CGFloat scrollW = [UIScreen mainScreen].bounds.size.width;
    CGFloat scrollH = 150;
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, scrollW, scrollH)];
    scrollView.delegate = self;
    
    for (int i = 0; i < count; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        NSString *name = @"banner1";
        imageView.image = [UIImage imageNamed:name];
        CGFloat imageX = scrollW * (i + 1);
        imageView.frame = CGRectMake(imageX, 0, scrollW, scrollH);
        [scrollView addSubview:imageView];
    }
    
    UIImageView *firstImage = [[UIImageView alloc] init];
    firstImage.image = [UIImage imageNamed:@"banner1"];
    firstImage.frame = CGRectMake(0, 0, scrollW, scrollH);
    [scrollView addSubview:firstImage];
    scrollView.contentOffset = CGPointMake(scrollW, 0);
    
    UIImageView *lastImage = [[UIImageView alloc] init];
    lastImage.image = [UIImage imageNamed:@"banner1"];
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
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
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

-(void)viewWillAppear:(BOOL)animated{
    //即将出现时浮现tabbar
    AppDelegate *delegate=[UIApplication sharedApplication].delegate;
    delegate.myTabar.hidden=NO;
    
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
