//
//  CommonInformationView.h
//  NewNINE
//
//  Created by yinduo-zdy on 16/6/15.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//
//  -----------> 公共的视图   封装   用来介绍设计师信息

#import <UIKit/UIKit.h>

@class DesignerViewModel;

@class CommonInformationView;

@protocol CommonInformationViewDelegate <NSObject>

@optional
/**
 *  设计师信息 点击预约按钮
 *
 *  @param commonInformationView CommonInformationView
 *  @param indexPath             点击的索引
 */
- (void)commonInformationView:(CommonInformationView *)commonInformationView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

@end



@interface CommonInformationView : UIView

@property (nonatomic, strong)DesignerViewModel *dataModel;

@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, assign) id<CommonInformationViewDelegate> delegate;

@end
