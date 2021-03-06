//
// Created by majiancheng on 2018/1/3.
// Copyright (c) 2018 majiancheng. All rights reserved.
//

#import "MCPlayerGeneralController.h"

#import "MCPlayerGeneralView.h"
#import "MCPlayerGeneralHeader.h"
#import "MCPlayerKit.h"
#import "MCDeviceUtils.h"
#import "MCPlayerCommonButton.h"
#import "MCCustomActionView.h"
#import "MCPlayerGeneralFooter.h"


@interface MCPlayerGeneralController ()

@property(nonatomic, strong) MCPlayerKit *playerKit;
@property(nonatomic, strong) MCPlayerGeneralView *playerView;

@property(nonatomic, strong) MCPlayerCommonButton *btn;

@property(nonatomic, strong) UIButton *testBtn;
@property(nonatomic, assign) NSInteger num;
@property(nonatomic, assign) BOOL quit;

@end


@implementation MCPlayerGeneralController {

}

- (void)dealloc {
    [_playerKit destory];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.testBtn];
    [self prepare];
}

- (void)prepare {

    __weak typeof(self) weakSelf = self;
    [self.view addSubview:self.playerView];
    [self.playerView updatePlayerPicture:@"https://avatars0.githubusercontent.com/u/3861387?s=460&v=4"];
    [self.playerView updateTitle:@"Skipping code signing because the target does not have an Info.plist file. (in target 'App')"];
    [self.playerKit playUrls:@[@"http://aliuwmp3.changba.com/userdata/video/45F6BD5E445E4C029C33DC5901307461.mp4"]];
//    [self.playerKit playUrls:@[@"rtmp://live.pull.gymchina.com/jz/tm8va2x69m31fz53?auth_key=1589383277-302-0-caf21b3553a1e31c25d847e9e3ab66b8"] isLiveOptions:YES];
//    self.playerView.unableSeek = YES;
    [self.playerView updateAction:self.playerKit];
    self.playerView.retryPlayUrl = ^NSString *(void) {
        return @"https://api.huoshan.com/hotsoon/item/video/_playback/?video_id=bea0903abb954f58ac0e17c21226a3c3&line=1&app_id=1115&quality=720p";
    };


    self.playerView.canShowTerminalCallBack = ^BOOL(void) {
        return YES;
    };

    self.playerView.outEventCallBack = ^id(NSString *action, id value) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if ([action isEqualToString:kMCPlayerDestory]) {
            [strongSelf destory];
            strongSelf.quit = YES;
        }
        return nil;
    };

    [self.playerView.topView.rightView addCustom:self.btn];

    {
        MCPlayerCommonButton *btn = [MCPlayerCommonButton new];
        [btn setTitle:@"清晰度1" forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor orangeColor]];
        btn.size = CGSizeMake(60, 30);
        btn.tag = 99;
        [self.playerView.topView.rightView addCustom:btn];
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
    }

    {
        MCPlayerCommonButton *btn = [MCPlayerCommonButton new];
        [btn setTitle:@"清晰度2" forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor orangeColor]];
        btn.size = CGSizeMake(60, 30);
        btn.tag = 0;
        [self.playerView.topView.rightView addCustom:btn];
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
    }

    {
        MCPlayerCommonButton *btn = [MCPlayerCommonButton new];
        [btn setTitle:@"清晰度2" forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor orangeColor]];
        btn.size = CGSizeMake(60, 30);
        btn.tag = 0;
        [self.playerView.bottomView.rightView addCustom:btn];
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
    }

    self.view.backgroundColor = [UIColor grayColor];


    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t) (3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"#adad#seek");
        [self.playerKit seekSeconds:10];
    });
}

- (void)destory {
    if (_playerView) {
        [_playerView removeFromSuperview];
        _playerView = nil;
    }
    if (_playerKit) {
        [_playerKit destory];
        _playerKit = nil;
    }
}

- (void)test {
    [self prepare];
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (int64_t) (10 * NSEC_PER_SEC));

    __weak typeof(self) weakSelf = self;
    dispatch_after(time, dispatch_get_main_queue(), ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf destory];

        strongSelf.num++;
        [strongSelf.testBtn setTitle:[NSString stringWithFormat:@"%ld 次", self.num] forState:UIControlStateNormal];
        if (!strongSelf.quit) {
            [strongSelf test];
        }
    });
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    self.navigationController.navigationBarHidden = YES;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self willEnterForground:nil];

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    self.navigationController.navigationBarHidden = NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [self didEnterBackground:nil];
}

- (void)didEnterBackground:(NSNotification *)notification {
    [_playerKit pause];
    _playerKit.playerEnvironment = MCPlayerEnvironmentOnResignActiveStatus;
}

- (void)willEnterForground:(NSNotification *)notification {
    _playerKit.playerEnvironment = MCPlayerEnvironmentOnBecomeActiveStatus;
    if (self.navigationController.topViewController == self) {
        [_playerKit play];
    } else {
        [_playerKit pause];
    }
}

#pragma mark - Rotate
#pragma mark - Rotate

- (BOOL)isSizeClassRegular {
    //如果是横屏全屏切换给切换机会
//    if (self.playerView.playerStyle == PlayerStyleSizeClassCompact) {
//        return NO;
//    }

    CGSize naturalSize = self.playerKit.naturalSize;
    if (naturalSize.width < naturalSize.height) {
        return YES;
    }
    return NO;
}

- (BOOL)shouldAutorotate {
    if ([self.playerView isLock]) {
        return NO;
    }
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait | UIInterfaceOrientationLandscapeLeft | UIInterfaceOrientationLandscapeRight;
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id <UIViewControllerTransitionCoordinator>)coordinator{
    [self changeTransition:coordinator];
}

- (void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id <UIViewControllerTransitionCoordinator>)coordinator {
    [self changeTransition:coordinator];
}

- (void)changeTransition:(id<UIViewControllerTransitionCoordinator>)coordinator {
    NSLog(@"[Orientation]%zd", [UIDevice currentDevice].orientation);
    UIDeviceOrientation willOrientation = [UIDevice currentDevice].orientation;
     __weak typeof(self) weakSelf = self;
        [coordinator animateAlongsideTransition:^(id <UIViewControllerTransitionCoordinatorContext> context) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            if (willOrientation == UIDeviceOrientationPortrait || willOrientation == UIDeviceOrientationPortraitUpsideDown ) {
                [strongSelf.playerView updateTitle:@""];
                [strongSelf.playerView rotate2Portrait];
            } else if(willOrientation == UIDeviceOrientationLandscapeLeft || willOrientation == UIDeviceOrientationLandscapeRight) {
    //            [strongSelf.definitionView removeFromSuperview];
                [strongSelf.playerView rotate2Landscape];
            }
        }                            completion:^(id <UIViewControllerTransitionCoordinatorContext> context) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
        }];
}

- (BOOL)prefersStatusBarHidden {
    NSLog(@"[Orientation][status]%zd", [UIDevice currentDevice].orientation);
    UIDeviceOrientation willOrientation = [UIDevice currentDevice].orientation;
    return self.playerView.styleSizeType != MCPlayerStyleSizeClassRegularHalf;
}

#pragma mark - getter

- (MCPlayerKit *)playerKit {
    if (!_playerKit) {
        _playerKit = [[MCPlayerKit alloc] initWithPlayerView:self.playerView.playerView];
        _playerKit.playerCoreType = MCPlayerCoreIJKPlayer;
    }
    return _playerKit;
}

- (MCPlayerGeneralView *)playerView {
    if (!_playerView) {
        CGFloat width = MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        CGFloat height = width * 9 / 16.0f + [MCDeviceUtils xTop];
        _playerView = [[MCPlayerGeneralView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        _playerView.backgroundColor = [UIColor blackColor];
        _playerView.unableSeek = NO;
        _playerView.isLive = NO;
//        _playerView.onlyFullScreen = NO;
    }
    return _playerView;
}

- (MCPlayerCommonButton *)btn {
    if (!_btn) {
        _btn = [MCPlayerCommonButton new];
        [_btn setTitle:@"清晰度" forState:UIControlStateNormal];
        [_btn setBackgroundColor:[UIColor orangeColor]];
        _btn.size = CGSizeMake(60, 30);
        _btn.showFullScreen = YES;
        _btn.showHalfScreen = NO;
    }
    return _btn;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (UIButton *)testBtn {
    if (!_testBtn) {
        _testBtn = [[UIButton alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.view.frame) - 100) / 2.0f, CGRectGetHeight(self.view.frame) / 2.0, 100, 50)];
        [_testBtn setTitle:@"Test" forState:UIControlStateNormal];
        [_testBtn addTarget:self action:@selector(test) forControlEvents:UIControlEventTouchUpInside];
        [_testBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_testBtn setBackgroundColor:[UIColor grayColor]];
    }
    return _testBtn;
}

@end
