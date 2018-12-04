//
//  YCTitltBtnView.h
//  YCOrder
//
//  Created by Yc on 17/3/9.
//  Copyright © 2017年 Yc. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kItemNormalColor [UIColor grayColor]
#define kItemSelectColor [UIColor blueColor]

@protocol YCTitltBtnViewDelagate;

@interface YCTitltBtnView : UIView

/**
 点击按钮回调
 */
@property (nonatomic, copy) void (^btnBlock)(NSInteger tag);

/**
 选中的按钮下标
 */
@property (nonatomic, assign) NSInteger index;

//标题默认颜色
@property (nonatomic, strong) UIColor *titleNormalColor;
//标题选中颜色
@property (nonatomic, strong) UIColor *titleSelectColor;
//线高
@property (nonatomic, assign) CGFloat lineH;
//底线颜色（默认与title选中颜色一致）
@property (nonatomic, strong) UIColor *lineColor;



/**
 初始化方法

 @param frame 坐标位置
 @param array 按钮名称数组
 @return 实例对象
 */
-(instancetype)initWithFrame:(CGRect)frame andTitltArray:(NSArray*)array;


@property (nonatomic, weak) id <YCTitltBtnViewDelagate> delegate;
@end


@protocol YCTitltBtnViewDelagate <NSObject>

- (void)titleView:(YCTitltBtnView *)view didSelectedIndex:(NSInteger)index;

@end
