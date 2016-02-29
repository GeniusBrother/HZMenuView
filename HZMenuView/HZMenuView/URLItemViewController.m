//
//  URLItemViewController.m
//  HZMenuView
//
//  Created by xzh on 16/2/29.
//  Copyright © 2016年 GeniusBrother. All rights reserved.
//

#import "URLItemViewController.h"
#import "HZURLManager.h"
@interface URLItemViewController ()

@end

@implementation URLItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor brownColor];
    
    CGFloat viewWidth = self.view.frame.size.width;
    CGFloat viewHeight = self.view.frame.size.height;
    UIButton *pageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    pageBtn.frame = CGRectMake((viewWidth -150)/2, (viewHeight-30)/2, 150, 30);
    [pageBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [pageBtn setTitle:@"点击返回" forState:UIControlStateNormal];
    [pageBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    pageBtn.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:pageBtn];
    
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    tipLabel.frame = CGRectMake((viewWidth -300)/2, (viewHeight-30)/2+45, 300, 30);
    tipLabel.text = @"自定义导航控制器,可以全屏侧滑返回";
    tipLabel.textColor = [UIColor blackColor];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.font = [UIFont systemFontOfSize:16];
    tipLabel.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:tipLabel];
}

- (void)btnClick:(UIButton *)sender
{
    [HZURLManager dismissCurrentAnimated:YES];
}



@end
