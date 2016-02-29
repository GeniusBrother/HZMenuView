//
//  RecommendItemView.m
//  mcapp
//
//  Created by xzh on 15/11/2.
//  Copyright © 2015年 zhuchao. All rights reserved.
//

#import "RecommendItemView.h"
#import "UIView+HZExtend.h"
@interface RecommendItemView ()


@end

@implementation RecommendItemView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

#pragma mark - 继承重写来回调
- (void)setup
{
    [super setup];
    
    //初始化配置
}

- (void)loadSubViews
{
    [super loadSubViews];
    
    //加载子视图
    static NSInteger i = 0;
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLabel.size = CGSizeMake(self.width, 350);
    titleLabel.numberOfLines = 0;
    if (i==0) {
        titleLabel.text = @"项目网址:https://github.com/GeniusBrother/HZMenuView\n\nHZExtend:结合MVVM以及MVC优点的架构:\nhttps://github.com/GeniusBrother/HZExtend\n项目特点\n\n1.解放VC:基于MVVM的思想，将数据处理放入ViewModel里从而减少控制器的压力，降低代码耦合.\n\n2.网络请求:基于AFN自定义了贴切业务逻辑的网络请求框架.\n\n3.缓存体系:基于TMCache定制与业务逻辑相符的缓存体系.\n\n4.数据元组:基于FMDB实现了与表元组对应的数据模型.\n\n5.URLManager:支持URL跳转\n\n6.一些常用的基础类扩展.";
        self.backgroundColor = [UIColor redColor];
    }else {
        titleLabel.text = @"ItemB";
        self.backgroundColor = [UIColor greenColor];
    }

    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.backgroundColor = [UIColor brownColor];
    [self addSubview:titleLabel];

    [titleLabel alignCenter];
    
    i++;
}

- (void)loadRemoteData
{
    [super loadRemoteData];
    
    //做些网络请求,第一次显示时自动调用
    
}

- (void)viewDidAppear
{
    [super viewDidAppear];
}
@end
