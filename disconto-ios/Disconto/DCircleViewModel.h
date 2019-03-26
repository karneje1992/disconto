//
//  DCircleViewModel.h
//  Loter
//
//  Created by Rostislav on 25.11.16.
//  Copyright © 2016 Devium. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DCircleViewModelDelegate <NSObject>

- (void)animatetdStopedWithController:(id)model;

@end

@interface DCircleViewModel : NSObject

@property NSData *circleImageData;
@property NSData *pinImageData;
@property NSData *backgroundImageData;
@property NSData *titleImageData;
@property NSData *logoImageData;
@property double rotateGrad;
@property NSString *message;
@property NSString *sessionID;
@property id <DCircleViewModelDelegate> delegate;
@property AVAudioPlayer *player;
- (instancetype)initWithParammetr:(NSDictionary *)parammetr;
- (void)runSpinAnimationOnView:(UIView*)view duration:(CGFloat)duration;
@end
