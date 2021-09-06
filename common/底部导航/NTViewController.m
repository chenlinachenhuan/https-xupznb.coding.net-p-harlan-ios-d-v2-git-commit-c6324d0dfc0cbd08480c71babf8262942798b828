//
//  NTViewController.m
//  tabbarDemo
//
//  Created by MD101 on 14-10-8.
//  Copyright (c) 2014年 TabBarDemo. All rights reserved.
//

#import "NTViewController.h"
#import "NTButton.h"
#import "BaseNavigationViewController.h"
#import "Agro_homeViewController.h"
#import "Agro_serviceViewController.h"
#import "Agro_personalViewController.h"
#import "Agro_shoppingCarViewController.h"
@interface NTViewController (){

    UIImageView *_tabBarView;//自定义的覆盖原先的tarbar的控件
    NTButton * _previousBtn;//记录前一次选中的按钮
    int count;
}

@end

@implementation NTViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
        self.title = @"";
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //wsq
    for (UIView* obj in self.tabBar.subviews) {
        if (obj != _tabBarView) {//_tabBarView 应该单独封装。
            [obj removeFromSuperview];
        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self viewWillLayoutSubviews];
    _tabBarView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 49)];
    _tabBarView.userInteractionEnabled = YES;
   _tabBarView.backgroundColor = [UIColor whiteColor];
    [self.tabBar addSubview:_tabBarView];
    
    //设置底部导航的背景图片
//    UIImageView *backgroundImg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _tabBarView.frame.size.width, 49)];
//    [backgroundImg setImage:[UIImage imageNamed:@"cai_dan_bg"]];
//    [_tabBarView addSubview:backgroundImg];
        
    Agro_homeViewController * homeVC = [[Agro_homeViewController alloc]init];
    UINavigationController * navi1 = [[BaseNavigationViewController alloc]initWithRootViewController:homeVC];
    Agro_serviceViewController * serviceVC = [[Agro_serviceViewController alloc]init];
    UINavigationController * navi2 = [[BaseNavigationViewController alloc]initWithRootViewController:serviceVC];
    Agro_shoppingCarViewController * shoppingCarVC = [[Agro_shoppingCarViewController alloc]init];
    UINavigationController * navi3 = [[BaseNavigationViewController alloc]initWithRootViewController:shoppingCarVC];
    Agro_personalViewController * personalVC = [[Agro_personalViewController alloc]init];
    UINavigationController * navi4 = [[BaseNavigationViewController alloc]initWithRootViewController:personalVC];
    
    self.viewControllers = [NSArray arrayWithObjects:navi1,navi2,navi3,navi4, nil];
    count = 4;
    [self creatButtonWithNormalName:@"" andSelectName:@"" andTitle:@"首页" andIndex:0];
    [self creatButtonWithNormalName:@"" andSelectName:@"" andTitle:@"服务" andIndex:1];
    [self creatButtonWithNormalName:@"" andSelectName:@"" andTitle:@"购物车" andIndex:2];
    [self creatButtonWithNormalName:@"" andSelectName:@"" andTitle:@"我的" andIndex:3];
 
    NTButton * button = _tabBarView.subviews[0];
    [self changeViewController:button];
    
    // Do any additional setup after loading the view.
}
-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [child removeFromSuperview];
        }
    }
}
#pragma mark 创建一个按钮

- (void)creatButtonWithNormalName:(NSString *)normal andSelectName:(NSString *)selected andTitle:(NSString *)title andIndex:(int)index{
    
    NTButton * customButton = [NTButton buttonWithType:UIButtonTypeCustom];
    customButton.tag = index;
    CGFloat buttonW = _tabBarView.frame.size.width / count;
    CGFloat buttonH = _tabBarView.frame.size.height;
    customButton.frame = CGRectMake(_tabBarView.frame.size.width / count * index, 0, buttonW, buttonH);
    [customButton setImage:[UIImage imageNamed:normal] forState:UIControlStateNormal];
    [customButton setImage:[UIImage imageNamed:selected] forState:UIControlStateSelected];
    [customButton setTitle:title forState:UIControlStateNormal];
    [customButton addTarget:self action:@selector(changeViewController:) forControlEvents:UIControlEventTouchDown];
    customButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    customButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [customButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [customButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    customButton.titleLabel.font = [UIFont fontWithName:@"Marion" size:13];
    customButton.backgroundColor=[UIColor clearColor];
    customButton.titleLabel.numberOfLines = 0;
    
    [_tabBarView addSubview:customButton];
    if(index == 0)//设置第一个选择项。（默认选择项） wsq
    {
        _previousBtn = customButton;
        _previousBtn.selected = YES;
    }
}

#pragma mark 按钮被点击时调用
- (void)changeViewController:(NTButton *)sender
 {
    if(self.selectedIndex != sender.tag){ //wsq®
        self.selectedIndex = sender.tag; //切换不同控制器的界面
        _previousBtn.selected = ! _previousBtn.selected;
        _previousBtn = sender;
        _previousBtn.selected = YES;
     }
}
@end
