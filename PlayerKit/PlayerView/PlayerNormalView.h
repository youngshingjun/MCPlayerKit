//
// Created by majiancheng on 2017/3/17.
// Copyright (c) 2017 mjc inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlayerBaseView.h"
#import "PlayerConfig.h"
#import "AirplayPlayerDelegate.h"
#import "PreVideo.h"

@class PlayerProgress;
@class PlayerTerminalView;
@class PlayerLoadingView;
@class PlayerRateBoard;
@protocol PlayerTerminalDelegate;
@class RACSignal;
@class MMDto;
@class MMAdDto;
@protocol PlayerFollowViewDelegate;
@class CBAutoScrollLabel;
@class SnapDto;
@class PlayerBulletView;
@protocol FXDanmakuDelegate;
@protocol BulletHelperDelegate;

@protocol PlayerNormalViewDelegate <NSObject>

@optional
- (void)showShareView;

- (void)showAirplay;

- (void)playerPopViewController;

- (void)laterPlay;

- (void)change2FullScreen;

- (void)change2Half;

- (void)changeDefinitionRecordHistory;

- (void)changeDefinition:(DefinitionType)definitionType;

- (void)changeDefinitionSaveChange:(DefinitionType)definitionType;

- (void)actionDownload;

- (void)collectionBlock:(void (^)(BOOL success))complateBlock;

- (void)cancelCollectionBlock:(void (^)(BOOL success))complateBlock;

- (void)actionFeedBack;

- (void)playerStatusPause;

- (BOOL)beforeJumpShowAdInfo;

- (BOOL)isNotVideoPre;

- (void)showAdJumpInfo;

- (void)jumpPreAd:(BOOL)userJump duration:(NSInteger)currentTime;

- (void)jump2AdContent;

- (void)changeLoop:(BOOL)isLoop;

- (void)log2ShowHobble;

- (void)log2HobbleChange2Normal;

- (BOOL)isLocalVideo;

- (BOOL)canShowPlayPauseView;

- (void)feedBack;

- (void)playNextVideo;

- (void)sliderPointClick:(SnapDto *)snapDto;

- (void)logShowScreenAd;

- (void)logPause;

- (void)logPlay;


@end

@protocol _QudanListViewTranslateDelegate <NSObject>

- (RACSignal *)localDataRfresh;

- (RACSignal *)qudanList:(BOOL)isRefresh;

- (void)qudanlistClick:(MMDto *)dto;

- (BOOL)canLoadMore;

- (NSUInteger)qudanPlayAtIndex;

- (void)reloadData;

@end


@interface PlayerNormalView : PlayerBaseView <AirplayPlayerDelegate> {
    UIView *_containerView;
    UIView *_touchView;
    UIButton *_backBtn;
    CBAutoScrollLabel *_titleLabel;
    UIButton *_moreBtn;
    UIButton *_airplayBtn;

    UIButton *_shareBtn;
    UIButton *_downloadBtn;
    UIButton *_collectionBtn;
    UIButton *_loopBtn;

    UIButton *_playPauseBtn;
    UIButton *_portraitPlayPauseBtn;
    UIButton *_nextBtn;
    PlayerProgress *_playerProgress;
    PlayerProgress *_bottomPlayerProgress;
    UILabel *_leftLabel;
    UILabel *_rightLabel;
    UIButton *_fullScreenBtn;

    UIButton *_definitionBtn;
    UIButton *_qudanBtn;
    UIButton *_jumpBtn;

    UIButton *_lockBtn;

    CAGradientLayer *_topGradientLayer;
    CAGradientLayer *_bottomGradientLayer;

    UIView *_topControlView;
    UIView *_bottomControlView;
    PlayerBulletView *_playerBulletView;
    PlayerTerminalView *_playerTerminalView;

    PlayerLoadingView *_loadingView;
    UIImageView *_waterImageView;
    PlayerRateBoard *_playerRateBoard;

    UITapGestureRecognizer *_tapGesture;
    UIPanGestureRecognizer *_panGesture;


    CGPoint _panOrigin;
    double _timeSliding;
    BOOL _isChangeVolume;       ///< 是改变音量

    BOOL _ischangingVolume;        ///< 正在改变音量
    BOOL _isChangingBright;        ///< 正在调节亮度
    BOOL _isWillSeeking;           ///< 正在seek
    BOOL _isControlUIShow;
    BOOL _isWait2Seek;
    PlayerType _playerType;
}

@property(nonatomic, weak) id <PlayerNormalViewDelegate> playerNormalViewDelegate;

@property(nonatomic, weak) id <PlayerTerminalDelegate> playerTermailDelegate;

@property(nonatomic, weak) id <_QudanListViewTranslateDelegate> qudanListViewTranslateDelegate;

@property(nonatomic, weak) id <PlayerFollowViewDelegate> playerFollowViewDelegate;

- (void)updatePlayStyle:(PlayerType)playerType;

- (void)updateBaiduAd:(NSArray<MMAdDto *> *)baiduAds perDuration:(NSUInteger)perDuration sumOfDuration:(NSUInteger)sumOfDuration;

- (void)updateAdJumpType:(PreVideoJumpType)jumpType;

- (void)updateTitle:(NSString *)title;

- (void)updateSave:(BOOL)state;

- (void)updatePlayerPicture:(NSString *)url;

- (void)controlWaterMark:(BOOL)animated;

- (void)updateFullScreenBtnStatus:(BOOL)fullScreen;

- (void)updateFollow:(BOOL)follow;

- (void)updateDefinitionNormal:(BOOL)hasNormal HD:(BOOL)hasHD UHD:(BOOL)hasUHD;

- (void)updateCurrentDefinition:(DefinitionType)definitionType;

- (void)updateHasQudan:(BOOL)hasQudan;

- (void)lockScreen:(BOOL)isLock;

- (BOOL)isLock;

- (void)showCanLoop:(BOOL)isLoop;

- (BOOL)isLoop;

- (void)resetLoop;

- (void)refreshDots:(NSArray<SnapDto *> *)dtos duration:(CGFloat)duration;

- (void)updateMention:(NSString *)mention xRate:(CGFloat)xRate showSecs:(CGFloat)showSecs;

- (void)fadeShowAndThenHiddenAnimation;

- (void)jumppreAd;

- (void)updateBulletHelperDelegate:(id<FXDanmakuDelegate>)delegate;

- (id<BulletHelperDelegate>)bulletHelperImpDelegate;

@end