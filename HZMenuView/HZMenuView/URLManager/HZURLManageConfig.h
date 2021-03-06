//
//  HZURLManageConfig.h
//  HZNetworkDemo
//
//  Created by xzh on 16/2/27.
//  Copyright © 2016年 xzh. All rights reserved.
//  项目网址:https://github.com/GeniusBrother/HZURLManager
//
//  结合MVVM以及MVC优点的架构HZExtend:https://github.com/GeniusBrother/HZExtend
//  项目特点
//  1.解放VC:基于MVVM的思想，将数据处理放入ViewModel里从而减少控制器的压力，降低代码耦合.
//  2.网络请求:基于AFN自定义了贴切业务逻辑的网络请求框架.
//  3.缓存体系:基于TMCache定制与业务逻辑相符的缓存体系.
//  4.数据元组:基于FMDB实现了与表元组对应的数据模型.
//  5.URLManager:支持URL跳转
//  6.一些常用的基础类扩展.

#import <Foundation/Foundation.h>
#import "Singleton.h"
/**
 *  URLManager中的数据配置器
 */
@interface HZURLManageConfig : NSObject
singleton_h(Config)
/**
 *  URL->class配置参数,键值对形式为: URL:Class of UIViewController
 *  需先初始化
 */
@property(nonatomic, strong) NSDictionary *config;

/**
 *  指定传入http等URL时应生成控制器的名称,最好能继承HZWebViewController
 */
@property(nonatomic, strong) NSString *classOfWebViewCtrl;

@end
