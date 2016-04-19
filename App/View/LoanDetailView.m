//
//  LoanDetailView.m
//  App
//
//  Created by Gaiminghui on 16/4/11.
//  Copyright © 2016年 company. All rights reserved.
//

#import "LoanDetailView.h"
#import <QuartzCore/QuartzCore.h>
#import "UILabel+ContentSize.h"


@implementation LoanDetailView
+(LoanDetailView *)instanceTextView
{
    
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"LoanDetailView" owner:nil options:nil];
    return [nibView objectAtIndex:0];
}
-(UIView *)originalvIew{
    
    NSArray *arr=@[@"商品：iPhone1",@"商品：iPhone2",@"商品：iPhone3",@"商品：iPhone4",@"商品：iPhone5",@"商品：iPhone6",@"商品：iPhone7",@"商品：iPhone8",@"商品：iPhone9  伴随着张震岳的这首老歌，仿佛我又回到了过去，回到伴随着张震岳的这首老歌，回到随着张震岳的这首老歌，仿佛我又回到了"];
    UILabel *testLal=[[UILabel alloc]init];
    testLal.frame=CGRectMake(12, 10, kScreenWidth-80,20);
    testLal.font=[UIFont systemFontOfSize:14];
    testLal.numberOfLines=0;
    testLal.lineBreakMode=NSLineBreakByWordWrapping;
    testLal.text=[arr objectAtIndex:8];
    NSInteger height=[testLal contentSize].height;
    height=height+26*8+80;
    

    //背景
    UIView *viewBack=[[UIView alloc]initWithFrame:CGRectMake(0, 5, kScreenWidth-50, height)];
    UIImageView *imgV=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, viewBack.frame.size.width, viewBack.frame.size.height)];
    imgV.image=[UIImage imageNamed:@"便签纸"];

    //添加商品信息
    NSInteger y=0;
    [viewBack addSubview:imgV];
    //viewBack.backgroundColor=[UIColor cyanColor];
    for (int i=0; i<9; i++) {
        UILabel *lal=[[UILabel alloc]init];
        lal.frame=CGRectMake(12, 10+26*i, kScreenWidth-80,20);
        lal.font=[UIFont systemFontOfSize:14];
        lal.numberOfLines=0;
        lal.lineBreakMode=NSLineBreakByWordWrapping;
        lal.text=[arr objectAtIndex:i];
        
        NSMutableAttributedString *str=[[NSMutableAttributedString alloc]initWithString:lal.text];
        [str beginEditing];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(3, 7)];
        lal.attributedText=str;

        
        if (i==8) {
            [lal setFrame: CGRectMake(12, 10+26*i, kScreenWidth-80, [lal contentSize].height)];
            //lal.frame=CGRectMake(12, 10+26*(i-1), kScreenWidth-80,20);
        }
        [viewBack addSubview:lal];

        
        y=lal.frame.origin.y+[lal contentSize].height;
    }
    
    //添加图片信息
    UILabel *lalLine=[[UILabel alloc]initWithFrame:CGRectMake(5, y, viewBack.frame.size.width-10, 1)];
    lalLine.backgroundColor=[UIColor lightGrayColor];
    [viewBack addSubview:lalLine];
    
    NSArray *arr1=@[@"还款明细",@"提前结算",@"变更还款日",@"结算证明"];
    for (int i=0; i<4; i++) {
        NSInteger ax=viewBack.frame.size.width/4;
        UIImageView *imgView=[[UIImageView alloc]initWithFrame:CGRectMake(20+ax*i,y+5 , 28, 29)];
        imgView.image=[UIImage imageNamed:@"还款明细"];
        [viewBack addSubview:imgView];
        UILabel *titleL=[[UILabel alloc]initWithFrame:CGRectMake(13+ax*i, imgView.frame.origin.y+imgView.frame.size.height, 50, 16)];
        titleL.font=[UIFont systemFontOfSize:11];
        titleL.text=[arr1 objectAtIndex:i];
        [viewBack addSubview:titleL];
        //如果是还款明细，添加手势

        if (i==0) {
            self.tapImage=[[UIImageView alloc]init];
            self.tapImage=imgView;
                   
        }
        

        
    }
//    viewBack.layer.masksToBounds=YES;
//    viewBack.layer.cornerRadius=10;
    
    return viewBack;
}

-(void)tapClick{
    NSLog(@"000000000000");
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
