//
//  DScannerViewController.h
//  Disconto
//
//  Created by Rostislav on 8/17/18.
//  Copyright © 2018 Disconto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DScannerViewController : DSuperViewController<AVCaptureMetadataOutputObjectsDelegate>

@property (weak, nonatomic) IBOutlet UIView *viewPreview;

+ (instancetype)showScannerViewController;
+ (void)sendToServerQrString:(NSString *)qrString;
+ (void)globalDismissAlert;
@end
