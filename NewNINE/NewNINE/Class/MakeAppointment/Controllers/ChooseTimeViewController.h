//
//  ChooseTimeViewController.h
//  NewNINE
//
//  Created by yinduo-zdy on 16/6/23.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//
//  -----------> 选择时间控制器

#import "BaseViewController.h"

@interface ChooseTimeViewController : BaseViewController
{
    int indexPage ;
}

/** 已经选定的预约时间*/
@property (nonatomic, copy) NSString *makeTime;

@property (nonatomic, copy) NSString *stylistinfoId;


@end
