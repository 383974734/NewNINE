//
//  MakeAppointmentViewController.h
//  VeryBeautiful
//
//  Created by yinduo-zdy on 16/5/19.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//
//  -----------> 预约控制器

#import "BaseViewController.h"

@interface MakeAppointmentViewController : BaseViewController

/** 设计师ID*/
@property (nonatomic, copy) NSString *stylistinfoId;


/** 是否是追加订单  1 否  2 是*/ //   1.不是追加订单    2.追加订单
@property (nonatomic, copy) NSString *noChoice;

@end
