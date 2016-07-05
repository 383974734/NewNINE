//
//  MainNavigationController.m
//  ClientNINE
//
//  Created by yinduo-zdy on 16/5/3.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//

#import "MainNavigationController.h"

@interface MainNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation MainNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self settingUIPanGestureRecognizer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  自定义 返回手势
 */
- (void) settingUIPanGestureRecognizer {
    
    // 获取系统自带滑动手势的target对象
    id target = self.interactivePopGestureRecognizer.delegate;
    
    // 创建全屏滑动手势，调用系统自带滑动手势的target的action方法
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
    
    // 设置手势代理，拦截手势触发
    pan.delegate = self;
    
    // 给导航控制器的view添加全屏滑动手势
    [self.view addGestureRecognizer:pan];
    
    // 禁止使用系统自带的滑动手势
    self.interactivePopGestureRecognizer.enabled = NO;
}

/**
 *  UIPanGestureRecognizer 代理方法 (每次触发手势之前都会询问下代理，是否触发)
 *  作用 拦截手势触发
 *  @param gestureRecognizer
 *
 *  @return
 */
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    
    // 注意：只有非根控制器才有滑动返回功能，根控制器没有。
    // 判断导航控制器是否只有一个子控制器，如果只有一个子控制器，肯定是根控制器
    return self.childViewControllers.count == 1 ? NO : YES;
}


/**
 *  UIPanGestureRecognizer 绑定方法 不会走到 该方法 在代理方法做了拦截
 *
 *  @param pan
 */
- (void) handleNavigationTransition:(UIPanGestureRecognizer *)pan {
    NSLog(@"UIPanGestureRecognizer 绑定方法");
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
