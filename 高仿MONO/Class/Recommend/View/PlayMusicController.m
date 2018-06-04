//
//  PlayMusicController.m
//  高仿MONO
//
//  Created by 徐茂怀 on 2018/6/1.
//  Copyright © 2018年 徐茂怀. All rights reserved.
//

#import "PlayMusicController.h"

@interface PlayMusicController ()

@end

@implementation PlayMusicController

- (void)viewDidLoad {
    [super viewDidLoad];
//    _playImageView = [[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
//    _playImageView.image = [UIImage imageNamed:@"snake_start"];
//    [self.view addSubview:_playImageView];
    [self.view addSubview:self.playImageView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self.view addGestureRecognizer:tap];
}
-(void)tapAction {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(UIImageView *)playImageView{
    if (!_playImageView) {
        _playImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
        _playImageView.center = self.view.center;
        _playImageView.image = [UIImage imageNamed:@"snake_start"];
    }
    return _playImageView;
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
