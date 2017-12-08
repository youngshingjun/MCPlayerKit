//
//  PlayerConfig.m
//  WaQuVideo
//
//  Created by imooc on 16/5/4.
//  Copyright © 2016年 mjc inc. All rights reserved.
//

#import "PlayerConfig.h"

@implementation PlayerConfig

/** 字体大小 */
CGFloat const _k_AV_font_normal           =   12.0f;
CGFloat const _k_AV_font_title            =   15.0f;


CGFloat const _k_AV_TopBar_height         =   40.0f;
CGFloat const _k_AV_ControlBar_height     =   44.0f;

CGFloat const _k_AV_WillHideTime          =   4.0f;

NSString *   const _k_AV_Loading_image                  =   @"player_loading_pic";
NSString *   const _k_AV_loading_default_image          =   @"ic_play_loading";
NSString *   const _k_AV_water_image                    =   @"play_portrait_logo";
NSString *   const _k_AV_water_land_image               =   @"play_landscape_logo";

CGFloat const _k_AV_offsetChoseDirection = 8.0;

NSString *  const _k_AV_TerminalMentionPLayerStatePlayEnd        = @"点击重新播放";
NSString *  const _k_AV_TerminalMentionPlayerState3GUnenable     = @"当前是移动网络,继续播放将产生流量,点击继续播放";
NSString *  const _k_AV_TerminalMentionPlayerStateNetError       = @"网络连接错误,点击重试";
NSString *  const _k_AV_TerminalMentionPlayerStateUrlError       = @"视频播放错误,点击重试";
NSString *  const _k_AV_TerminalMentionPlayerStateError          = @"播放失败,请稍后再试";
NSString *  const _k_AV_TermianlMentionPlayerAirplaying          = @"正在使用Airplay播放, 点击退出";;

/////////////////////////Topbar//////////////////////////////////
NSString * const _k_AV_TopBarBtnShareNormalImageName             = @"ic_share_white";
NSString * const _k_AV_TopBarBtnDownloadNormalImageName          = @"ic_save_white";
NSString * const _k_AV_TopBarBtnCollectNormalImageName           = @"ic_favorite_white";
NSString * const _k_AV_TopBarBtnLoopNormalImageName              = @"ic_loop_white";
NSString * const _k_AV_TopBarBtnPlayRateNormalImageName          = @"ic_slow_white";

NSString * const _k_AV_TopBarBtnCollectSelectedImageName         = @"ic_favorited";
NSString * const _k_AV_TopBarBtnLoopSelectedImageName            = @"ic_unloop_white";
NSString * const _k_AV_TopBarBtnPlayRateSelectedImageName        = @"ic_normal_white";

/////////////////////Toast///////////////////////////////////////
NSString * const _k_AV_NO_PreVideoMes                            = @"没有上一个视频";
NSString * const _k_AV_NO_NextVideoMes                           = @"没有下一个视频";

/////////////////////////////////////////////////////////////////
NSString * const _k_DT_Normal_name                               = @"sd";
NSString * const _k_DT_HD_name                                   = @"hd";
NSString * const _k_DT_UHD_name                                  = @"hd2";


//////////////////////AVPlayerKVO///////////////////////////////////////////
NSString * const _k_Player_ExternalPlayBackActive               = @"externalPlaybackActive";
NSString * const _k_Player_Status                               = @"status";
NSString * const _k_Player_CurrentItem                          = @"currentItem";

//////////////////////AVPlayerItem//////////////////////////////////////////////////////
NSString * const _k_PlayerItem_Status                           = @"status";
NSString * const _k_PlayerItem_PlaybackBufferEmpty              = @"playbackBufferEmpty";
NSString * const _k_PlayerItem_PlaybackLikelyToKeepUp           = @"playbackLikelyToKeepUp";
NSString * const _k_PlayerItem_LoadedTimeRanges                 = @"loadedTimeRanges";

//////////////////////player_type//////////////////////////////////////
NSString * const _k_player_WQAVPlayer               = @"WQAVPlayer";
NSString * const _k_player_IJKPlayer                = @"ijkplay";


+ (instancetype)sharedPlayerConfig {
    static dispatch_once_t predicate;
    static PlayerConfig * _playerConfig = nil;
    dispatch_once(&predicate, ^{
        _playerConfig = [[self alloc] init];
    });
    return _playerConfig;
}

@end
