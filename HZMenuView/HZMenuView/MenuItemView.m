//
//  MenuItemView.m
//  mcapp
//
//  Created by xzh on 15/11/2.
//  Copyright © 2015年 zhuchao. All rights reserved.
//

#import "MenuItemView.h"
@interface MenuItemView ()

@property(nonatomic, assign) BOOL firstShow;

@end

@implementation MenuItemView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {        
        [self setup];
    }
    return self;
}

- (void)setup
{
    _firstShow = YES;
    
    self.backgroundColor = [UIColor clearColor];
    self.hidden = YES;  //初始化隐藏
}

#pragma mark - UI
- (void)loadSubViews
{
    
}

#pragma mark - Data
- (void)loadRemoteData
{
    
}

#pragma mark - Public Method
- (void)showItem:(BOOL)isShow
{
    if (isShow) {
        if (self.firstShow) {
            [self loadSubViews];
            [self loadRemoteData];
            self.firstShow = NO;
        }
        if (self.hidden) {
            self.hidden = NO;
        }
        
    }else {
        if (!self.hidden) {
            self.hidden = YES;
        }
    }
}

- (void)viewDidAppear {}

@end
