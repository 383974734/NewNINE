//
//  ServiceClassificationTableViewCell.m
//  NewNINE
//
//  Created by yinduo-zdy on 16/8/10.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//

#import "ServiceClassificationTableViewCell.h"

#import "ChooseTimeModel.h"

@interface ServiceClassificationTableViewCell ()

/**   遮罩*/
@property (nonatomic, strong) UIButton  *backBtn;


@property (nonatomic, strong) UIButton  *imageViewBtn;

@property (nonatomic, strong) UILabel   *nameLable;

@property (nonatomic, strong) UILabel   *moneyLable;

@property (nonatomic, strong) UILabel   *originalPrice;


@end

@implementation ServiceClassificationTableViewCell

/**
 *  快速  初始化 一个自定义cell
 *
 *  @param tableView
 *  @param cellID
 *
 *  @return ServiceClassificationTableViewCell
 */
+ (instancetype) serviceClassificationCellWithTableView:(UITableView *)tableView forCellReuseIdentifier:(NSString *)cellID {
    ServiceClassificationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.selectionStyle     = UITableViewCellEditingStyleNone;
    return cell;
}

/**
 *  重写 cell 初始化方法 自定义cell
 *
 *  @param style
 *  @param reuseIdentifier
 *
 *  @return ServiceClassificationTableViewCell
 */
- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addUI];
    }
    return self;
}


/**
 *  添加cell上的控件
 */
- (void) addUI {
    [self.contentView addSubview:self.imageViewBtn];
    [self.contentView addSubview:self.nameLable];
    [self.contentView addSubview:self.moneyLable];
    [self.contentView addSubview:self.originalPrice];
    
    [self.contentView addSubview:self.backBtn];
}

/**
 * 系统方法 设置控件位置
 */
- (void) layoutSubviews {
    [super layoutSubviews];
    
    [self.imageViewBtn autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(8, 15, 8, 0) excludingEdge:ALEdgeRight];
    [self.imageViewBtn autoSetDimension:ALDimensionWidth toSize:29];
    
    [self.moneyLable autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(8, 0, 8, 15) excludingEdge:ALEdgeLeft];
    [self.moneyLable autoSetDimension:ALDimensionWidth toSize:70];
    
    [self.originalPrice autoSetDimension:ALDimensionWidth toSize:60];
    [self.originalPrice autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:8];
    [self.originalPrice autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:8];
    [self.originalPrice autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:90];
    
    [self.nameLable autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(8, 55, 8, 100)];
    
    [self.backBtn autoPinEdgesToSuperviewEdges];
}

- (void)didButton:(UIButton *)btn {
    btn.selected = !btn.selected;
    
    NSString *str ;//  0选中     1未选中
    
    
    NSData *dataButton = UIImagePNGRepresentation([self.imageViewBtn imageForState:UIControlStateNormal]);
    // 固定图片
    NSData *dataImage  = UIImagePNGRepresentation([UIImage imageNamed:@"未选中"]);
    if ([dataButton isEqual:dataImage])
    {
        //相同
        str = @"0";
    }
    else
    {
        //不相同
        str = @"1";
    }
    
    
    if ([self.delegate respondsToSelector:@selector(serviceClassificationTableViewCell:didSelectRowAtIndexPath:btnSelected:)]) {
        [self.delegate serviceClassificationTableViewCell:self didSelectRowAtIndexPath:self.indexPath btnSelected:str];
    }
}

-(UIButton *)imageViewBtn {
    if (!_imageViewBtn) {
        _imageViewBtn = [[UIButton alloc] initForAutoLayout];
        [_imageViewBtn setImage:[UIImage imageNamed:@"未选中"] forState:UIControlStateNormal];
    }
    return _imageViewBtn;
}

- (UILabel *)nameLable {
    if (!_nameLable) {
        _nameLable = [[UILabel alloc] initForAutoLayout];
        _nameLable.textColor = [UIColor redColor];
        _nameLable.adjustsFontSizeToFitWidth = YES;
        
    }
    return _nameLable;
}

- (UILabel *)moneyLable {
    if (!_moneyLable) {
        _moneyLable = [[UILabel alloc] initForAutoLayout];
        _moneyLable.textColor       = [UIColor redColor];
        _moneyLable.textAlignment   = NSTextAlignmentRight;
        _moneyLable.adjustsFontSizeToFitWidth = YES;
    }
    return _moneyLable;
}

- (UILabel *)originalPrice {
    if (!_originalPrice) {
        _originalPrice = [[UILabel alloc] initForAutoLayout];
        //        _originalPrice.textColor       = [UIColor grayColor];
        _originalPrice.textAlignment             = NSTextAlignmentRight;
        _originalPrice.adjustsFontSizeToFitWidth = YES;
        self.originalPrice.hidden                = YES;
    }
    return _originalPrice;
}



-(UIButton *)backBtn {
    if (!_backBtn) {
        _backBtn = [[UIButton alloc] initForAutoLayout];
        [_backBtn addTarget:self action:@selector(didButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}

- (void)setModel:(ChooseTimeModel *)model {
    _model = model;
    self.nameLable.text = _model.productName;
    self.moneyLable.text = [NSString stringWithFormat:@"￥%@", _model.price];
    
    if (_model.price.intValue != _model.originalPrice.intValue) {
        self.originalPrice.hidden = NO;
        NSString *testString1 = [NSString stringWithFormat:@"￥%@", _model.originalPrice];
        NSMutableAttributedString * testAttriString1 = [[NSMutableAttributedString alloc] initWithString:testString1];
        // 实现文本内容颜色和下划线,删除线的颜色不一样
        // NSStrokeColorAttributeName 单独设置没有效果
        // 必须与NSStrokeWidthAttributeName一起设置
        [testAttriString1 addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:NSMakeRange(0, testAttriString1.length)];
        [testAttriString1 addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(0, testAttriString1.length)];
        [testAttriString1 addAttribute:NSStrokeColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(0, testAttriString1.length)];
        self.originalPrice.attributedText = testAttriString1;
    }else {
        self.originalPrice.hidden = YES;
    }
    
}

- (void)setBtnSele:(NSString *)btnSele {
    _btnSele = btnSele;
    if (_btnSele.intValue == 1) {
        [_imageViewBtn setImage:[UIImage imageNamed:@"未选中"] forState:UIControlStateNormal];
    }else {
        [_imageViewBtn setImage:[UIImage imageNamed:@"选中"] forState:UIControlStateNormal];
    }
}



@end
