//
//  DTimerObject.m
//  Disconto
//
//  Created by Rostislav on 5/3/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import "DTimerObject.h"

@implementation DTimerObject

+ (void)runTimerForDuration:(int)duration callback:(void (^)(NSString *stringTime, float second)) callback{
    
    static DTimerObject *timer = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        timer = [self new];
    });
    
    __block BOOL repeats = duration;
    __block  int timeLeft = duration;
    
    timer.timer = [NSTimer timerWithTimeInterval:1.0 repeats:repeats block:^(NSTimer * _Nonnull timer) {
        
        timeLeft = timeLeft - 1;
        repeats = timeLeft;
        callback([NSString stringWithFormat:@"%02d:%02d",(timeLeft/60)%60, timeLeft % 60],timeLeft % 60);
        
    }];
}

@end
