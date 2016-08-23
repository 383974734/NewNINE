//
//  DesignerWholeRegionTwoUIView.h
//  NewNINE
//
//  Created by yinduo-zdy on 16/8/15.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//

#import <UIKit/UIKit.h>




@interface DesignerWholeRegionTwoUIView : UIView

/** 传递所选门店ID---------*/
typedef void (^DesignerIdBlock)(NSString *strID, NSString *strName);
@property (nonatomic, strong)DesignerIdBlock designerIdBlock;
/** 传递所选门店ID---------*/




/** 设计师控制器 全部区域二级区域门店名字 数据*/
@property (nonatomic, strong) NSArray *wholeRegionAray;
/** 设计师控制器 全部区域二级区域门店ID 数据*/
@property (nonatomic, strong) NSArray *wholeRegionIDAray;
@end
