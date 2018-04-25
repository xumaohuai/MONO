//
//  MNBaseController.m
//  高仿MONO
//
//  Created by 徐茂怀 on 2018/4/10.
//  Copyright © 2018年 徐茂怀. All rights reserved.
//

#import "MNBaseController.h"

@interface MNBaseController ()
{
    UIView *pageLoadingView;
    UIView *loadingView;
    UIImageView *loadingImageView;
    UILabel *loadingLabel;
    UIView *_failureHintView;
}
@end

@implementation MNBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.86 green:0.89 blue:0.91 alpha:1];
     self.navigationController.navigationBar.translucent = NO;
}

-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, SCREEN_HEIGHT - NaviH  - KTabBarHeight) style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
       _tableView.backgroundColor = [UIColor colorWithRed:0.86 green:0.89 blue:0.91 alpha:1];
#ifdef __IPHONE_11_0
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
#endif
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

//显示正在加载背景图片
#pragma mark - 正在加载动画
-(void)showPageLoadingProgress
{
    if (!pageLoadingView) {
        pageLoadingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - NaviH  - KTabBarHeight)];
        pageLoadingView.backgroundColor = [UIColor colorWithRed:0.86 green:0.89 blue:0.91 alpha:1];
    }
    [pageLoadingView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.view addSubview:pageLoadingView];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 25, 25)];
    imageView.center = CGPointMake(pageLoadingView.width/2, pageLoadingView.height/2);
    [pageLoadingView addSubview:imageView];
    imageView.image = [UIImage imageNamed:@"head-mask-bg"];
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 1;// 动画时间
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.8, 0.8, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.8, 0.8, 1.0)]];
    animation.values = values;
    animation.repeatCount = FLT_MAX;
    [imageView.layer addAnimation:animation forKey:nil];
}

#pragma mark - 加载失败
-(void)showPageLoadingFailedWithReloadTarget:(id)target action:(SEL)action
{
    if (!pageLoadingView) {
         pageLoadingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - NaviH  - KTabBarHeight)];
        pageLoadingView.backgroundColor = [UIColor colorWithRed:0.86 green:0.89 blue:0.91 alpha:1];
    }
    [pageLoadingView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.view addSubview:pageLoadingView];
    
    UIButton *reloadImageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    reloadImageBtn.frame = CGRectMake(0, 0, 40, 40);
    reloadImageBtn.center = CGPointMake(pageLoadingView.width/2, pageLoadingView.height/2);
    [pageLoadingView addSubview:reloadImageBtn];
    [reloadImageBtn setImage:[UIImage imageNamed:@"refresh_btn"] forState:UIControlStateNormal];
    
    UIButton *reloadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    reloadBtn.frame = CGRectMake(0, reloadImageBtn.bottom + 20, 200, 30);
    reloadBtn.centerX = pageLoadingView.width/2;
    [pageLoadingView addSubview:reloadBtn];
    reloadBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [reloadBtn setTitleColor:[UIColor colorWithRed:0.66 green:0.66 blue:0.66 alpha:1] forState:UIControlStateNormal];
    [reloadBtn setTitle:@"加载失败,请点击重试" forState:UIControlStateNormal];
    
    if (target){
        [reloadImageBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        [reloadBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)dismissHintPageWhenLoadFailed {
    if (_failureHintView.superview != nil) {
        [_failureHintView removeFromSuperview];
    }
}

- (void)endPageLoadingProgress{
        [pageLoadingView removeFromSuperview];
        [pageLoadingView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

@end
