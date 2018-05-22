//
//  MNShareMoreView.m
//  高仿MONO
//
//  Created by 徐茂怀 on 2018/4/25.
//  Copyright © 2018年 徐茂怀. All rights reserved.
//

#import "MNShareMoreView.h"

@interface MNShareMoreView()
@property (nonatomic,strong)NSArray <MNShareItem *>*items;//存放没个item
@property(nonatomic,strong) UIVisualEffectView *backgroundView;
@end

@implementation MNShareMoreView

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]){
        [self configItems];
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    }
    return self;
}
- (void)configItems{
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    self.backgroundView = [[UIVisualEffectView alloc]initWithEffect:blur];
    self.backgroundView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.backgroundView.userInteractionEnabled = YES;
    [self.backgroundView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(disAppear)]];
    [self addSubview:_backgroundView];
    NSArray *images = @[@"btn-share-friends",@"btn-share-wechat",@"btn-share-qq",@"btn-share-weibo",@"btn-share-link",@"icon-share-systerm"];
    NSArray *titles = @[@"朋友圈",@"微信",@"QQ/空间",@"新浪微博",@"复制链接",@"更多"];
    
    NSMutableArray <MNShareItem *>*ary = [NSMutableArray new];
    for (int i = 0; i < images.count; i ++) {
        int a = i/3;
        MNShareItem *item = [[MNShareItem alloc]initWithFrame:CGRectMake((i%3) * SCREEN_WIDTH /3, SCREEN_HEIGHT + a*(SCREEN_WIDTH/3), SCREEN_WIDTH /3, SCREEN_WIDTH /3) image:images[i] title:titles[i] target:self action:@selector(itemAction:)];
        item.tag = 100 + i;
        [self addSubview:item];
        
        [ary addObject:item];
    }
    self.items = [NSArray arrayWithArray:ary];
}
- (void)itemAction:(UITapGestureRecognizer *)sender{
    [self disAppear];
    if ([self.delegate respondsToSelector:@selector(MNShareMoreViewSelectedItem:)]) {
        [self.delegate MNShareMoreViewSelectedItem:sender.view.tag - 100];
    }
}

- (void)appear{
    [[[UIApplication sharedApplication].delegate window]addSubview:self];
    for (int i = 0; i < self.items.count; i ++ ) {
        int a = i/3;
        NSTimeInterval delay = 0.04;
        if(i == 0 || i == 3){ delay = 0.1;}
        [UIView animateWithDuration:0.5 delay:delay usingSpringWithDamping:0.6 initialSpringVelocity:1 options:UIViewAnimationOptionLayoutSubviews animations:^{
            self.items[i].top = SCREEN_HEIGHT - (2-a)*(SCREEN_WIDTH/3) - 100;
        } completion:^(BOOL finished) {
            
        }];
    }
}
- (void)disAppear{
    [UIView animateWithDuration:0.5 animations:^{
        self.backgroundColor = [UIColor clearColor];
        self.backgroundView.alpha = 0;
    } completion:^(BOOL finished) {
         [self.backgroundView removeFromSuperview];
    }];
    
    for (int i = 0; i < self.items.count; i ++ ) {
        int a = i/3;
        NSTimeInterval  dealy = a * 0.1;
        [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            self.items[i].top -= 10;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.6 delay:dealy options:UIViewAnimationOptionCurveEaseInOut animations:^{
                 self.items[i].top = SCREEN_HEIGHT + a*((SCREEN_WIDTH-20)/3 + 40);
            } completion:^(BOOL finished) {
            }];
        }];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeFromSuperview];
    });
}
@end


@interface MNShareItem ()

@property (nonatomic,strong)UIImageView *imageView;
@property (nonatomic,strong)UILabel *titleLabel;

@end

@implementation MNShareItem

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    }
    return _imageView;
}
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, _imageView.bottom, self.width, 40)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:13 weight:UIFontWeightLight];
        _titleLabel.textColor = [UIColor whiteColor];
    }
    return _titleLabel;
}
- (instancetype)initWithFrame:(CGRect)frame image:(NSString *)image title:(NSString *)title target:(id)target action:(SEL)action{
    if (self = [super initWithFrame:frame]) {
        
        self.userInteractionEnabled = YES;
        
        [self addSubview:self.imageView];
        self.imageView.sd_layout.centerXEqualToView(self);
        self.imageView.image = [UIImage imageNamed:image];
        
        [self addSubview:self.titleLabel];
        self.titleLabel.text = title;
        
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:target action:action]];
    }
    return self;
}

@end
