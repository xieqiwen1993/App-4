//
//  EditView.h
//  App
//
//  Created by Gaiminghui on 16/4/15.
//  Copyright © 2016年 company. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditView : UIView
@property(nonatomic,strong)UIButton *homeButton;
@property(nonatomic,assign)BOOL isEdit;
-(void)maketitleWith:(NSString *)name;
@end
