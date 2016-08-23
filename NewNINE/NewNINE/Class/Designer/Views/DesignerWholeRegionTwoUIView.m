//
//  DesignerWholeRegionTwoUIView.m
//  NewNINE
//
//  Created by yinduo-zdy on 16/8/15.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//

#import "DesignerWholeRegionTwoUIView.h"

@interface DesignerWholeRegionTwoUIView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *designerTableview;


@end


@implementation DesignerWholeRegionTwoUIView

- (instancetype) initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self addUI];
        [self settingAutoLayout];
        [self settingData];
    }
    return self;
}

- (void)addUI {
    [self addSubview:self.designerTableview];
    
}

- (void)settingAutoLayout {
    [self.designerTableview autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
}

- (void)settingData {

}


#pragma mark UITableView DataSource
/**
 *  tableView 数据源方法 返回tabvelView 分组个数
 *
 *  @param tableView
 *
 *  @return NSInteger
 */
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

/**
 *  tableView 数据源方法  返回tableView 每个分组中cell的个数
 *
 *  @param tableView
 *  @param section
 *
 *  @return NSInteger
 */
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.wholeRegionAray.count;
}

/**
 *  tableView 数据源方法 返回每个cell显示的样式和数据
 *
 *  @param  tableView
 *  @param  indexPath
 *
 *  @return OrderTableViewCell
 */
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *CellIdentifier =[NSString stringWithFormat:@"Cell%ld#%ld", (long)indexPath.section, (long)indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"DesignerWholeRegionTwoTableViewCell"];
    }
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 180, 34)];
    lable.textColor = Color(154, 154, 154, 1);
    lable.font = SWP_SYSTEM_FONT_SIZE(15);
    lable.text = self.wholeRegionAray[indexPath.row];
    [cell addSubview:lable];
    cell.backgroundColor = Color(238, 238, 238, 1);
    cell.selectionStyle  = UITableViewCellSelectionStyleNone;
    return cell;

}

/**
 *  tableView 代理方法 点击每个cell (进入详情)
 *
 *  @param tableView
 *  @param indexPath
 */
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.designerIdBlock) {
        self.designerIdBlock(self.wholeRegionIDAray[indexPath.row], self.wholeRegionAray[indexPath.row]);
    }
}




/**
 *  tableView 代理方法 返回对应索引返回的row的高度
 *
 *  @param tableView
 *  @param indexPath
 *
 *  @return CGFloat
 */
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40 ;
}

- (UITableView *)designerTableview {
    if (!_designerTableview) {
        _designerTableview                  = [[UITableView alloc] initForAutoLayout];
        _designerTableview.delegate         = self;
        _designerTableview.dataSource       = self;
        _designerTableview.backgroundColor  = Color(238, 238, 238, 1);
        [_designerTableview setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];//隐藏多余的cell
    }
    return _designerTableview;
}


- (void) setWholeRegionAray:(NSArray *)wholeRegionAray {
    _wholeRegionAray = wholeRegionAray;
    [self.designerTableview reloadData];
}


- (void) setWholeRegionIDAray:(NSArray *)wholeRegionIDAray {
    _wholeRegionIDAray = wholeRegionIDAray;
}

@end
