//
//  GBTagListView.m
//  升级版流式标签支持点击
//
//  Created by 张国兵 on 15/8/16.
//  Copyright (c) 2015年 zhangguobing. All rights reserved.
//



#import "GBTagListView.h"
#define HORIZONTAL_PADDING 7.0f
#define VERTICAL_PADDING   3.0f
#define LABEL_MARGIN       10.0f
#define BOTTOM_MARGIN      10.0f
#define KBtnTag            1000
#define R_G_B_16(rgbValue)\
\
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 \
alpha:1.0]


// 写入NSUserDefault中的数据
#define SetUserDefault(value, key) [[NSUserDefaults standardUserDefaults] setObject:value forKey:key]
// 获取NSUserDefault中的数据
#define GetUserDefault(key) [[NSUserDefaults standardUserDefaults] objectForKey:key]

@interface GBTagListView ()

@property (nonatomic, strong) UIButton *tagBtn;


@property (nonatomic, strong) UIButton *button;

/** 储存定位城市*/
@property (nonatomic, copy) NSString *strCity;
/** 选择城市*/
@property (nonatomic, copy) NSString *seleCity;


@end

@implementation GBTagListView
-(id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        totalHeight=0;
        self.frame=frame;
        _tagArr=[[NSMutableArray alloc]init];
    }
    return self;
    
    
}
-(void)setTagWithTagArray:(NSArray*)arr{
    
    previousFrame = CGRectZero;
    [_tagArr addObjectsFromArray:arr];
    [arr enumerateObjectsUsingBlock:^(NSString*str, NSUInteger idx, BOOL *stop) {
        NSLog(@"%@", arr);
        NSLog(@"%@", str);
        self.strCity = arr[0];

        self.tagBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        self.tagBtn.frame=CGRectZero;
        
        
        
        if(_signalTagColor){
            //可以单一设置tag的颜色
//            tagBtn.backgroundColor=_signalTagColor;
        }else{
            //tag颜色多样
            self.tagBtn.backgroundColor=[UIColor colorWithRed:random()%255/255.0 green:random()%255/255.0 blue:random()%255/255.0 alpha:1];
        }
        if(_canTouch){
            self.tagBtn.userInteractionEnabled=YES;
            
        }else{
            
            self.tagBtn.userInteractionEnabled=NO;
        }
        [self.tagBtn setTitleColor:R_G_B_16(0x818181) forState:UIControlStateNormal];
        [self.tagBtn setTitleColor:[UIColor colorWithRed:234.0/255.0f green:41.0/255.0f blue:41.0/255.0f alpha:1.0] forState:UIControlStateSelected];
        self.tagBtn.titleLabel.font=[UIFont boldSystemFontOfSize:15];
//        [self.tagBtn addTarget:self action:@selector(tagBtnClick:) forControlEvents:UIControlEventTouchUpInside];// 点击定位城市  返回上一页的点击事件 -- 2016年05月18日09:48:17
        [self.tagBtn setTitle:str forState:UIControlStateNormal];
        
        
        
        self.tagBtn.tag=KBtnTag+idx;
        self.tagBtn.layer.cornerRadius=4;
        self.tagBtn.layer.borderColor=R_G_B_16(0x818181).CGColor;
        self.tagBtn.layer.borderWidth=0.3;
        self.tagBtn.clipsToBounds=YES;
        NSDictionary *attrs = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:15]};
        CGSize Size_str=[str sizeWithAttributes:attrs];
        Size_str.width += HORIZONTAL_PADDING*3;
        Size_str.height += VERTICAL_PADDING*3;
        NSLog(@"%@", str);
        NSLog(@"%@", self.cityName);
        if ([str isEqualToString:self.cityName]) {
            SetUserDefault(self.cityName, @"cityName");
            
            [self.tagBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            self.tagBtn.layer.borderColor=[UIColor redColor].CGColor;
        }else{
         [self.tagBtn addTarget:self action:@selector(tagBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        }
        NSLog(@"%@", GetUserDefault(@"cityName"));
        CGRect newRect = CGRectZero;
        
        if (previousFrame.origin.x + previousFrame.size.width + Size_str.width + LABEL_MARGIN > self.bounds.size.width) {
            
            newRect.origin = CGPointMake(10, previousFrame.origin.y + Size_str.height + BOTTOM_MARGIN);
            totalHeight +=Size_str.height + BOTTOM_MARGIN;
        }
        else {
            
            
            newRect.origin = CGPointMake(previousFrame.origin.x + previousFrame.size.width + LABEL_MARGIN, previousFrame.origin.y);
            
        }
        newRect.size = Size_str;
        [self.tagBtn setFrame:newRect];
        previousFrame=self.tagBtn.frame;
        [self setHight:self andHight:totalHeight+Size_str.height + BOTTOM_MARGIN];
        [self addSubview:self.tagBtn];

        
    }
     
     ];
    if(_GBbackgroundColor){
        
        self.backgroundColor=_GBbackgroundColor;
        
    }else{
        
        self.backgroundColor=[UIColor whiteColor];
        
    }
    
    
}
#pragma mark-改变控件高度
- (void)setHight:(UIView *)view andHight:(CGFloat)hight
{
    
    CGRect tempFrame = view.frame;
    tempFrame.size.height = hight;
    view.frame = tempFrame;
    
    cityH = tempFrame;
}
-(void)tagBtnClick:(UIButton*)button{
    NSLog(@"%@", [button titleForState:UIControlStateNormal]);
    NSLog(@"%@", self.notClickButtonName);
    if ([[button titleForState:UIControlStateNormal] isEqualToString:self.notClickButtonName])
    {
        return ;
    }
    
    button.selected=!button.selected;
    if(button.selected==YES){
        
        button.layer.borderColor= [UIColor colorWithRed:234.0/255.0f green:41.0/255.0f blue:41.0/255.0f alpha:1.0].CGColor;
    }else if (button.selected==NO){
        button.backgroundColor=[UIColor whiteColor];
        button.layer.borderColor=R_G_B_16(0x818181).CGColor;
    }
    
    [self didSelectItems];
    
    
}
-(void)didSelectItems{
    
    NSMutableArray*arr=[[NSMutableArray alloc]init];
    for(UIView*view in self.subviews){
        
        if([view isKindOfClass:[UIButton class]]){
            
            UIButton*tempBtn=(UIButton*)view;
            if (tempBtn.selected==YES) {
                [arr addObject:_tagArr[tempBtn.tag-KBtnTag]];
            }
            
        }
        
    }
    self.didselectItemBlock(arr);
    
}
@end
