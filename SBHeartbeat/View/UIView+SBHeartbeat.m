//
//  UIView+SBHeartbeat.m
//  SBHeartbeat
//
//  Created by hiddenviewer on 2014. 3. 6..
//  Copyright (c) 2014년 1minute2life. All rights reserved.
//

#import "UIView+SBHeartbeat.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIView (SBHeartbeat)


#define kTagForHeartbeatIndicator 2014030613
#define kInset 10

- (void)showHeartbeatIndicatorWithType:(IndicatorType)indicatorType {
    UIView *heartIndicator = [self viewWithTag:kTagForHeartbeatIndicator];
    
    if (heartIndicator) {
        [self hideHeartbeatIndicatorWithAnimate:NO];
    }
    
    NSMutableArray *icons = [[NSMutableArray alloc] initWithObjects:
                             @"heart",
                             @"heart_eyes",
                             @"smile",
                             @"cynical",
                             @"angry",
                             @"sad",
                             @"wink",
                             nil];
    
    if (indicatorType >= icons.count) {
        indicatorType = kIndicatorTypeHeart;
    }
    UIImageView *heartImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[icons objectAtIndex:indicatorType]]];
    
    heartIndicator = [[UIView alloc] initWithFrame:CGRectInset(heartImageView.bounds, -kInset, -kInset)];
    heartIndicator.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    heartIndicator.layer.cornerRadius = heartImageView.frame.size.width/2;
    
    CALayer  *heartLayer = [CALayer layer];
    heartLayer.contents = (id)heartImageView.image.CGImage;
    heartLayer.frame = heartImageView.frame;
    heartLayer.position = CGPointMake(heartIndicator.layer.position.x + kInset, heartIndicator.layer.position.y + kInset);
    [heartIndicator.layer addSublayer:heartLayer];
    [heartLayer addAnimation:[self heartBeatAnimationWithDuration:0.4] forKey:nil];
    
    heartIndicator.tag = kTagForHeartbeatIndicator;
    heartIndicator.center = self.center;
    [self addSubview:heartIndicator];
}

- (void)hideHeartbeatIndicator {
    [self hideHeartbeatIndicatorWithAnimate:YES];
}

- (void)hideHeartbeatIndicatorWithAnimate:(BOOL)animate {
    UIView *heartIndicator = [self viewWithTag:kTagForHeartbeatIndicator];
    if (heartIndicator) {
        if (animate) {
            [UIView animateWithDuration:0.3
                                  delay:0.2
                                options:UIViewAnimationOptionAllowAnimatedContent
                             animations:^(void) {
                                 heartIndicator.alpha = 0.0;
                             } completion:^(BOOL finished) {
                                 [heartIndicator removeFromSuperview];
                             }];
        } else {
            [heartIndicator removeFromSuperview];
        }
    }
}

- (void)showHeartbeatIndicator {
    [self showHeartbeatIndicatorWithType:kIndicatorTypeHeart];
}




- (CAAnimationGroup*)heartBeatAnimationWithDuration:(float)duration {
    CABasicAnimation *breatheIn = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    breatheIn.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.8, 0.8, 1.0)];
    breatheIn.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1, 1.1, 1.0)];
    breatheIn.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    breatheIn.beginTime = 0;
    breatheIn.duration = duration; // 1.0
    breatheIn.repeatCount = 1;
    breatheIn.removedOnCompletion = NO;
    breatheIn.fillMode = kCAFillModeForwards;
    
    CABasicAnimation *breatheOut = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    breatheOut.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1, 1.1, 1.0)];
    breatheOut.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.8, 0.8, 1.0)];
    breatheOut.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    breatheOut.beginTime = duration;
    breatheOut.duration = duration; // 1.0
    breatheOut.repeatCount = 1;
    breatheOut.removedOnCompletion = NO;
    breatheOut.fillMode = kCAFillModeForwards;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration = duration*2; // 2.8
    group.repeatCount = HUGE_VAL;
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    group.animations = [NSArray arrayWithObjects:breatheIn, breatheOut, nil];
    
    return group;
}

@end
