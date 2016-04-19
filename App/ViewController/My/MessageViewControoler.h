//
//  MessageViewControoler.h
//  App
//
//  Created by Gaiminghui on 16/4/11.
//  Copyright © 2016年 company. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageViewControoler : UIViewController


@property (weak, nonatomic) IBOutlet UIButton *readBtn;


@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;

- (IBAction)readClick:(id)sender;

- (IBAction)deleteClcik:(id)sender;


@end
