//
//  ViewController.m
//  YCSegmentViewDemo
//
//  Created by Yc on 2018/12/3.
//  Copyright © 2018年 Yc. All rights reserved.
//

#import "ViewController.h"
#import "YCSegmentView/YCSegmentView.h"

@interface ViewController ()<YCSegmentViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self prepareUI];
}

-(void)prepareUI{
    NSArray *titles = @[@"新闻",@"娱乐",@"体育",@"天气"];
    
    NSMutableArray *vcArr = [NSMutableArray new];
    [titles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIViewController *vc = [[UIViewController alloc]init];
        vc.view.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
        
        [vcArr addObject:vc];
    }];
    
    YCSegmentView *segmentView = [[YCSegmentView alloc]initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, self.view.bounds.size.height - 20) TitltArray:titles childControllers:vcArr];
    segmentView.delegate = self;
    [self.view addSubview:segmentView];
    
}

#pragma mark - YCSegmentViewDelegate

-(void)segmentView:(YCSegmentView *)segmentView itemSelectedAtIndex:(NSInteger)index{
    NSLog(@"%ld",(long)index);
}

@end
