//
//  HZMenuView.h
//  LeftMenu
//
//  Created by xzh on 15/11/2.
//  Copyright © 2015年 GeniusBrother. All rights reserved.
//  项目网址:https://github.com/GeniusBrother/HZMenuView
//
//  结合MVVM以及MVC优点的架构HZExtend:https://github.com/GeniusBrother/HZExtend
//  项目特点
//  1.解放VC:基于MVVM的思想，将数据处理放入ViewModel里从而减少控制器的压力，降低代码耦合.
//  2.网络请求:基于AFN自定义了贴切业务逻辑的网络请求框架.
//  3.缓存体系:基于TMCache定制与业务逻辑相符的缓存体系.
//  4.数据元组:基于FMDB实现了与表元组对应的数据模型.
//  5.URLManager:支持URL跳转
//  6.一些常用的基础类扩展.

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, MenuViewStatus) {
    MenuViewStatusClose = 0,    //menu为关闭状态
    MenuViewStatusLeft = 1,     //menu为左边开启状态
    MenuViewStatusRight = 1,    //menu为右边开启状态
};

typedef NS_ENUM(NSInteger, MenuView) {
    MenuViewLeft = 0,           //menu类型为左边栏
    MenuViewRight = 1,          //menu类型为右边栏
};
@class HZMenuView;
@protocol HZMenuViewDelegate<NSObject>

@optional
/**
 *  menu将要打开时调用,并传回打开的menu类型
 */
- (void)menuView:(HZMenuView *)menuView willOpenSlide:(MenuView)slide;

/**
 *  menu打开后调用,并传回打开的menu类型
 */
- (void)menuView:(HZMenuView *)menuView didOpenSlide:(MenuView)slide;

/**
 *  menu将要关闭时调用,并传回关闭的menu类型
 */
- (void)menuView:(HZMenuView *)menuView willCloseSlide:(MenuView)slide;

/**
 *  menu关闭后调用,并传回关闭的menu类型
 */
- (void)menuView:(HZMenuView *)menuView didCloseSlide:(MenuView)slide;
@end

@interface HZMenuView : UIView

@property(nonatomic, assign, readonly) CGFloat leftViewWidth;   //左菜单栏的宽度
@property(nonatomic, assign, readonly) CGFloat rightViewWidth;
@property(nonatomic, assign, readonly) MenuViewStatus status;
@property(nonatomic, weak) id<HZMenuViewDelegate> delegate;

/**
 *  推荐的初始化方法
 */
+ (instancetype)menuViewWithLeftViewWidth:(CGFloat)left
                           rightViewWidth:(CGFloat)right
                                 delegate:(id<HZMenuViewDelegate>)delegate;

/**
 *  打开侧栏
 */
- (void)openLeftMenu;
- (void)openRightMenu;

/**
 *  关闭侧栏
 */
- (void)closeMenu;
- (BOOL)isClose;
@end
