//
//  MyLoanView.m
//  App
//
//  Created by Gaiminghui on 16/4/11.
//  Copyright © 2016年 company. All rights reserved.
//

#import "MyLoanView.h"

@implementation MyLoanView
+(MyLoanView *)instanceTextView
{
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"MyLoanView" owner:nil options:nil];
    return [nibView objectAtIndex:0];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
