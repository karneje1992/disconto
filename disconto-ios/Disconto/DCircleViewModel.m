//
//  DCircleViewModel.m
//  Loter
//
//  Created by Rostislav on 25.11.16.
//  Copyright © 2016 Devium. All rights reserved.
//

#define DEGREES_TO_RADIANS(radians) ((radians) / 180.0 * M_PI)

#import "DCircleViewModel.h"
#import <QuartzCore/QuartzCore.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@implementation DCircleViewModel

- (instancetype)initWithParammetr:(NSDictionary *)parammetr
{
    self = [super init];
    if (self) {

        [self setBackgroundImageData:[NSData dataWithContentsOfURL:[NSURL URLWithString:parammetr[@"background"]]]];
        [self setCircleImageData:[NSData dataWithContentsOfURL:[NSURL URLWithString:parammetr[@"image"]]]];
        [self setPinImageData:[NSData dataWithContentsOfURL:[NSURL URLWithString:parammetr[@"pointer"]]]];
                [self setTitleImageData:[NSData dataWithContentsOfURL:[NSURL URLWithString:parammetr[@"label"]]]];
        [self setLogoImageData:[NSData dataWithContentsOfURL:[NSURL URLWithString:parammetr[@"logo"]]]];
        [self setTitleImageData:[NSData dataWithContentsOfURL:[NSURL URLWithString:parammetr[@"label"]]]];
        [self setRotateGrad:DEGREES_TO_RADIANS([parammetr[@"angle"] doubleValue])];
        [self setMessage:parammetr[@"message"]];
        [self setSessionID:parammetr[@"id"]];
    }
    return self;
}

- (void)runSpinAnimationOnView:(UIView*)view duration:(CGFloat)duration
{
    NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:@"fortune"
                                                              ofType:@"mp3"];
    NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
    
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL error:nil];
    _player.numberOfLoops = 0; //Infinite
    [NSTimer scheduledTimerWithTimeInterval:duration target:self selector:@selector(animatedStop) userInfo:nil repeats:0];
    view.transform = CGAffineTransformIdentity;
    [CATransaction begin];
    CABasicAnimation *rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.byValue = [NSNumber numberWithDouble:_rotateGrad+(M_PI*2)*duration];
    rotationAnimation.duration = duration;
    rotationAnimation.fromValue = 0;
    rotationAnimation.toValue = [NSNumber numberWithFloat:_rotateGrad+(M_PI*2)*duration];
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    rotationAnimation.removedOnCompletion = NO;
    rotationAnimation.fillMode = kCAFillModeForwards;
    [view.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    [CATransaction commit];

    
    [_player play];
    
}

- (void)animatedStop{
    
    [_player stop];
    [self.delegate animatetdStopedWithController:self];
}
@end
