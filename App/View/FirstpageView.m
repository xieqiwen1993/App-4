//
//  FirstpageView.m
//  App
//
//  Created by Gaiminghui on 16/4/7.
//  Copyright © 2016年 company. All rights reserved.
//

#import "FirstpageView.h"

@implementation FirstpageView
//初始化
+(FirstpageView*)init{
    
    FirstpageView *Fview=[[[NSBundle mainBundle]loadNibNamed:@"FirstpageView" owner:nil options:nil]lastObject];
    

    Fview.layer.masksToBounds=YES;
    Fview.layer.cornerRadius=7.0;
    
    
    return Fview;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
