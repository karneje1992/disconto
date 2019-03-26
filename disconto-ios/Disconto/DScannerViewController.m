//
//  DScannerViewController.m
//  Disconto
//
//  Created by Rostislav on 8/17/18.
//  Copyright © 2018 Disconto. All rights reserved.
//

#import "DScannerViewController.h"
#import "ERProgressHud.h"


@interface DScannerViewController ()


@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *videoPreviewLayer;
@property BOOL isReading;
@property BOOL isScanning;
@property NSString *stringForQR;

-(BOOL)startReading;

@end

@implementation DScannerViewController

+ (instancetype)showScannerViewController {
    
    return [[DScannerViewController alloc] initWithNibName:NSStringFromClass([DScannerViewController class]) bundle:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _isReading = NO;
    
    _captureSession = nil;
    [self addRightButton];
    
    [self.navigationItem setBackBarButtonItem:nil];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self  action:@selector(cancelChange)];
    [self.navigationItem setLeftBarButtonItem:backButton];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)cancelChange{
    
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    _isReading = [self startReading];
    _isScanning = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addRightButton{
    
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"Ввести вручную" style: UIBarButtonItemStyleDone target:self action:@selector(showCheckForm)];
    [self.navigationItem setRightBarButtonItem: button];
}

- (void)showCheckForm{
    
    [self.navigationController pushViewController:[QRSelfViewController showCQRSelfViewController] animated:NO];
}

- (BOOL)startReading {
    NSError *error;
    
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    if (!input) {
        NSLog(@"%@", [error localizedDescription]);
        return NO;
    }
    
    _captureSession = [[AVCaptureSession alloc] init];
    [_captureSession addInput:input];
    
    AVCaptureMetadataOutput *captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
    [_captureSession addOutput:captureMetadataOutput];
    
    dispatch_queue_t dispatchQueue;
    dispatchQueue = dispatch_queue_create("myQueue", NULL);
    [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatchQueue];
    [captureMetadataOutput setMetadataObjectTypes:[NSArray arrayWithObject:AVMetadataObjectTypeQRCode]];
    
    _videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
    [_videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [_videoPreviewLayer setFrame:_viewPreview.layer.bounds];
    [_viewPreview.layer addSublayer:_videoPreviewLayer];
    
    [_captureSession startRunning];
    
    return YES;
}

-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    
    if (metadataObjects != nil && [metadataObjects count] > 0) {
        
        dispatch_async(dispatch_get_main_queue(), ^(void){
            
            
            AVMetadataMachineReadableCodeObject *objc =  metadataObjects.firstObject;
            self.stringForQR = objc.stringValue;
            
            if (_isScanning == NO) {
                 _isScanning = YES;
                [DScannerViewController sendToServerQrString: self.stringForQR];
               
            }
            
        });
        
        return;
    }
}

+ (void)sendToServerQrString:(NSString *)qrString{
    
    
   // [JDragonHUD showTipViewAtCenter:@"Чек отправляется"];
    [[ERProgressHud sharedInstance] showWithTitle:@"Чек отправляется"];
    
    [[NetworkManeger sharedManager] sendPostRequestToURL: [NSString stringWithFormat:@"%@receipts", APMSERVER] dictionary:@{@"qrStr" : qrString} withCallBack:^(BOOL success, NSDictionary *resault) {
        
        [DScannerViewController globalDismissAlert];
        

        if ([resault[@"status"]  isEqual: @"success"]) {
            
            
            SHOW_MESSAGE(@"Чек отправлен", @"")
            RESTART;
        }
        
        [[ERProgressHud sharedInstance] hide];
    }];
}

+ (void)globalDismissAlert{
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    for (UIView *view in window.subviews) {
        if ([view isKindOfClass:[UIAlertView class]]) {
            [(UIAlertView *)view dismissWithClickedButtonIndex:[(UIAlertView *)view cancelButtonIndex] animated:YES];
        }
    }
}

@end
