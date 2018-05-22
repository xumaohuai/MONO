//
//  ACActionSheet.m
//  ACActionSheetDemo
//
//  Created by Zhangziyun on 16/5/3.
//  Copyright © 2016年 章子云. All rights reserved.
//
//  GitHub:     https://github.com/GardenerYun
//  Email:      gardeneryun@foxmail.com
//  简书博客地址: http://www.jianshu.com/users/8489e70e237d/latest_articles
//  如有问题或建议请联系我，我会马上解决问题~ (ง •̀_•́)ง
//

#import "ACActionSheet.h"

#define ACScreenWidth   [UIScreen mainScreen].bounds.size.width
#define ACScreenHeight  [UIScreen mainScreen].bounds.size.height
#define ACRGB(r,g,b)    [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define ACTitleFont     [UIFont systemFontOfSize:18.0f]

#define ACTitleHeight 60.0f
#define ACButtonHeight  49.0f

#define ACDarkShadowViewAlpha 0.35f

#define ACShowAnimateDuration 0.3f
#define ACHideAnimateDuration 0.2f

@interface ACActionSheet () {
    
    NSString *_cancelButtonTitle;
    NSString *_destructiveButtonTitle;
    NSArray *_otherButtonTitles;
    
    
    UIView *_buttonBackgroundView;
    UIView *_darkShadowView;
}


@property (nonatomic, copy) ACActionSheetBlock actionSheetBlock;

@end

@implementation ACActionSheet

- (instancetype)initWithTitle:(NSString *)title delegate:(id<ACActionSheetDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION {

    self = [super init];
    if(self) {
        _title = title;
        _delegate = delegate;
        _cancelButtonTitle = cancelButtonTitle.length>0 ? cancelButtonTitle : @"取消";
        _destructiveButtonTitle = destructiveButtonTitle;
        
        NSMutableArray *args = [NSMutableArray array];
        
        if(_destructiveButtonTitle.length) {
            [args addObject:_destructiveButtonTitle];
        }
        
        [args addObject:otherButtonTitles];
        
        if (otherButtonTitles) {
            va_list params;
            va_start(params, otherButtonTitles);
            id buttonTitle;
            while ((buttonTitle = va_arg(params, id))) {
                if (buttonTitle) {
                    [args addObject:buttonTitle];
                }
            }
            va_end(params);
        }
        
        _otherButtonTitles = [NSArray arrayWithArray:args];
     
        [self _initSubViews];
    }
    
    return self;
}


- (instancetype)initWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles actionSheetBlock:(ACActionSheetBlock) actionSheetBlock; {
    
    self = [super init];
    if(self) {
        _title = title;
        _cancelButtonTitle = cancelButtonTitle.length>0 ? cancelButtonTitle : @"取消";
        _destructiveButtonTitle = destructiveButtonTitle;
        
        NSMutableArray *titleArray = [NSMutableArray array];
        if (_destructiveButtonTitle.length) {
            [titleArray addObject:_destructiveButtonTitle];
        }
        [titleArray addObjectsFromArray:otherButtonTitles];
        _otherButtonTitles = [NSArray arrayWithArray:titleArray];
        self.actionSheetBlock = actionSheetBlock;
        
        [self _initSubViews];
    }
    
    return self;
    
}


- (void)_initSubViews {

    self.frame = CGRectMake(0, 0, ACScreenWidth, ACScreenHeight);
    self.backgroundColor = [UIColor clearColor];
    self.hidden = YES;
    
    _darkShadowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ACScreenWidth, ACScreenHeight)];
    _darkShadowView.backgroundColor = ACRGB(20, 20, 20);
    _darkShadowView.alpha = 0.0f;
    [self addSubview:_darkShadowView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_dismissView:)];
    [_darkShadowView addGestureRecognizer:tap];
    
    
    _buttonBackgroundView = [[UIView alloc] initWithFrame:CGRectZero];
    _buttonBackgroundView.backgroundColor = [UIColor colorWithRed:0.91 green:0.94 blue:0.94 alpha:1];
    [self addSubview:_buttonBackgroundView];
    
    if (self.title.length) {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, ACButtonHeight-ACTitleHeight, ACScreenWidth, ACTitleHeight)];
        titleLabel.text = _title;
        titleLabel.numberOfLines = 0;
        titleLabel.textColor = ACRGB(125, 125, 125);
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont systemFontOfSize:13.0f];
        titleLabel.backgroundColor = [UIColor whiteColor];
        [_buttonBackgroundView addSubview:titleLabel];
    }
    
    
    for (int i = 0; i < _otherButtonTitles.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = i;
        [button setTitle:_otherButtonTitles[i] forState:UIControlStateNormal];
        button.backgroundColor = [UIColor whiteColor];
        button.titleLabel.font = REGULARFONT(15);
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        if (i==0 && _destructiveButtonTitle.length) {
            [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }
//        UIImage *image = [UIImage imageNamed:@"ACActionSheet.bundle/actionSheetHighLighted.png"];
//        [button setBackgroundImage:image forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(_didClickButton:) forControlEvents:UIControlEventTouchUpInside];
        CGFloat buttonY = ACButtonHeight * (i + (_title.length>0?1:0));
        button.frame = CGRectMake(0, buttonY, ACScreenWidth, ACButtonHeight);
        [_buttonBackgroundView addSubview:button];
        
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectZero];
        line.backgroundColor = [UIColor colorWithRed:0.92 green:0.93 blue:0.94 alpha:1];
        line.frame = CGRectMake(0, buttonY, ACScreenWidth, 0.5);
        [_buttonBackgroundView addSubview:line];
    }
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.tag = _otherButtonTitles.count;
    [cancelButton setTitle:_cancelButtonTitle forState:UIControlStateNormal];
    cancelButton.backgroundColor = [UIColor whiteColor];
    cancelButton.titleLabel.font = REGULARFONT(15);
    [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    UIImage *image = [UIImage imageNamed:@"ACActionSheet.bundle/actionSheetHighLighted.png"];
    [cancelButton setBackgroundImage:image forState:UIControlStateHighlighted];
    [cancelButton addTarget:self action:@selector(_didClickButton:) forControlEvents:UIControlEventTouchUpInside];
    CGFloat buttonY = ACButtonHeight * (_otherButtonTitles.count + (_title.length>0?1:0)) + 5;
    cancelButton.frame = CGRectMake(0, buttonY, ACScreenWidth, ACButtonHeight);
    [_buttonBackgroundView addSubview:cancelButton];
    
    CGFloat height = ACButtonHeight * (_otherButtonTitles.count+1 + (_title.length>0?1:0)) + 5;
    _buttonBackgroundView.frame = CGRectMake(0, ACScreenHeight, ACScreenWidth, height);
    
}

- (void)_didClickButton:(UIButton *)button {

    if (_delegate && [_delegate respondsToSelector:@selector(actionSheet:didClickedButtonAtIndex:)]) {
        [_delegate actionSheet:self didClickedButtonAtIndex:button.tag];
    }
    
    if (self.actionSheetBlock) {
        self.actionSheetBlock(button.tag);
    }
    
    [self _hide];
}

- (void)_dismissView:(UITapGestureRecognizer *)tap {

    if (_delegate && [_delegate respondsToSelector:@selector(actionSheet:didClickedButtonAtIndex:)]) {
        [_delegate actionSheet:self didClickedButtonAtIndex:_otherButtonTitles.count];
    }
    
    if (self.actionSheetBlock) {
        self.actionSheetBlock(_otherButtonTitles.count);
    }
    
    [self _hide];
}

- (void)show {

    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    
    self.hidden = NO;
    @weakify(self)
    [UIView animateWithDuration:ACShowAnimateDuration animations:^{
        @strongify(self)
        self->_darkShadowView.alpha = ACDarkShadowViewAlpha;
        self->_buttonBackgroundView.transform = CGAffineTransformMakeTranslation(0, -self->_buttonBackgroundView.frame.size.height);
    } completion:^(BOOL finished) {
        
    }];
    
}

- (void)_hide {
    @weakify(self)
    [UIView animateWithDuration:ACHideAnimateDuration animations:^{
        @strongify(self)
        self->_darkShadowView.alpha = 0;
        self->_buttonBackgroundView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        self.hidden = YES;
        [self removeFromSuperview];
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
