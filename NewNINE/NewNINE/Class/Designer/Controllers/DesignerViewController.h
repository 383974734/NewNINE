//
//  DesignerViewController.h
//  VeryBeautiful
//
//  Created by yinduo-zdy on 16/5/19.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//
//  -----------> 设计师控制器

#import "BaseViewController.h"

@class DesignerViewController;

@protocol DesignerViewControllerDelegate <NSObject>

@optional
/**
 *  点击设计师跳转预约界面
 *
 *  @param designerViewController DesignerViewController
 *  @param stylistinfoId          预约的设计师id
 */
- (void)designerViewController:(DesignerViewController *)designerViewController stylistinfoId:(NSString *)stylistinfoId;;

@end


@interface DesignerViewController : BaseViewController



{
    int index ;
}

/** 是否显示tab状态    1 不显示tab*/
@property (nonatomic, copy) NSString *stateStr;

@property (nonatomic, assign) id<DesignerViewControllerDelegate> delegate;

@end
