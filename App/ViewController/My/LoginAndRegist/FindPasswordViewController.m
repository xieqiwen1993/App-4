//
//  FindPasswordViewController.m
//  App
//
//  Created by Gaiminghui on 16/4/11.
//  Copyright © 2016年 company. All rights reserved.
//

#import "FindPasswordViewController.h"
#import "NewPasswordViewController.h"

@interface FindPasswordViewController ()

@end

@implementation FindPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    
    // Do any additional setup after loading the view from its nib.
}

-(void)initView{
    
    self.title=@"找回密码";
    self.getImgImageView.frame=CGRectMake(self.getVerifyBtn.frame.origin.x, self.imageText.frame.origin.y, self.getVerifyBtn.frame.size.width, self.getVerifyBtn.frame.size.height);
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)getVerifyNum:(id)sender {
    
    }

- (IBAction)nextClick:(id)sender {
    NewPasswordViewController *vc=[[NewPasswordViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];

}
@end
