//
//  DCacameraViewController.m
//  testCameOverlayr
//
//  Created by user on 31.08.16.
//  Copyright © 2016 Devium. All rights reserved.
//

#import "DCacameraViewController.h"
#import <AVFoundation/AVFoundation.h>

//static const CGFloat scaleParam = 0.5;

@interface DCacameraViewController () <DTutorialViewControllerDelegate>

@property AVCaptureSession *session;
@property AVCaptureStillImageOutput *stillImageOutput;
@property NSMutableArray *imageArray;

@property NSMutableArray<DProductModel *> *products;
@property NSInteger storeID;
@end

@implementation DCacameraViewController

+ (instancetype)showCameraControllerWithProducts:(NSArray<DProductModel *> *)products andStoreID:(NSInteger)storID{
    
    return [[DCacameraViewController alloc] initWithNibName:NSStringFromClass([DCacameraViewController class]) bundle:nil andProducts:products andStoreID:storID];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andProducts:(NSArray<DProductModel *> *)products andStoreID:(NSInteger)storeID
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.imageArray = @[].mutableCopy;
        self.products = products.mutableCopy;
        self.storeID = storeID;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBar.tintColor = SYSTEM_COLOR;
    __block NSDateFormatter *dateformat = [[NSDateFormatter alloc] init];

    [dateformat setDateFormat:dateFormatText];
    
    [DUserModel updateProfileWithCallBack:^(DUserModel *model) {
      
        [[NetworkManeger sharedManager] sendGetRequestToServerWithDictionary:@{} andAPICall:apiSettingsCamera withCallBack:^(BOOL success, NSDictionary *resault) {
            if (success) {
                
//                NSInteger daysToAdd = [resault[@"data"][@"check_days"] integerValue];
//                [[[UIAlertView alloc] initWithTitle:textCameraAlert message:[NSString stringWithFormat:@"Убедитесь, что:\nГород совершения покупки : %@ \nМагазин: %@ \nДата чека должна быть не ранее : %@",model.userCityName,self.storeName, [dateformat stringFromDate:[[NSDate date] dateByAddingTimeInterval:-(60*60*24*daysToAdd)]]] delegate:self cancelButtonTitle:@"Далее" otherButtonTitles:@"Просмотреть инструкцию", nil] show];
            }
        }];

    }];

    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    

    [self updateBage];
    [self.splachView setAlpha:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.activity setAlpha:0];
}

+ (instancetype)showCamera{
    
    return [[DCacameraViewController alloc] initWithNibName:NSStringFromClass([DCacameraViewController class]) bundle:nil];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.imageArray = @[].mutableCopy;
    }
    return self;
}

- (void)initCamera{
    
    self.cameraView.layer.sublayers = nil;
    [self.session stopRunning];
    [self.activity startAnimating];
    [self.activity setAlpha:1];
    
    dispatch_async(dispatch_get_main_queue(), ^(void){
        
        [self.activity stopAnimating];
        [self.activity setAlpha:0];
        self.session = [AVCaptureSession new];
        [self.session setSessionPreset:AVCaptureSessionPresetPhoto];
        AVCaptureDevice *divace = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        AVCaptureDeviceInput *inputDivase = [[AVCaptureDeviceInput alloc] initWithDevice:divace error:nil];
        if ([self.session canAddInput:inputDivase]) {
            [self.session addInput:inputDivase];
        }
        AVCaptureVideoPreviewLayer *previeLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
        [previeLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
        
        [self.cameraView.layer setMasksToBounds:YES];
        // CGRect frame = self.cameraView.frame;
        previeLayer.frame = self.cameraView.bounds;
        [self.cameraView.layer insertSublayer:previeLayer atIndex:arc4random_uniform(99999)];
        
        self.stillImageOutput = [AVCaptureStillImageOutput new];
        [self.stillImageOutput setOutputSettings:[[NSDictionary alloc] initWithObjectsAndKeys:AVVideoCodecJPEG,AVVideoCodecKey, nil]];
        [self.session addOutput:self.stillImageOutput];
        [self.session startRunning];
    });
    
}



- (IBAction)takePhoto:(id)sender {
    
    __block UIImage *image = nil;
    AVCaptureConnection *connection = nil;
    for (AVCaptureConnection *customConect in self.stillImageOutput.connections) {
        for (AVCaptureInputPort *port in customConect.inputPorts) {
            
            if ([[port mediaType] isEqual:AVMediaTypeVideo]) {
                connection = customConect;
            }
        }
        
        if (connection) {
            break;
        }
    }
    
    [self.stillImageOutput captureStillImageAsynchronouslyFromConnection:connection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
        
        if (!error && imageDataSampleBuffer != NULL) {
            image = [UIImage imageWithData:[AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer]];
            [self.imageArray addObject:image];
            
            [UIView animateWithDuration:0.1
                                  delay:0.1
                                options:UIViewAnimationOptionAllowUserInteraction
                             animations:^{
                                 
                                 [self.splachView setAlpha:1];
                             }
                             completion:^(BOOL finished){
                                 [self.splachView setAlpha:0];
                                 [self updateBage];
                                 [self activePhotos:self];
                             }];
        }
    }];
    
}
- (IBAction)showGallery:(id)sender {
    
    [self galleryAction];
}
- (IBAction)activePhotos:(id)sender {
    
    if (self.imageArray.count > 0 ) {
        DPhotoListViewController *vc = [DPhotoListViewController showImageListControllerWithArray:self.imageArray];
        vc.delegate = self;
        vc.storeID = self.storeID;
        vc.products = self.products;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else SHOW_MESSAGE(nil, @"Нет фото чеков!");
    
}

- (void)galleryAction{
  
    UIImagePickerController *pickerView =[[UIImagePickerController alloc]init];
    //  pickerView.allowsImageEditing = YES;
    pickerView.delegate = self;
    pickerView.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:pickerView animated:YES completion:nil];
//    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
//        UIImagePickerController *pickerView =[[UIImagePickerController alloc]init];
//      //  pickerView.allowsImageEditing = YES;
//        pickerView.delegate = self;
//        pickerView.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//        [self presentViewController:pickerView animated:YES completion:nil];
//    }else{
//    
//        UIImagePickerController *pickerView =[[UIImagePickerController alloc]init];
//        //  pickerView.allowsImageEditing = YES;
//        pickerView.delegate = self;
//        pickerView.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//        [self presentViewController:pickerView animated:YES completion:nil];
//    }
}

- (void)updateBage{
    
    [self initCamera];
  //  [self.activePhotos setEnabled:self.imageArray.count];

    [self.takePhotoButton setEnabled:self.imageArray.count < 5];
    [self.galleryButton setEnabled:self.imageArray.count < 5];
    [self.counterLabel setText:[NSString stringWithFormat:@"Сделано фото %@ из 5",@(self.imageArray.count)]];
    [self.activePhotos setEnabled:self.imageArray.count];
    [self.activePhotos setTitleColor:self.imageArray.count > 0 ?[UIColor whiteColor] : [UIColor lightGrayColor] forState:UIControlStateNormal];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    
    [self.previeImageView setAlpha:0];
    switch (item.tag) {
        case galeryAction:
            
            [self galleryAction];
            break;
        case takePhotoAction:
            
            [self takePhoto:self];
            break;
        case photoListAction:
        {
            DImageListTableViewController *vc = [DImageListTableViewController showImageListControllerWithArray:self.imageArray];
            vc.delegate = self;
            vc.storeID = self.storeID;
            vc.products = self.products.mutableCopy;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
}

#pragma mark - UIImagePickerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    UIImage * image = [info valueForKey:UIImagePickerControllerOriginalImage];
    [self.imageArray addObject:image];
    [self updateBage];
    [self activePhotos:self];
  //  [self editer];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    [self updateBage];

}

- (void)imageListController:(id)controller exitWithArray:(NSArray *)imageArray{
    
    UIViewController *vc = controller;
    [vc.navigationController popViewControllerAnimated:NO];
    self.imageArray = imageArray.mutableCopy;
    [self updateBage];

}

- (void)imageListControllerExit:(id)controller{

    SHOW_PROGRESS;
    UIViewController *vc = controller;
    [vc.navigationController popViewControllerAnimated:NO];
    [self.navigationController popViewControllerAnimated:NO];
    HIDE_PROGRESS;
}

#pragma mark alert

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (buttonIndex > 0) {
        
        DTutorialViewController *vc = [DTutorialViewController showTutorialWithImgArray:[DSuperViewController getPhotoTutorial] andShowButton:NO];
        vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (NSString *)getMinDateString{


    NSDateFormatter *dateformat = [[NSDateFormatter alloc] init];
    [dateformat setDateFormat:dateFormatText];
    NSMutableArray *arr = @[].mutableCopy;
    [self.products enumerateObjectsUsingBlock:^(DProductModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (obj.expires.length) {
            
             [arr addObject:[dateformat dateFromString:obj.expires]];
        }
        
    }];
    NSDate *minDate = [[arr sortedArrayUsingSelector:@selector(compare:)] firstObject];
    return [dateformat stringFromDate:minDate];
}

- (BOOL)startReading {
    NSError *error;
    
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    if (!input) {
        NSLog(@"%@", [error localizedDescription]);
        return NO;
    }
    
    _session = [[AVCaptureSession alloc] init];
    [_session addInput:input];
    
    AVCaptureMetadataOutput *captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
    [_session addOutput:captureMetadataOutput];
    
    dispatch_queue_t dispatchQueue;
    dispatchQueue = dispatch_queue_create("myQueue", NULL);
    [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatchQueue];
    [captureMetadataOutput setMetadataObjectTypes:[NSArray arrayWithObject:AVMetadataObjectTypeQRCode]];
    
    AVCaptureVideoPreviewLayer *previeLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
    [previeLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    
    [self.cameraView.layer setMasksToBounds:YES];
    // CGRect frame = self.cameraView.frame;
    previeLayer.frame = self.cameraView.bounds;
    [self.cameraView.layer insertSublayer:previeLayer atIndex:arc4random_uniform(99999)];
    
    [_session startRunning];
    
    return YES;
}

#pragma mark - DTutorialViewControllerDelegate

- (void)exitTutorialViewController:(id)controller{

    DTutorialViewController * vc = controller;
    [vc.navigationController popViewControllerAnimated:YES];
}
@end
