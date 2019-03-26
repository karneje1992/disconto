//
//  DShowWebSiteController.h
//  Disconto
//
//  Created by Ross on 22.05.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSuperViewController.h"

@protocol DShowWebSiteControllerDelegate <NSObject>

- (void)startLoad;
- (void)exitWebView:(id)controller;

@end

@interface DShowWebSiteController : DSuperViewController <UIWebViewDelegate, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andURL:(NSURL *)url;
+ (instancetype)showWebViewWithURL:(NSURL *)url;
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andData:(NSData *)data;
+ (instancetype)showWebViewWithData:(NSData *)data;
@property id <DShowWebSiteControllerDelegate> delegate;
@end
