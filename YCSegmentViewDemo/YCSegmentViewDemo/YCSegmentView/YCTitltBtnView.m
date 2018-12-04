//
//  YCTitltBtnView.m
//  YCOrder
//
//  Created by Yc on 17/3/9.
//  Copyright © 2017年 Yc. All rights reserved.
//

#import "YCTitltBtnView.h"


#define magrin 10
#define ScreenH             [[UIScreen mainScreen] bounds].size.height
#define ScreenW             [[UIScreen mainScreen] bounds].size.width


@interface YCTitltBtnView (){
    NSArray *titleArray;
}
@property (nonatomic, strong) NSMutableArray  <UIButton*>*btnArray;
@property (nonatomic, strong) UIButton        *titleButton;
@property (nonatomic, strong) UIView          *line;

@end


@implementation YCTitltBtnView

-(instancetype)initWithFrame:(CGRect)frame andTitltArray:(NSArray*)array;{
    if (self = [super initWithFrame:frame]) {
        titleArray = array;
        [self prepareUI];
    }
    return self;
}

-(void)prepareUI{
    NSInteger count = titleArray.count;
    CGFloat btnW = (ScreenW - (magrin *(count+1)))/ count ;
    CGFloat btnH = self.frame.size.height - 2;
    for (int i = 0; i < count; i++) {
        UIButton *btn = [[UIButton alloc]init];
        btn.tag = i;
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [btn setTitle:titleArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:kItemNormalColor forState:UIControlStateNormal];
        [btn setTitleColor:kItemSelectColor forState:UIControlStateSelected];
        btn.frame = CGRectMake((btnW+magrin) * i+magrin, 0, btnW, btnH);
        [self addSubview:btn];
        [btn addTarget:self action:@selector(clickTitleButton:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.btnArray addObject:btn];
    }
    
    self.line.frame = CGRectMake(0,btnH, btnW, 2);
    
}


-(void)clickTitleButton:(UIButton*)button{
    
    self.titleButton.selected = NO;   //清空按钮选中状态
    self.titleButton = button;        //记录按钮状态
    self.titleButton.selected = YES;
    button.selected = YES;
    [UIView animateWithDuration:0.2 animations:^{
//        self.line.x = button.x;
        self.line.frame = CGRectMake(button.frame.origin.x, self.line.frame.origin.y, self.line.frame.size.width, self.line.frame.size.height);
    } completion:nil];
    
    
    if ([self.delegate respondsToSelector:@selector(titleView:didSelectedIndex:)]) {
        [self.delegate titleView:self didSelectedIndex:button.tag];
    }
    
    if (self.btnBlock) {
        self.btnBlock(button.tag);
    }
    
}


-(void)setIndex:(NSInteger)index{
    
    _index = index;
    
    if (index >titleArray.count || index<0) {return;}
    
    [self clickTitleButton:self.btnArray[index]];
}


#pragma mark - Setter

-(void)setTitleNormalColor:(UIColor *)titleNormalColor{
    [self.btnArray enumerateObjectsUsingBlock:^(UIButton * _Nonnull btn, NSUInteger idx, BOOL * _Nonnull stop) {
       [btn setTitleColor:titleNormalColor forState:UIControlStateNormal];
    }];
}

-(void)setTitleSelectColor:(UIColor *)titleSelectColor{
    [self.btnArray enumerateObjectsUsingBlock:^(UIButton * _Nonnull btn, NSUInteger idx, BOOL * _Nonnull stop) {
        [btn setTitleColor:titleSelectColor forState:UIControlStateSelected];
    }];
    self.line.backgroundColor = titleSelectColor;
}

-(void)setLineH:(CGFloat)lineH{
    if (lineH<0) {return;}
    CGFloat h = lineH;
    if (lineH>self.frame.size.height/3) {
        h = self.frame.size.height/3;
    }
    
    self.line.frame = CGRectMake(self.line.frame.origin.x, self.frame.size.height - h, self.line.frame.size.width, h);
}


#pragma mark - Lazy
-(UIView *)line{
    if (!_line) {
        _line = [[UIView alloc]init];
        _line.backgroundColor = kItemSelectColor;
        [self addSubview:_line];
    }
    return _line;
}


-(NSMutableArray *)btnArray{
    if (!_btnArray) {
        _btnArray = [[NSMutableArray alloc] init];
    }
    return _btnArray;
}



@end
