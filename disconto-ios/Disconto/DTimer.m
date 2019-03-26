//
//  DTimer.m
//  Disconto
//
//  Created by user on 30.03.16.
//  Copyright © 2016 StudioVision. All rights reserved.
//

#import "DTimer.h"

@interface DTimer ()

@property NSTimer *timer;

@end

@implementation DTimer

- (void)starTimer{
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                  target:self
                                                selector:@selector(secondLeft)
                                                userInfo:nil
                                                 repeats:YES];
    
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)stopTimer{
    
    dispatch_async(dispatch_get_main_queue(),
                   ^{
                       [self setTimeDown:0];
                       self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                                     target:self
                                                                   selector:@selector(secondLeft)
                                                                   userInfo:nil
                                                                    repeats:NO];
                   });
}

- (void)secondLeft{
    
    [self stringSeconds];
    self.timeDown > 0 ? [self.timerDelegate currentSecond:--self.timeDown] : [self.timer invalidate];
}

- (void)stringSeconds{

    int seconds = self.timeDown % 60;
    int minutes = (self.timeDown / 60) % 60;
    self.secondString = [NSString stringWithFormat:@"%02d:%02d",minutes, seconds];
}
@end
