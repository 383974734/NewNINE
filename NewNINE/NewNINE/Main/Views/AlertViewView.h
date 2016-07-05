//
//  AlertViewView.h
//  NewNINE
//
//  Created by yinduo-zdy on 16/6/20.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//



#import <UIKit/UIKit.h>

@class AlertViewView;

@protocol AlertViewViewDelegate <NSObject>

@optional
- (void)alertViewView:(AlertViewView *)alertViewView buttonWithTag:(NSInteger)buttonWithTag textViewStr:(NSString *)textViewStr indexPath:(NSIndexPath *)indexPath;
@end


@interface AlertViewView : UIView

@property (nonatomic, strong) NSIndexPath *index;
@property (nonatomic, assign) id<AlertViewViewDelegate> delegate;

+ (instancetype) popupView;
- (void) setAlertView:(NSString *)title textfileWithHidden:(BOOL)hidden nameLable:(NSString *)nameLable leftButton:(NSString *)leftButton rightButton:(NSString *)rightButton;

@end
