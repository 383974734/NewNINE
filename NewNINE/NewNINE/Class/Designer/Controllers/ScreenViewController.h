//
//  ScreenViewController.h
//  NewNINE
//
//  Created by yinduo-zdy on 16/6/13.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//
//  -----------> 筛选控制器

#import "BaseViewController.h"




@interface ScreenViewController : BaseViewController

/** 筛选 设计师职位id*///所选择的  需要传给上一个页面
typedef void (^ScreenViewID)(NSString *strID);
@property (nonatomic, strong)ScreenViewID screenViewID;
/** 筛选 设计师职位id*/



/** 被选择的设计师职位id*///上一个页面传过来的
@property (nonatomic, copy) NSString *stylistLevlsStrID;
@property (nonatomic, strong) NSMutableArray *arrayData;

@end
