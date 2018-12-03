//
//  YCTitltBtnView.h
//  YCOrder
//
//  Created by Yc on 17/3/9.
//  Copyright © 2017年 Yc. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kItemColor [UIColor colorWithRed:(67/255.0) green:(108 / 255.0) blue:(247 / 255.0) alpha:1]

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
