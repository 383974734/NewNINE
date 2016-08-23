//
//  EvaluateCollectionViewCell.h
//  NewNINE
//
//  Created by yinduo-zdy on 16/8/22.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EvaluateCollectionViewCell : UICollectionViewCell

/** 删除哪张照片*/
@property (nonatomic, copy) void (^DeletePhotos)(NSIndexPath *indexPath);

/** 显示是否隐藏删除图片按钮*/
@property (nonatomic, getter=ishiddenDeleteButton) BOOL hiddenDeleteButton;

@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, copy)   NSString    *imageName;

@end
