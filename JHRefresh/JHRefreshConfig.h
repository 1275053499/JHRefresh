//
//  JHRefreshConfig.h
//  JHRefresh
//
//  Created by Jiahai on 14-9-12.
//  Copyright (c) 2014年 Jiahai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JHRefreshMacro.h"


typedef NS_ENUM(NSInteger, JHRefreshViewType) {
    JHRefreshViewTypeHeader     = 1,
    JHRefreshViewTypeFooter
};

extern const CGFloat JHRefreshViewHeight;
extern const CGFloat JHRefreshFastAnimationDuration;
extern const CGFloat JHRefreshSlowAnimationDuration;


extern NSString *const JHRefreshContentOffset;
extern NSString *const JHRefreshContentSize;