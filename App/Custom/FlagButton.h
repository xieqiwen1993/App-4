//
//  FlagButton.h
//  App
//
//  Created by Gaiminghui on 16/4/15.
//  Copyright © 2016年 company. All rights reserved.
//

#import <UIKit/UIKit.h>
//我的消息角标
@interface FlagButton : UIButton

@property(nonatomic,strong)UILabel *flagLable;
@property(nonatomic,strong)UIImageView *img;
@property(nonatomic,assign)NSInteger numMessa;
-(void)makeFlag;
@end
