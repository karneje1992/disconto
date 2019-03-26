//
//  DTimer.h
//  Disconto
//
//  Created by user on 30.03.16.
//  Copyright © 2016 StudioVision. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DTimerDelegate <NSObject>

- (void)currentSecond:(NSInteger)currentSecond;

@end
@interface DTimer : NSObject

@property id <DTimerDelegate> timerDelegate;
@property NSInteger timeDown;
@property NSString *secondString;

- (void)starTimer;
- (void)stopTimer;

@end
