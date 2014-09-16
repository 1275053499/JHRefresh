//
//  JHRefreshCommonAniView.m
//  JHRefresh
//
//  Created by Jiahai on 14-9-15.
//  Copyright (c) 2014年 Jiahai. All rights reserved.
//

#import "JHRefreshCommonAniView.h"
#import "UIView+JHExtension.h"
#import "JHREfreshConfig.h"

#define JHRefreshLabelTextColor     JHRGBA(150,150,150,1)

@implementation JHRefreshCommonAniView

NSString *const JHRefreshHeaderStatusTextNormal = @"下拉刷新";
NSString *const JHRefreshHeaderStatusTextPulling = @"松开既可刷新";
NSString *const JHRefreshHeaderStatusTextRefreshing = @"正在刷新。。。";
NSString *const JHRefreshHeaderStatusTextSuccess = @"刷新成功";
NSString *const JHRefreshHeaderStatusTextFailure = @"刷新失败";

NSString *const JHRefreshFooterStatusTextNormal = @"上拉加载更多";
NSString *const JHRefreshFooterStatusTextPulling = @"松开既可加载";
NSString *const JHRefreshFooterStatusTextRefreshing = @"正在加载。。。";
NSString *const JHRefreshFooterStatusTextSuccess = @"加载成功";
NSString *const JHRefreshFooterStatusTextFailure = @"加载失败";

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        _statusLabel = [[UILabel alloc] init];
        _statusLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _statusLabel.font = [UIFont boldSystemFontOfSize:13];
        _statusLabel.textColor = JHRefreshLabelTextColor;
        _statusLabel.backgroundColor = [UIColor clearColor];
        _statusLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_statusLabel];
        _statusLabel.text = JHRefreshHeaderStatusTextNormal;
        
        _lastUpdateTimeLabel = [[UILabel alloc] init];
        _lastUpdateTimeLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _lastUpdateTimeLabel.font = [UIFont boldSystemFontOfSize:13];
        _lastUpdateTimeLabel.textColor = JHRefreshLabelTextColor;
        _lastUpdateTimeLabel.backgroundColor = [UIColor clearColor];
        _lastUpdateTimeLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_lastUpdateTimeLabel];
        
        _arrowImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow"]];
        _arrowImgView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
        [self addSubview:_arrowImgView];
        
        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _activityView.bounds = _arrowImgView.bounds;
        _activityView.autoresizingMask = _arrowImgView.autoresizingMask;
        [self addSubview:_activityView];
        
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    if(self.refreshViewType == JHRefreshViewTypeFooter)
    {
        _statusLabel.text = JHRefreshFooterStatusTextNormal;
        _arrowImgView.transform = CGAffineTransformMakeRotation(M_PI);
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 状态
    _statusLabel.frame = CGRectMake(0, 0, self.jh_width, self.jh_height*0.5);
    
    // 时间
    _lastUpdateTimeLabel.frame = CGRectMake(0, _statusLabel.jh_height, _statusLabel.jh_width, _statusLabel.jh_height);

    _arrowImgView.center = CGPointMake(self.bounds.size.width*0.5 - 100, self.bounds.size.height*0.5);
    _activityView.center = _arrowImgView.center;
}

#pragma mark - JHRefreshViewDelegate
- (void)refreshViewAniToBePulling
{
    switch (self.refreshViewType) {
        case JHRefreshViewTypeHeader:
        {
            _statusLabel.text = JHRefreshHeaderStatusTextPulling;
            
            [UIView animateWithDuration:JHRefreshFastAnimationDuration animations:^{
                _arrowImgView.transform = CGAffineTransformMakeRotation(M_PI);
            }];
        }
            break;
        case JHRefreshViewTypeFooter:
        {
            _statusLabel.text = JHRefreshFooterStatusTextPulling;
            
            [UIView animateWithDuration:JHRefreshFastAnimationDuration animations:^{
                _arrowImgView.transform = CGAffineTransformIdentity;
            }];
        }
            break;
    }
}
- (void)refreshViewAniToBeNormal
{
    switch (self.refreshViewType) {
        case JHRefreshViewTypeHeader:
        {
            _statusLabel.text = JHRefreshHeaderStatusTextNormal;
            
            [UIView animateWithDuration:JHRefreshFastAnimationDuration animations:^{
                _arrowImgView.transform = CGAffineTransformIdentity;
            }];
        }
            break;
        case JHRefreshViewTypeFooter:
        {
            _statusLabel.text = JHRefreshFooterStatusTextNormal;
            
            [UIView animateWithDuration:JHRefreshFastAnimationDuration animations:^{
                _arrowImgView.transform = CGAffineTransformMakeRotation(M_PI);
            }];
        }
            break;
    }
}
- (void)refreshViewBeginRefreshing
{
    switch (self.refreshViewType) {
        case JHRefreshViewTypeHeader:
        {
            _statusLabel.text = JHRefreshHeaderStatusTextRefreshing;
        }
            break;
        case JHRefreshViewTypeFooter:
        {
            _statusLabel.text = JHRefreshFooterStatusTextRefreshing;
        }
            break;
    }
    _arrowImgView.hidden = YES;
    [_activityView startAnimating];
}

- (void)refreshViewEndRefreshing:(BOOL)success
{
    switch (self.refreshViewType) {
        case JHRefreshViewTypeHeader:
        {
            _statusLabel.text = success ? JHRefreshHeaderStatusTextSuccess : JHRefreshHeaderStatusTextFailure;
        }
            break;
        case JHRefreshViewTypeFooter:
        {
            _statusLabel.text = success ? JHRefreshFooterStatusTextSuccess : JHRefreshFooterStatusTextFailure;
        }
            break;
    }
    [_activityView stopAnimating];
    _arrowImgView.hidden = NO;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
