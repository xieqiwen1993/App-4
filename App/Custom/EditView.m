//
//  EditView.m
//  App
//
//  Created by Gaiminghui on 16/4/15.
//  Copyright © 2016年 company. All rights reserved.
//

#import "EditView.h"


@implementation EditView
-(id)initWithFrame:(CGRect)frame{
    
    self=[super initWithFrame:frame];
    if (self) {
        
        [self makeView];
    }
    
    return self;
}

-(void)makeView{
    //自定义邮件消息按钮
    //UIView *homeButtonView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 55, 40)];
    UIImageView *homeButtonImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 48, 32)];
    homeButtonImageView.image = [UIImage imageNamed:@"color"];
    self.homeButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 48, 32)];
    self.homeButton.backgroundColor = [UIColor clearColor];
    [self.homeButton setTitle:@"编辑" forState:UIControlStateNormal];
    [self.homeButton setTintColor:[UIColor whiteColor]];
    self.homeButton.titleLabel.font=[UIFont systemFontOfSize:13];
//    [self.homeButton addTarget:self action:@selector(messageClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:homeButtonImageView];
    [self addSubview:self.homeButton];

}
-(void)maketitleWith:(NSString *)name{
    
    [self.homeButton setTitle:name forState:UIControlStateNormal];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
