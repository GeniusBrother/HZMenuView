//
//  HZMenuView.m
//  LeftMenu
//
//  Created by xzh on 15/11/2.
//  Copyright © 2015年 GeniusBrother. All rights reserved.
//

#import "HZMenuView.h"
static const NSTimeInterval kAnimateTime = 0.3;
@interface HZMenuView ()
@property(nonatomic, weak) UIView *coverView;

@property(nonatomic, assign) CGFloat leftViewWidth;
@property(nonatomic, assign) CGFloat rightViewWidth;

@end
@implementation HZMenuView

#pragma mark - init
+ (instancetype)menuViewWithLeftViewWidth:(CGFloat)left
                           rightViewWidth:(CGFloat)right
                                 delegate:(id<HZMenuViewDelegate>)delegate
{
    HZMenuView *menuView = [[HZMenuView alloc] initWithLeftViewWidth:left rightViewWidth:right];
    menuView.delegate = delegate;
    return menuView;
}

- (instancetype)initWithLeftViewWidth:(CGFloat)left rightViewWidth:(CGFloat)right
{
    self = [super init];
    if (self) {
        self.leftViewWidth = left;
        self.rightViewWidth = right;
        [self setup];
    }
    return self;
}

- (void)setup
{
    //UI
    [self loadShadow];
}

- (void)loadShadow
{
    self.backgroundColor = [UIColor whiteColor];
    self.layer.shadowOffset = CGSizeMake(0, 0);
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowRadius = 5;
    self.layer.shadowOpacity = 0.8;
    
}

#pragma mark - Animate
//水平动画移动Menu至x处
- (void)moveMenuWithX:(CGFloat)x
{
    MenuViewStatus oldStatus = self.status;
    [self willNotifyWithOffset:x oldStatus:oldStatus];
    
    CGRect tempFrame = self.frame;
    tempFrame.origin.x = x;
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:kAnimateTime animations:^{
        weakSelf.frame = tempFrame;
        weakSelf.coverView.alpha = x==0?0:1;
    } completion:^(BOOL finished) {
        [weakSelf didNotifyWithOffset:x oldStatus:oldStatus];
    }];
}

#pragma mark - 操作
- (void)openLeftMenu
{
    if (self.isClose&&self.leftViewWidth>0)
    [self moveMenuWithX:self.leftViewWidth];
}

- (void)openRightMenu
{
    if (self.isClose && self.rightViewWidth>0)
    [self moveMenuWithX:-self.rightViewWidth];
}

- (void)closeMenu
{
    [self moveMenuWithX:0];
}

#pragma mark - 状态数据
- (MenuViewStatus)status
{
    MenuViewStatus status = self.frame.origin.x==0?MenuViewStatusClose:MenuViewStatusLeft;
    return status;
}

- (BOOL)isClose
{
    return self.status == MenuViewStatusClose;
}

#pragma mark - 回调通知
- (void)willNotifyWithOffset:(CGFloat)offset oldStatus:(MenuViewStatus)status
{
    if (offset == 0) {
        if ([self.delegate respondsToSelector:@selector(menuView:willCloseSlide:)]) {
            MenuView type = status == MenuViewStatusLeft?MenuViewLeft:MenuViewRight;
            [self.delegate menuView:self willCloseSlide:type];
        }
    }else if(offset>0){
        if ([self.delegate respondsToSelector:@selector(menuView:willOpenSlide:)]) {
            [self.delegate menuView:self willOpenSlide:MenuViewLeft];
        }
    }else {
        if ([self.delegate respondsToSelector:@selector(menuView:willOpenSlide:)]) {
            [self.delegate menuView:self willOpenSlide:MenuViewRight];
        }
    }
}

- (void)didNotifyWithOffset:(CGFloat)offset oldStatus:(MenuViewStatus)status
{
    if (offset == 0) {
        if ([self.delegate respondsToSelector:@selector(menuView:didCloseSlide:)]) {
            MenuView type = status == MenuViewStatusLeft?MenuViewLeft:MenuViewRight;
            [self.delegate menuView:self didCloseSlide:type];
        }
    }else if(offset>0){
        if ([self.delegate respondsToSelector:@selector(menuView:didOpenSlide:)]) {
            [self.delegate menuView:self didOpenSlide:MenuViewLeft];
        }
    }else {
        if ([self.delegate respondsToSelector:@selector(menuView:didOpenSlide:)]) {
            [self.delegate menuView:self didOpenSlide:MenuViewRight];
        }
    }
}

#pragma mark - Setter
- (UIView *)coverView
{
    if (_coverView == nil) {
        UIView *coverView = [[UIView alloc] initWithFrame:self.bounds];
        coverView.backgroundColor = [UIColor clearColor];
        [self addSubview:coverView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
        [coverView addGestureRecognizer:tap];
        _coverView = coverView;
    }
    [self bringSubviewToFront:_coverView];
    return _coverView;
}

#pragma mark - Action
- (void)tapView:(UITapGestureRecognizer *)tap
{
    CGFloat viewX = self.frame.origin.x;
    if (viewX == 0) return;
    [self closeMenu];
}

@end
