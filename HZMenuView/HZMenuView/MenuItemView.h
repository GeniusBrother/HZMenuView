//
//  MenuItemView.h
//  mcapp
//
//  Created by xzh on 15/11/2.
//  Copyright © 2015年 zhuchao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuItemView : UIView

/**
 *  重写来做些初始化设置
 */
- (void)setup;

/**
 *  重写来请求,第一次显示时自动调用
 */
- (void)loadRemoteData;

/**
 *  重写来加载子视图
 */
- (void)loadSubViews;

/**
 *  显示/隐藏视图
 */
- (void)showItem:(BOOL)isShow;

/**
 *  调用根控制器的viewDidAppear时会调用正在显示的MenuItemView的viewDidAppear
 */
- (void)viewDidAppear;



@end
