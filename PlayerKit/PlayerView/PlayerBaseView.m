//
//  PlayerView.m
//  WaQuVideo
//
//  Created by majiancheng on 2017/3/17.
//  Copyright © 2017年 mjc inc. All rights reserved.
//

#import "PlayerBaseView.h"
#import "UALogger.h"
#import "UIScreen+Extend.h"
#import "LogParam.h"

#import <ReactiveCocoa.h>
#import <Masonry.h>

@implementation PlayerBaseView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self prepareUI];
        self.clipsToBounds = YES;
    }

    return self;
}

- (void)updatePlayerView:(UIView *)drawPlayerView {
    if (_drawView) {
        [_drawView removeFromSuperview];
        _drawView = nil;
    }
    _drawView = drawPlayerView;
    if (_drawView) {
        [self addSubview:_drawView];
        _drawView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    }
}

- (void)updatePlayerLayer:(CALayer *)layer {
    if(_drawView == nil) {
        _drawView = [[UIView alloc] initWithFrame:self.bounds];
        [self addSubview:_drawView];
        [self sendSubviewToBack:_drawView];
    }
    if (_drawLayer) {
        [_drawLayer removeFromSuperlayer];
        _drawLayer = nil;
    }

    _drawLayer = layer;

    if (_drawLayer) {
        [_drawView.layer insertSublayer:_drawLayer atIndex:0];
        _drawLayer.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    }
}

- (void)prepareUI {
}


- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    switch (self.playerStyle) {
        case PlayerStyleSizeClassRegularHalf: {
            frame = CGRectMake(0, 0, [UIScreen width], [UIScreen screenWidth9Division16]);
        }
            break;
        case PlayerStyleSizeClassRegular: {
            frame = CGRectMake(0, 0, MIN([UIScreen width], [UIScreen height]), MAX([UIScreen width], [UIScreen height]));
        }
            break;
        case PlayerStyleSizeClassCompact : {
            frame = CGRectMake(0, 0, MAX([UIScreen width], [UIScreen height]), MIN([UIScreen width], [UIScreen height]));
        }
            break;
        case PlayerStyleSizeRegularAuto : {
            frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
        }
            break;

    }
    _drawView.frame = frame;
    _drawLayer.frame = frame;
}
@end
