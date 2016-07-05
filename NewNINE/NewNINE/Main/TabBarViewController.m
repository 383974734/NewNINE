//
//  TabBarViewController.m
//  ClientNINE
//
//  Created by yinduo-zdy on 16/5/3.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//

#import "TabBarViewController.h"

// ---------------------- 框架工具类 ----------------------
#import "MainNavigationController.h"
#import "RDVTabBarController.h"         //  RDVTabBarController
#import "RDVTabBarItem.h"               //  RDVTabBarItem
// ---------------------- 框架工具类 ----------------------

// ---------------------- controller --------------------
#import "BaseViewController.h"  // 父视图
#import "HomeViewController.h"
#import "DesignerViewController.h"
#import "MakeAppointmentViewController.h"
#import "HairstyleViewController.h"
#import "MyViewController.h"

// ---------------------- controller ----------------------

@interface TabBarViewController ()<RDVTabBarControllerDelegate>

@end

@implementation TabBarViewController

#pragma mark - Lifecycle Methods
/**
 *  视图载入完成 调用
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self settingViewControllers];
    self.delegate = self;
}

/**
 *  内存不足时 调用
 */
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setting ViewControllers
/**
 *  设置 导航控制器
 */
-(void) settingViewControllers {
    NSArray *controllerNames = @[
                                 @"HomeViewController",
                                 @"DesignerViewController",
                                 @"temp",//MakeAppointmentViewController
                                 @"HairstyleViewController",
                                 @"MyViewController",
                                 ];
    NSMutableArray *controllers  = [[NSMutableArray alloc]init];
    for (NSString *controllerName in controllerNames) {
        BaseViewController* bvc      = [[[NSClassFromString(controllerName) class] alloc]init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:bvc];
        [controllers addObject:nav];
    }
    
    [[UINavigationBar appearance] setTintColor:SWPUIColorFromRGB(0x50e5c8)];
    [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
    [self setViewControllers:controllers];
    [self settingTabBarForController:self];
}



#pragma mark - Setting TabBarForController Propertys
/**
 *  设置 导航 TabBar 属性 Property
 *
 *  @param tabBarController
 */
- (void)settingTabBarForController:(RDVTabBarController *)tabBarController {
    
    //设置tab透明背景
    [tabBarController.tabBar setTranslucent:YES];
    tabBarController.tabBar.backgroundView.backgroundColor = [UIColor whiteColor];
    
    
    [self addSeparateWith:tabBarController];
    
    //设置选中图片
    NSArray *tabBarItemImages  = @[
                                   @"home",
                                   @"designer",
                                   @"makeAppointment",
                                   @"hairstyle",
                                   @"my",
                                   ];
    
    NSArray *tabBarItemNames  = @[
                                  @"首页",
                                  @"设计师",
                                  @"",
                                  @"发型",
                                  @"我的",
                                  ];
    
    NSInteger index = 0;
    for (RDVTabBarItem *item in [[tabBarController tabBar] items]) {
        [item setBackgroundSelectedImage:nil withUnselectedImage:nil];
        UIImage *selectedimage   = [UIImage imageNamed:[NSString stringWithFormat:@"%@_sel",
                                                        [tabBarItemImages objectAtIndex:index]]];
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_no",
                                                        [tabBarItemImages objectAtIndex:index]]];
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        
        //设置item名称
        NSString* itemTitle=[tabBarItemNames objectAtIndex:index];
        [item setTitle:itemTitle];
        
        if (index == 2) {
            [item setFinishedSelectedImage:[UIImage imageNamed:@"select_formwork"] withFinishedUnselectedImage:[UIImage imageNamed:@"select_formwork"]];
            item.badgePositionAdjustment = UIOffsetMake(0,  40);
        }
        
        // 设置item距离图片距离
        
        // 设置itemtitle选中颜色以及未选中颜色
        // 未选中
        [item setUnselectedTitleAttributes: @{
                                              NSFontAttributeName: [UIFont systemFontOfSize:10],
                                              NSForegroundColorAttributeName:SWPUIColorFromRGB(0xafafaf),
                                              }];
        // 选中
        [item setSelectedTitleAttributes: @{
                                            NSFontAttributeName: [UIFont systemFontOfSize:10],
                                            NSForegroundColorAttributeName:SWPUIColorFromRGB(0xdf0001),
                                            }];
        index++;
    }
    
    tabBarController.selectedIndex = 0;
}

#pragma mark - 添加线到 tabBar 上
/**
 *
 *
 *  @param tabBarController
 */
- (void) addSeparateWith:(RDVTabBarController *)tabBarController {
    
    
    // 上方的线
    CAShapeLayer *subLayer = [CAShapeLayer layer];
    subLayer.frame         = CGRectMake(0, 0, SCREEN_WIDTH, 1);
    subLayer.borderWidth   = 0.5f;
    subLayer.borderColor   = SWPUIColorFromRGB(0xebebeb).CGColor;
    
    [tabBarController.tabBar.backgroundView.layer addSublayer:subLayer];
}

/**
 *  返回 状态栏字体样式
 *
 *  @return 返回白色
 */
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

/**
 * Tells the delegate that the user selected an item in the tab bar.
 */
- (void)tabBarController:(RDVTabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {

    [self.navigationController pushViewController:[MakeAppointmentViewController alloc] animated:YES];
}

- (void)tabBar:(RDVTabBar *)tabBar didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"%ld", (long)index);
    if (index == 2) {
        
//       [self.navigationController pushViewController:[MakeAppointmentViewController alloc] animated:YES];
        self.rdv_tabBarController.selectedIndex = index;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"cancelOrderCallBack" object:nil userInfo:nil];
    }else {
        if (index < 0 || index >= [[self viewControllers] count]) {
            return;
        }
        [self setSelectedIndex:index];
        NSLog(@"%@", [self viewControllers][index]);
        if ([[self delegate] respondsToSelector:@selector(tabBarController:didSelectViewController:)]) {
            [[self delegate] tabBarController:self didSelectViewController:[self viewControllers][index]];
        }
    }
}


@end
