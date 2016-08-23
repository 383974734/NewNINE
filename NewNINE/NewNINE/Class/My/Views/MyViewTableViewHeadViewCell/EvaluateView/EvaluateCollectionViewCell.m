//
//  EvaluateCollectionViewCell.m
//  NewNINE
//
//  Created by yinduo-zdy on 16/8/22.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//

#import "EvaluateCollectionViewCell.h"


@interface EvaluateCollectionViewCell ()


/** 显示照片的控件*/
@property (nonatomic, strong) UIImageView *imageView;
/** 显示删除照片的控件*/
@property (nonatomic, strong) UIButton *deleteButton;

@end

@implementation EvaluateCollectionViewCell

/**
 *  重写初始化 方法 添加 控件
 *
 *  @param  frame
 *
 *  @return HomeCollectionViewCell
 */
- (instancetype)initWithFrame:(CGRect)frame {
    
    
    if (self = [super initWithFrame:frame]) {
        
        [self addUI];
        
    }
    return self;
}


/**
 *  重写 layoutSubviews 方法 设置 控件位置
 */
- (void)layoutSubviews {
    [super layoutSubviews];
    [self settingUIAutoLayout];
}

/**
 *  添加 控件
 */
- (void) addUI {
    [self.contentView addSubview:self.imageView];
    [self.imageView addSubview:self.deleteButton];
}

/**
 *  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
    
}

- (void) didView:(UIButton *)btn {
    if (self.DeletePhotos) {
        self.DeletePhotos(self.indexPath);
    }
}

/**
 *  懒加载   显示照片的控件   控件
 */
- (UIImageView *) imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 9, self.contentView.frame.size.width - 9, self.contentView.frame.size.height - 9)];
        _imageView.image = [UIImage imageNamed:@"add"];
        _imageView.userInteractionEnabled = YES;
    }
    return _imageView;
}

/**
 *  懒加载   显示删除照片的控件   控件
 */
- (UIButton *) deleteButton {
    if (!_deleteButton) {
        _deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(self.imageView.frame.size.width - 11, -11, 22, 22)];
        [_deleteButton setImage:[UIImage imageNamed:@"dele"] forState:UIControlStateNormal];
        [_deleteButton addTarget:self action:@selector(didView:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteButton;
}

/**
 *  set 方法  判断是否显示删除图片的按钮
 */
- (void) setHiddenDeleteButton:(BOOL)hiddenDeleteButton {
    _hiddenDeleteButton      = hiddenDeleteButton;
    self.deleteButton.hidden = _hiddenDeleteButton;
}

/**
 *  set 方法  判断是否显示删除图片的按钮
 */
- (void) setImageName:(NSString *)imageName {
    _imageName = imageName;
    if ([_imageName isEqualToString:@"add"]) {
        self.imageView.image  =[UIImage imageNamed:@"add"];
    }else {
        NSData *_decodedImageData = [[NSData alloc] initWithBase64EncodedString:_imageName options:NSDataBase64DecodingIgnoreUnknownCharacters];
        self.imageView.image = [UIImage imageWithData:_decodedImageData];//[UIImage imageNamed:_imageName];
    }
    
}




@end
