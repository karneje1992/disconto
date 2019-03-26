//
//  AppDelegate.h
//  Disconto
//
//  Created by user on 11.05.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "DTabBarController.h"
#import "DForceCubeSubClass.h"

@class ForceCuBe;
//@class DTabBarController;

@protocol AppDelegateMyDelegate <NSObject>

- (void)openBiconController:(id)biconController;

@end
@interface AppDelegate : UIResponder <UIApplicationDelegate>


@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) MPMoviePlayerViewController * moviePlayerViewController;
@property ForceCuBe * forcecube;
@property id <AppDelegateMyDelegate> customDelegate;
@end

