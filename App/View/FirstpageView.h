//
//  FirstpageView.h
//  App
//
//  Created by Gaiminghui on 16/4/7.
//  Copyright © 2016年 company. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FirstpageView : UIView

@property (weak, nonatomic) IBOutlet UILabel *contenLable;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *backImageview;




+(FirstpageView *)init;
@end
