//
//  TitleView.m
//  Txs2.0Page
//
//  Created by huangkai on 15/9/11.
//  Copyright (c) 2015年 homer. All rights reserved.
//

#import "TitleView.h"

@implementation TitleView

-(id)initWithFrame:(CGRect)frame{

    self=[super initWithFrame:frame];
    if (self) {
     
        [self creatView];
    }

    return self;
}

-(void)creatView{
    self.backgroundColor=[UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1];
    self.titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(0,30*kScreenHeight/2208, kScreenWidth, 88*kScreenHeight/2208)];
    self.titleLabel.backgroundColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:1];
     [self addSubview:self.titleLabel];
}


-(void)titleName:(NSString *)name{
   self.titleLabel.text=name;
    
}
@end
