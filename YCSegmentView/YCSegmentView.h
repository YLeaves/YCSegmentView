//
//  YCSegmentView.h
//  CK
//
//  Created by Yc on 2018/8/30.
//  Copyright © 2018年 Yc. All rights reserved.
//

#import <UIKit/UIKit.h>


@class YCSegmentView;

@protocol YCSegmentViewDelegate <NSObject>

- (void)segmentView:(YCSegmentView *)segmentView itemSelectedAtIndex:(NSInteger)index;

@end

@interface YCSegmentView : UIView
//标题未选中颜色 （默认grayColor）
@property (nonatomic, strong) UIColor *titleNormalColor;
//标题选中颜色   （默认blueColor）
@property (nonatomic, strong) UIColor *titleSelectColor;
//线高
@property (nonatomic, assign) CGFloat lineH;

@property (nonatomic, weak) id<YCSegmentViewDelegate> delegate;



/**
 初始化方法
 
 @param frame 坐标位置
 @param titles 标题数组
 @param controllers 子控制器
 @return 实例对象
 */
-(instancetype)initWithFrame:(CGRect)frame TitltArray:(NSArray*)titles childControllers:(NSArray*)controllers;

/**
 滚动指定页面
 
 @param index 下标
 */
-(void)scrollPageIndex:(NSInteger)index;

@end


