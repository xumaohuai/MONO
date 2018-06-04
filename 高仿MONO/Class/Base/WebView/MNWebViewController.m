//
//  MNWebViewController.m
//  高仿MONO
//
//  Created by 徐茂怀 on 2018/5/23.
//  Copyright © 2018年 徐茂怀. All rights reserved.
//

#import "MNWebViewController.h"
#import <WebKit/WebKit.h>
#import <YYModel.h>
#import "RecommendModel.h"
#import "MNNetworkTool.h"
#import "WebNavTitleView.h"
#import "WebThirdTitleView.h"
#import "CommunicateBottomView.h"
@interface MNWebViewController ()<WKNavigationDelegate,UIScrollViewDelegate>
{
    CGFloat lastContentOffset;
    BOOL hiddenStatusBar;
}
@property (nonatomic,strong) RecommendModel *recommendModel;
@property (nonatomic,copy) NSString *htmlStr;
@property(nonatomic,strong)WKWebView *webView;
@property(nonatomic,strong) WKWebView *readWebView;
@property(nonatomic,strong) WKUserContentController *userContentController;
@property(nonatomic,strong) UIProgressView *progressView;//进度条
@property(nonatomic,strong) WebNavTitleView *titleView;
@property(nonatomic,strong) WebThirdTitleView *thirdTitleView;
@property (nonatomic,strong) CommunicateBottomView *bottomView;

@end

@implementation MNWebViewController
+ (instancetype)jkRouterViewControllerWithJSON:(NSDictionary *)dic{
    MNWebViewController *vc = [self yy_modelWithJSON:dic];
    return vc;
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    if (_recommendModel.meow_type == MeowTypePictures || _recommendModel.meow_type == MeowTypeMusic) {
        return UIStatusBarStyleLightContent;
    }
    return UIStatusBarStyleDefault;
}
-(BOOL)prefersStatusBarHidden
{
    return hiddenStatusBar;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    self.navigationController.navigationBar.translucent = YES;
    [self.readWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew| NSKeyValueObservingOptionOld context:nil];
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc]init];
    barBtn.title=@"";
    self.navigationItem.leftBarButtonItem = barBtn;
    [self loadWeb];
   
}
//UI界面
-(void)setupView
{
    [self.view addSubview:self.webView];
    [self.view addSubview:self.readWebView];
    [self.view addSubview:self.progressView];
    [self.view addSubview:self.bottomView];
    _bottomView.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).bottomEqualToView(self.view).heightIs(51);
    if (_recommendModel.meow_type == MeowTypeReadThird) {
        self.navigationItem.titleView = self.thirdTitleView;
    }else{
        self.navigationItem.titleView = self.titleView;
        [self.webView setOpaque:NO];
        if (_recommendModel.meow_type == MeowTypePictures || _recommendModel.meow_type == MeowTypeMusic) {
            self.view.backgroundColor = [UIColor blackColor];
            self.webView.backgroundColor = [UIColor blackColor];
            self.readWebView.backgroundColor = [UIColor blackColor];
        }else{
            self.view.backgroundColor = [UIColor whiteColor];
            self.webView.backgroundColor = [UIColor whiteColor];
            self.readWebView.backgroundColor = [UIColor whiteColor];
        }
    }
}
#pragma - mark 懒加载
-(WKWebView *)webView
{
    if (!_webView) {
        _webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, NaviH, SCREEN_WIDTH, SCREEN_HEIGHT - NaviH - 51)];
        _webView.scrollView.clipsToBounds = NO;
        _webView.navigationDelegate = self;
        _webView.scrollView.delegate = self;
    }
    return _webView;
}
-(WKWebView *)readWebView
{
    if (!_readWebView) {
        _readWebView = [[WKWebView alloc]initWithFrame:CGRectMake(0, NaviH, SCREEN_WIDTH, SCREEN_HEIGHT - NaviH - 51)];
        _readWebView.scrollView.clipsToBounds = NO;
        _readWebView.navigationDelegate = self;
        _readWebView.scrollView.delegate = self;
    }
    return _readWebView;
}
-(WebNavTitleView *)titleView
{
    if (!_titleView) {
        WebNavTitleStyle style = WebNavTitleStyleWhite;
        if (_recommendModel.meow_type == MeowTypePictures || _recommendModel.meow_type == MeowTypeMusic) {
            style = WebNavTitleStyleBlack;
        }
        _titleView = [[WebNavTitleView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NaviH) WebNavStyle:style];
        _titleView.model = _recommendModel;
    }
    return _titleView;
}
-(WebThirdTitleView *)thirdTitleView
{
    if (!_thirdTitleView) {
        _thirdTitleView = [[WebThirdTitleView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NaviH)];
        _thirdTitleView.model = _recommendModel;
        @weakify(self)
        [[_thirdTitleView.readSwith rac_valuesForKeyPath:@"on" observer:nil]subscribeNext:^(id x) {
            @strongify(self)
            if ([x boolValue]) {
                NSLog(@"阅读模式");
                self.readWebView.hidden = NO;
                self.webView.hidden = YES;
            }else{
                NSLog(@"非阅读模式");
                self.readWebView.hidden = YES;
                self.webView.hidden = NO;
            }
        }];
    }
    return _thirdTitleView;
}
- (UIProgressView *)progressView
{
    if (!_progressView)
    {
        UIProgressView *progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, NaviH, self.view.frame.size.width, 0)];
        progressView.tintColor = [UIColor colorWithRed:0.16 green:0.7 blue:0.77 alpha:1];
        progressView.trackTintColor = [UIColor clearColor];
        [self.view addSubview:progressView];
        self.progressView = progressView;
    }
    return _progressView;
}

-(CommunicateBottomView *)bottomView
{
    if (!_bottomView) {
        if (_recommendModel.meow_type == MeowTypePictures || _recommendModel.meow_type == MeowTypeMusic) {
            _bottomView = [[CommunicateBottomView alloc]initWithFrame:CGRectZero CommunicateType:CommunicateBottomTypeDetailWhite];
        }else{
            _bottomView = [[CommunicateBottomView alloc]initWithFrame:CGRectZero CommunicateType:CommunicateBottomTypeDetailGray];
        }
        _bottomView.bottomModel = _recommendModel;
    }
    return _bottomView;
}

//监听加载进度
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqual: @"estimatedProgress"] && object == _readWebView) {
        [self.progressView setProgress:_readWebView.estimatedProgress animated:YES];
        if(_readWebView.estimatedProgress >= 1.0f)
        {
            [UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
                [self.progressView setAlpha:0.0f];
            } completion:^(BOOL finished) {
                [self.progressView removeFromSuperview];
            }];
        }
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y <= 0 || _recommendModel.meow_type == MeowTypeReadThird) {
        hiddenStatusBar = NO;
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }else{
   CGFloat newY= scrollView.contentOffset.y ;
    if (newY != lastContentOffset ) {
        if (newY > lastContentOffset) {
             hiddenStatusBar = YES;
             [self.navigationController setNavigationBarHidden:YES animated:YES];
            [UIView animateWithDuration:0.3 animations:^{
                self.bottomView.alpha = 0;
            }];
             [self.progressView setAlpha:0.0f];
        }else{
            hiddenStatusBar = NO;
             [self.navigationController setNavigationBarHidden:NO animated:YES];
            [UIView animateWithDuration:0.3 animations:^{
                self.bottomView.alpha = 1;
            }];
             [self.progressView setAlpha:1.0f];
        }
        lastContentOffset = newY;
    }
    }
    [self setNeedsStatusBarAppearanceUpdate];
}



-(void)loadWeb
{
    if (_recommendModel.rec_url) {
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.recommendModel.rec_url]];
        [self.webView loadRequest:request];
    }
    if (_htmlStr.length) {
            [self.readWebView loadHTMLString:_htmlStr baseURL:nil];
    }else{
    [[MNNetworkTool shareService]requstWithUrl:[NSString stringWithFormat:@"http://mmmono.com/g/meow/%@/",_recommendModel.Id] Param:nil Success:^(id responseObj) {
        NSMutableString *str = [[NSMutableString alloc]initWithString:responseObj];
        [self.readWebView loadHTMLString:[self getZZwithString:str] baseURL:nil];
    } Failed:^{
    }];
    }
}


-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    NSURL *URL = navigationAction.request.URL;
    if ([URL.absoluteString hasPrefix:@"http://mmmono.com/g/meow/"]) {
        decisionHandler(WKNavigationActionPolicyCancel);
        [MBProgressHUD showProgress];
        NSArray *subArr = [URL.absoluteString componentsSeparatedByString:@"/"];
        [[MNNetworkTool shareService]requstWithUrl:[NSString stringWithFormat:@"g/meow/%@/",[subArr objectAtIndex:subArr.count - 2]] Param:nil Success:^(id responseObj) {
            RecommendModel *model = [RecommendModel yy_modelWithJSON:responseObj];
            [[MNNetworkTool shareService]requstWithUrl:[NSString stringWithFormat:@"http://mmmono.com/g/meow/%@/",model.Id] Param:nil Success:^(id responseObj) {
                NSMutableString *str = [[NSMutableString alloc]initWithString:responseObj];
                NSDictionary *params = @{@"recommendModel":model,@"htmlStr":[self getZZwithString:str]};
                RouterOptions *options = [RouterOptions optionsWithDefaultParams:params];
                [JKRouter open:@"MNWebViewController" options:options];
                [MBProgressHUD hideProgress];
            } Failed:^{
                [MBProgressHUD hideProgress];
            }];
            
        } Failed:^{
            
        }];
    }else{
    decisionHandler(WKNavigationActionPolicyAllow);
    }
}

//去掉网页头尾部
-(NSString *)getZZwithString:(NSMutableString *)string{
    NSRange range = [string rangeOfString:@"</head>"];
    [string insertString:@"<style>.web-download-bar{display:none;}\n.author-info{display:none;}#gallery-seg{display:none}</style>" atIndex:range.location];
    return string;
}
//注销监听
- (void)dealloc {
    [_readWebView removeObserver:self forKeyPath:@"estimatedProgress"];
    [_webView setNavigationDelegate:nil];
    [_webView setUIDelegate:nil];
    [_readWebView setNavigationDelegate:nil];
    [_readWebView setUIDelegate:nil];
}

@end
