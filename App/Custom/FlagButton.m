//
//  FlagButton.m
//  App
//
//  Created by Gaiminghui on 16/4/15.
//  Copyright © 2016年 company. All rights reserved.
//

#import "FlagButton.h"

@implementation FlagButton
-(void)makeFlag{
    
    self.img=[[UIImageView alloc]initWithFrame:CGRectMake(35, 3, 13, 12)];
    self.img.image=[UIImage imageNamed:@"color"];
//    self.img.backgroundColor=[UIColor redColor];
//    self.img.layer.masksToBounds=YES;
//    self.img.layer.cornerRadius=20;
    [self addSubview:self.img];
    
    self.flagLable=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 13, 12)];
    self.flagLable.backgroundColor=[UIColor clearColor];
    self.flagLable.text=@"1";
    self.flagLable.textAlignment=NSTextAlignmentCenter;
    self.flagLable.font=[UIFont systemFontOfSize:12];
    [self.flagLable setTextColor:[UIColor whiteColor]];
    [self.img addSubview:self.flagLable];
    
    
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
