//
//  RecommendVC.m
//  高仿MONO
//
//  Created by 徐茂怀 on 2018/4/10.
//  Copyright © 2018年 徐茂怀. All rights reserved.
//

#import "RecommendVC.h"
#import "SPPageMenu.h"
#import "NSArray+MHAdd.h"
#import "RecommendTypeVC.h"
#import "PlayMusicController.h"
@interface RecommendVC ()<SPPageMenuDelegate,UIScrollViewDelegate>{
    UIButton *rightBarButton;
}
@property(nonatomic,strong) SPPageMenu *pageMenu;
@property(nonatomic,strong) UIScrollView *scrollView;
@property(nonatomic,strong) NSMutableArray *myChildViewControllers;
@property(nonatomic,strong) NSArray *dataArr;
@end

@implementation RecommendVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.13 green:0.13 blue:0.14 alpha:1];
    _dataArr = @[@"早午茶",@"我的关注",@"猜你喜欢",@"视频",@"音乐",@"画册"];
     self.pageMenu.bridgeScrollView = self.scrollView;
//    [self setupView:self.pageMenu.selectedItemIndex];
   
}

#pragma mark - 懒加载
-(UIScrollView *)scrollView
{
    if(!_scrollView){
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - NaviH  - KTabBarHeight)];
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.scrollsToTop = NO;
    [self.view addSubview:_scrollView];
    [self.view sendSubviewToBack:_scrollView];
    _scrollView.contentOffset = CGPointMake(SCREEN_WIDTH * self.pageMenu.selectedItemIndex, 0);
    _scrollView.contentSize = CGSizeMake(6 * SCREEN_WIDTH, 0);
    }
    return _scrollView;
}

-(void)pageMenu:(SPPageMenu *)pageMenu functionButtonClicked:(UIButton *)functionButton
{
//    PlayMusicController *vc = [[PlayMusicController alloc]init];
    
}

-(SPPageMenu *)pageMenu
{
    if (!_pageMenu) {
        _pageMenu = [SPPageMenu pageMenuWithFrame:CGRectMake(0, 0, self.view.frame.size.width, pageMenuH) trackerStyle:SPPageMenuTrackerStyleLine];
        _pageMenu.contentInset = UIEdgeInsetsMake(0, -10, - 2, -6);
        [_pageMenu setFunctionButtonTitle:@"" image:[UIImage imageNamed:@"btn-player"] imagePosition:SPItemImagePositionRight imageRatio:0 forState:UIControlStateNormal];
        _pageMenu.showFuntionButton = YES;
        [_pageMenu setItems:_dataArr selectedItemIndex:0];
        _pageMenu.delegate = self;
        _pageMenu.backgroundColor = [UIColor clearColor];
        _pageMenu.dividingLine.hidden = YES;
         [self.navigationItem setTitleView:self.pageMenu];
    }
    return _pageMenu;
}
- (NSMutableArray *)myChildViewControllers {
    
    if (!_myChildViewControllers) {
        _myChildViewControllers = [NSMutableArray array];
        for (NSInteger index = 0; index < _dataArr.count; index++) {
            [_myChildViewControllers addObject:@1];
        }
    }
    return _myChildViewControllers;
}
#pragma mark - SPPageMenuDelegate
- (void)pageMenu:(SPPageMenu *)pageMenu itemSelectedFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    // 如果fromIndex与toIndex之差大于等于2,说明跨界面移动了,此时不动画.
    if (labs(toIndex - fromIndex) >= 2) {
        [self.scrollView setContentOffset:CGPointMake(SCREEN_WIDTH * toIndex, 0) animated:YES];
    } else {
        [self.scrollView setContentOffset:CGPointMake(SCREEN_WIDTH * toIndex, 0) animated:YES];
    }
    if (self.myChildViewControllers.count <= toIndex) return;
    //获取索引对应的视图
    [self setupView:toIndex];
}
- (void)pageMenu:(SPPageMenu *)pageMenu itemSelectedAtIndex:(NSInteger)index {
    [self setupView:index];
}

- (void)setupView:(NSInteger)index{
    id table = [self.myChildViewControllers safeObjectAtIndex:index];
    if ([table isKindOfClass:[UIView class]]) {
        return;
    }
    switch (index) {
            case 0:
        {
            RecommendTypeVC *VC = [[RecommendTypeVC alloc] init];
            VC.recommendType = RecommendTypeTea;
            VC.view.frame = CGRectMake(SCREEN_WIDTH * index, 0, SCREEN_WIDTH, self.scrollView.height);
            [self.scrollView addSubview:VC.view];
            [self addChildViewController:VC];
            //将当前视图存到数组中
            [self.myChildViewControllers replaceObjectAtIndex:index withObject:VC.view];
        }
            break;
            case 1:
        {
            RecommendTypeVC *VC = [[RecommendTypeVC alloc] init];
            VC.recommendType = RecommendTypeAttention;
            VC.view.frame = CGRectMake(SCREEN_WIDTH * index, 0, SCREEN_WIDTH, self.scrollView.height);
            [self.scrollView addSubview:VC.view];
            [self addChildViewController:VC];
            //将当前视图存到数组中
            [self.myChildViewControllers replaceObjectAtIndex:index withObject:VC.view];
        }
            break;
            case 2:
        {
            RecommendTypeVC *VC = [[RecommendTypeVC alloc] init];
            VC.recommendType = RecommendTypeLike;
            VC.view.frame = CGRectMake(SCREEN_WIDTH * index, 0, SCREEN_WIDTH, self.scrollView.height);
            [self.scrollView addSubview:VC.view];
            [self addChildViewController:VC];
            //将当前视图存到数组中
            [self.myChildViewControllers replaceObjectAtIndex:index withObject:VC.view];
        }
            break;
            case 3:
        {
            RecommendTypeVC *VC = [[RecommendTypeVC alloc] init];
            VC.recommendType = RecommendTypeVideo;
            VC.view.frame = CGRectMake(SCREEN_WIDTH * index, 0, SCREEN_WIDTH, self.scrollView.height);
            [self.scrollView addSubview:VC.view];
            [self addChildViewController:VC];
            //将当前视图存到数组中
            [self.myChildViewControllers replaceObjectAtIndex:index withObject:VC.view];
        }
            break;
            case 4:
        {
            RecommendTypeVC *VC = [[RecommendTypeVC alloc] init];
            VC.recommendType = RecommendTypeMusic;
            VC.view.frame = CGRectMake(SCREEN_WIDTH * index, 0, SCREEN_WIDTH, self.scrollView.height);
            [self.scrollView addSubview:VC.view];
            [self addChildViewController:VC];
            //将当前视图存到数组中
            [self.myChildViewControllers replaceObjectAtIndex:index withObject:VC.view];
        }
            break;
            case 5:
        {
            RecommendTypeVC *VC = [[RecommendTypeVC alloc] init];
            VC.recommendType = RecommendTypePicture;
            VC.view.frame = CGRectMake(SCREEN_WIDTH * index, 0, SCREEN_WIDTH, self.scrollView.height);
            [self.scrollView addSubview:VC.view];
            [self addChildViewController:VC];
            //将当前视图存到数组中
            [self.myChildViewControllers replaceObjectAtIndex:index withObject:VC.view];
        }
        default:
            break;
    }
}

@end
