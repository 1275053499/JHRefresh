//
//  UIScrollView+JHRefresh.h
//  JHRefresh
//
//  Created by Jiahai on 14-9-15.
//  Copyright (c) 2014年 Jiahai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JHRefreshConfig.h"

@interface UIScrollView (JHRefresh)

- (void)addRefreshHeaderView:(void(^)())beginRefresh;

- (void)addRefreshFooterView:(void(^)())beginRefresh;

- (void)headerEndRefreshingWithResult:(JHRefreshResult)result;
- (void)footerEndRefreshing;
@end
