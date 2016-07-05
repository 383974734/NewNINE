//
//  CityViewController.h
//  NewNINE
//
//  Created by yinduo-zdy on 16/6/13.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//
//  -----------> 定位城市，当前城市控制器

#import "BaseViewController.h"

@interface CityViewController : BaseViewController

@property (nonatomic, strong) NSArray *cityArray;
/** 定位*/
@property (nonatomic, copy) NSString *locationCityStr;
/** 热门*/
@property (nonatomic, copy) NSString *hotCityStr;


@end
