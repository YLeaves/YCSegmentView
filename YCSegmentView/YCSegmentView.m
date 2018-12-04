//
//  YCSegmentView.m
//  CK
//
//  Created by Yc on 2018/8/30.
//  Copyright © 2018年 Yc. All rights reserved.
//

#import "YCSegmentView.h"
#import "YCTitltBtnView.h"

@interface YCSegmentView()<UIPageViewControllerDataSource, UIPageViewControllerDelegate,YCTitltBtnViewDelagate>{
    __block NSInteger flag;
}
@property (nonatomic, strong) UIPageViewController *pageViewController;
@property (nonatomic, strong) YCTitltBtnView *segmentView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation YCSegmentView


-(instancetype)initWithFrame:(CGRect)frame TitltArray:(NSArray*)titles childControllers:(NSArray*)controllers{
    if (self = [super initWithFrame:frame]) {
        self.frame = frame;
        [self prepareTitltArray:titles childControllers:controllers];
    }
    return self;
}


-(void)prepareTitltArray:(NSArray*)titles childControllers:(NSArray*)controllers{
    
    self.segmentView = [[YCTitltBtnView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 40) andTitltArray:titles];
    [self addSubview:self.segmentView];
    self.segmentView.index = 0;
    self.segmentView.delegate = self;
    
    
    [self.dataSource removeAllObjects];
    [self.dataSource addObjectsFromArray:controllers];
    
    self.pageViewController.view.frame = CGRectMake(0, CGRectGetMaxY(self.segmentView.frame), self.frame.size.width, self.frame.size.height - self.segmentView.frame.size.height);
    [self addSubview:self.pageViewController.view];
    
    flag = 0;
    //设置显示控制器
    UIViewController *vc = [self.dataSource objectAtIndex:flag];
    [self.pageViewController setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
}



#pragma mark - YCTitltBtnViewDelagate
-(void)titleView:(YCTitltBtnView *)view didSelectedIndex:(NSInteger)index{
    UIViewController *vc = [self.dataSource objectAtIndex:index];
    if (index > flag) {
        [self.pageViewController setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:^(BOOL finished) {
            
        }];
    } else {
        
        [self.pageViewController setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:^(BOOL finished) {
            
        }];
    }
    
    flag = index;
    if ([self.delegate respondsToSelector:@selector(segmentView:itemSelectedAtIndex:)]) {
        [self.delegate segmentView:self itemSelectedAtIndex:index];
    }
}


#pragma mark - UIPageViewControllerDataSource
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSInteger index = [self.dataSource indexOfObject:viewController];
    
    if (index == 0 || (index == NSNotFound)) {return nil;}
    
    index--;
    
    return [self.dataSource objectAtIndex:index];
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSInteger index = [self.dataSource indexOfObject:viewController];
    
    if (index == self.dataSource.count - 1 || (index == NSNotFound)) {return nil;}
    
    index++;
    
    return [self.dataSource objectAtIndex:index];
}

- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers {
    
    UIViewController *nextVC = [pendingViewControllers firstObject];
    
    NSInteger index = [self.dataSource indexOfObject:nextVC];
    
    flag = index;
    
}

// Sent when a gesture-initiated transition ends. The 'finished' parameter indicates whether the animation finished, while the 'completed' parameter indicates whether the transition completed or bailed out (if the user let go early).
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    if (completed) {
        self.segmentView.index = flag ;
    }
}

#pragma mark - Public
-(void)scrollPageIndex:(NSInteger)index{
    self.segmentView.index = index;
}

#pragma mark - Setter

-(void)setTitleNormalColor:(UIColor *)titleNormalColor{
    self.segmentView.titleNormalColor = titleNormalColor;
}

-(void)setTitleSelectColor:(UIColor *)titleSelectColor{
    self.segmentView.titleSelectColor = titleSelectColor;
}

-(void)setLineH:(CGFloat)lineH{
    self.segmentView.lineH = lineH;
}


#pragma mark - Lazy

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataSource;
}

- (UIPageViewController *)pageViewController {
    if (!_pageViewController) {
        NSDictionary *option = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:0] forKey:UIPageViewControllerOptionInterPageSpacingKey];
        _pageViewController = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:option];
        _pageViewController.delegate = self;
        _pageViewController.dataSource = self;
    }
    
    return _pageViewController;
}

@end
