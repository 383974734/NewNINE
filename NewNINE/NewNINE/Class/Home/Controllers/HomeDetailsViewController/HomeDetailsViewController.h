//
//  HomeDetailsViewController.h
//  NewNINE
//
//  Created by yinduo-zdy on 16/5/30.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//
//  首页-----------> 首页发型详情控制器

#import "BaseViewController.h"

@class HomeBannerModels;
@class HairstyleViewControllerModel;

@interface HomeDetailsViewController : BaseViewController


@property (nonatomic, strong) HomeBannerModels *dataModel;

@property (nonatomic, strong) HairstyleViewControllerModel *hairstyleModel;

@end
