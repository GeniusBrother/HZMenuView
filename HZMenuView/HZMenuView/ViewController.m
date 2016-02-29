//
//  ViewController.m
//  HZMenuView
//
//  Created by xzh on 16/2/29.
//  Copyright © 2016年 GeniusBrother. All rights reserved.
//
#define kDeviceWidth [[UIScreen mainScreen] bounds].size.width
#define kDeviceHeight [[UIScreen mainScreen] bounds].size.height
#define kLeftSlidWidth (kDeviceWidth - kDeviceWidth *80.0/375)
#import "ViewController.h"
#import "HZMenuView.h"
#import "UIView+HZExtend.h"
#import "MenuItemView.h"
#import "RecommendItemView.h"
#import "HZURLManager.h"
@interface ViewController ()<HZMenuViewDelegate,UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, weak) HZMenuView *menuView;
@property(nonatomic, weak) MenuItemView *selectedItem;
@property(nonatomic, strong) NSMutableArray *itemViews;
@property(nonatomic, weak) UIView *barView;
@property(nonatomic, weak) UITableView *tableView;

@property(nonatomic, strong) NSArray *dataArray;

@end

@implementation ViewController
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.selectedItem viewDidAppear];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    _dataArray =     @[
                       @{
                           @"title":@"点击凭借URL跳转到其它页面",
                           @"detail":@"这部分内容详见:https://github.com/GeniusBrother/HZURLManager",
                           @"url":@"hz://urlItem"
                           }
                       ];
    
    [self loadSubView];

}

- (void)loadSubView
{
    [self loadLeftSide];
    
    /**
     *  初始化
     *  LeftViewWidth:左边侧栏的宽度
     *  rightViewWidth:0表示无右边侧边栏
     */
    HZMenuView *menuView = [HZMenuView menuViewWithLeftViewWidth:kLeftSlidWidth rightViewWidth:0 delegate:self];
    menuView.backgroundColor = [UIColor whiteColor];
    menuView.frame = self.view.bounds;
    [self.view addSubview:menuView];
    self.menuView = menuView;
    
    [self loadMenu];
    [self loadBarView];
}

- (void)loadMenu
{
    _itemViews = [NSMutableArray arrayWithCapacity:2];
    for (NSInteger i=0; i<2; i++) {
        RecommendItemView *itemView = [[RecommendItemView alloc] initWithFrame:self.menuView.bounds];
        [self.menuView addSubview:itemView];
        [self.itemViews addObject:itemView];
  
        if (i == 0) self.selectedItem = itemView;
    }
    
    [self.selectedItem showItem:YES];
}

- (void)loadBarView
{
    UIView *barView = [[UIView alloc] init];
    barView.backgroundColor = [UIColor whiteColor];
    barView.frame = CGRectMake(0, 0, kDeviceWidth, 64);
    [self.menuView addSubview:barView];
    self.barView = barView;
    
    CGFloat xspace = 18;
    UIView *rightView  = [self rightBarView];
    rightView.top = (barView.height - rightView.height)/2+8;
    rightView.centerX = kDeviceWidth/2;
    [barView addSubview:rightView];
    
    for (NSInteger i=0; i<2; i++) {
        CGFloat avatarWH = 30;
        UILabel *avatar = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, avatarWH, avatarWH)];
        avatar.tag = i;
        avatar.text = @"点击";
        avatar.font = [UIFont systemFontOfSize:14.0f];
        avatar.centerY = rightView.centerY;
        avatar.backgroundColor = [UIColor greenColor];
        avatar.layer.cornerRadius = avatarWH/2;
        avatar.layer.masksToBounds = YES;
        avatar.userInteractionEnabled = YES;
        avatar.contentMode = UIViewContentModeScaleAspectFill;
        avatar.clipsToBounds = YES;
        [barView addSubview:avatar];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [avatar addGestureRecognizer:tap];
        
        if (i==0) {
            avatar.left = xspace;
        }else {
            [avatar alignRight:-xspace];
        }

    }
}

- (UIView *)rightBarView
{
    CGFloat length = 101;
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, length, 40)];
    rightView.backgroundColor = [UIColor clearColor];
    CGFloat x=0;
    CGFloat w=40;
    for (NSInteger i=0; i<2; i++) {
        UIButton *imageView = [UIButton buttonWithType:UIButtonTypeCustom];
        imageView.backgroundColor = [UIColor brownColor];
        [imageView setTitle:[NSString stringWithFormat:@"页面%ld",i+1] forState:UIControlStateNormal];
        [imageView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        imageView.titleLabel.font = [UIFont systemFontOfSize:14];
        imageView.tag = i;
        [imageView addTarget:self action:@selector(selectedChange:) forControlEvents:UIControlEventTouchUpInside];
        imageView.frame = CGRectMake(x+i*60, (rightView.height-20)/2, w, 20);
        
        [rightView addSubview:imageView];

    }
    return rightView;
}

#pragma mark  LeftSide
- (void)loadLeftSide
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    NSDictionary *dic = [self.dataArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [dic objectForKey:@"title"];
    cell.detailTextLabel.text = [dic objectForKey:@"detail"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = [self.dataArray objectAtIndex:indexPath.row];
    NSString *urlstring = [dic objectForKey:@"url"];
    
    [HZURLManager pushViewControllerWithString:urlstring animated:YES];
}

#pragma mark - Action
- (void)selectedChange:(UIButton *)sender
{
    NSInteger tag = sender.tag;
    
    MenuItemView *itemView = [self.itemViews objectAtIndex:tag];
    [itemView showItem:YES];
    [self.selectedItem showItem:NO];
    self.selectedItem = itemView;
}

- (void)tap:(UITapGestureRecognizer *)tap
{
    NSInteger tag = tap.view.tag;
    if (tag == 0) {
        [self.menuView openLeftMenu];
    }else {
        [self.menuView openRightMenu];
    }
}



@end
