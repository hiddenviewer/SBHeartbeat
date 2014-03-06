//
//  UIView+SBHeartbeat.h
//  SBHeartbeat
//
//  Created by hiddenviewer on 2014. 3. 6..
//  Copyright (c) 2014년 1minute2life. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    kIndicatorTypeHeart = 0,
    kIndicatorTypeHeartEyes,
    kIndicatorTypeStarEyes,
    kIndicatorTypeSmile,
    kIndicatorTypeCry,
    kIndicatorTypeAngry,
} IndicatorType ;

@interface UIView (SBHeartbeat)

- (void)showHeartbeatIndicator;
- (void)showHeartbeatIndicatorWithType:(IndicatorType)indicatorType;
- (void)hideHeartbeatIndicator;

@end
