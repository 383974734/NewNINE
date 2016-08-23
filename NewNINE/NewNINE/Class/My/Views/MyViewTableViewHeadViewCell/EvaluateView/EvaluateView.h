//
//  EvaluateView.h
//  NewNINE
//
//  Created by yinduo-zdy on 16/8/22.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//

#import <UIKit/UIKit.h>




@interface EvaluateView : UIView

@property (nonatomic, copy) void(^EvaluateViewContent)(NSString *contentStr, NSInteger tag);

/** 设计师头像*/
@property (nonatomic, copy) NSString *iconPhotoUrl;
/** 设计师名字*/
@property (nonatomic, copy) NSString *nameStr;
@end
