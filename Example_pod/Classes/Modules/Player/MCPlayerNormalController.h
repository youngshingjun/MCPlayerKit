//
// Created by majiancheng on 2018/1/3.
// Copyright (c) 2018 majiancheng. All rights reserved.
//

#import "MCController.h"

@class MCPlayerNormalView;
@class MCPlayerKit;


@interface MCPlayerNormalController : MCController

@property(nonatomic, readonly) MCPlayerKit *playerKit;
@property(nonatomic, readonly) MCPlayerNormalView *playerView;

@end