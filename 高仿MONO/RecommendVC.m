//
//  RecommendVC.m
//  高仿MONO
//
//  Created by 徐茂怀 on 2018/4/10.
//  Copyright © 2018年 徐茂怀. All rights reserved.
//

#import "RecommendVC.h"
#import "SPPageMenu.h"
@interface RecommendVC ()<SPPageMenuDelegate>{
    UIButton *rightBarButton;
}
@property(nonatomic,strong) SPPageMenu *pageMenu;
@end

@implementation RecommendVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _pageMenu = [SPPageMenu pageMenuWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40) trackerStyle:SPPageMenuTrackerStyleLine];
    _pageMenu.contentInset = UIEdgeInsetsMake(0, -10, - 2, -6);
    [_pageMenu setFunctionButtonTitle:@"" image:[UIImage imageNamed:@"btn-player"] imagePosition:SPItemImagePositionRight imageRatio:0 forState:UIControlStateNormal];
    _pageMenu.showFuntionButton = YES;
    [_pageMenu setItems:@[@"早午茶",@"我的关注",@"猜你喜欢",@"视频",@"音乐",@"画册"] selectedItemIndex:0];
    _pageMenu.delegate = self;
    _pageMenu.backgroundColor = [UIColor clearColor];
    _pageMenu.dividingLine.hidden = YES;

    [self.navigationItem setTitleView:_pageMenu];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
