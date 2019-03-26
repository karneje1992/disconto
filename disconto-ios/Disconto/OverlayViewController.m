//
//  OverlayViewController.m
//  Disconto
//
//  Created by user on 01.07.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import "OverlayViewController.h"

@interface OverlayViewController ()

@property NSMutableArray *photoArray;
@property UIAlertView *sendAlert;
@property UIAlertView *clearAlert;
@property NSMutableArray<DProductModel *> *products;
@property NSInteger storeID;
@end

@implementation OverlayViewController

+ (instancetype)showCameraControllerWithProducts:(NSArray<DProductModel *> *)products andStoreID:(NSInteger)storID{
    
    return [[OverlayViewController alloc] initWithNibName:NSStringFromClass([OverlayViewController class]) bundle:nil andProducts:products andStoreID:storID];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andProducts:(NSArray<DProductModel *> *)products andStoreID:(NSInteger)storeID
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.products = products.mutableCopy;
        self.storeID = storeID;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    //  [self takePhoto:nil];
    self.photoButton.layer.cornerRadius =0.5*self.photoButton.bounds.size.width;
    self.photoArray = @[].mutableCopy;
    [self updateCounterLabel];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                              initWithTitle:@"Изменить" style:UIBarButtonItemStylePlain  target:self  action:@selector(send)];
    [self crop:nil];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    self.title = @"Фото чека";
    [self updateCounterLabel];
}

- (void)send{
    [self cropperImage:self.imageView.image];
}

- (IBAction)takePhoto:(UIButton *)sender {
    
    SHOW_PROGRESS;
    NSMutableDictionary *dict = @{}.mutableCopy;
    [dict setObject:@(self.storeID) forKey:@"store_id"];
    [dict setObject:[self convertImageArrayToDataArray:self.photoArray] forKey:@"files"];
    [dict setObject:[self productDictionaryToSend:self.products] forKey:@"products"];
    
    
    [[NetworkManeger sharedManager] sendPostRequestToServerWithDictionary:dict andAPICall:[NSString stringWithFormat:@"/checktab"] withCallBack:^(BOOL success, NSDictionary *resault) {
        
        if (success) {
            SHOW_MESSAGE(@"Фото чека было успешно отправлено. Администратор все проверит в течение 48 часов", @"Пожалуйста, сохраните чек до момента его подтверждения")
            NSInteger i = [[NSUserDefaults standardUserDefaults] integerForKey:@"numOfLCalls"];
            [[NSUserDefaults standardUserDefaults] setInteger:i+1 forKey:@"numOfLCalls"];
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            ViewController *vc = [sb instantiateInitialViewController];// Or any VC with Id
            AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
            appDelegate.window.rootViewController = vc; // PLEASE READ NOTE ABOUT THIS LINE
            [UIView transitionWithView:appDelegate.window
                              duration:0
                               options:UIViewAnimationOptionTransitionCrossDissolve
                            animations:^{ appDelegate.window.rootViewController = vc; }
                            completion:nil];
            
        }
        HIDE_PROGRESS;
    }];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerOriginalImage];
    [self.photoArray addObject:chosenImage];
    
    
    [picker dismissViewControllerAnimated:NO completion:^{
        [self cropperImage:chosenImage];
        
    }];
    
    
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    
    [picker dismissViewControllerAnimated:NO completion:nil];
    
}

- (void)cropViewController:(PECropViewController *)controller didFinishCroppingImage:(UIImage *)croppedImage
{
    [controller.navigationController popViewControllerAnimated:NO];
    [self.photoArray removeObject:self.photoArray.lastObject];
    [self.photoArray addObject:croppedImage];
    
    [self updateCounterLabel];
}

- (void)cropViewControllerDidCancel:(PECropViewController *)controller{
    
    [controller.navigationController popViewControllerAnimated:NO];
    [self updateCounterLabel];
}

- (void)updateCounterLabel{
    
    [self.counterLabel setText:[NSString stringWithFormat:@"Сделано фото %@ (максимум %@)",@(self.photoArray.count),@(photoLimited)]];
    [self.navigationItem.rightBarButtonItem setEnabled:self.photoArray.count];
    [self.clear setEnabled:self.photoArray.count];
    [self.photoButton setEnabled:self.photoArray.count];
    self.photoArray.count != 5 ? [self.cropButton setAlpha:YES] : [self.cropButton setAlpha:NO];
    self.photoArray.count == 0 ? [self.imageView setImage:[UIImage imageNamed:@"overlaygraphic"]] :
    [self.imageView setImage:self.photoArray.lastObject];
}

- (IBAction)clear:(id)sender {
    
    self.clearAlert = [[UIAlertView alloc] initWithTitle:@"Вы уверены, что хотите удалить фото ?" message:nil delegate:self cancelButtonTitle:@"Нет" otherButtonTitles:@"Да", nil];
    [self.clearAlert show];
}

- (IBAction)crop:(id)sender {
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        SHOW_MESSAGE(@"Error", @"Device has no camera");
    } else {
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = NO;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:NO completion:nil];
    }
}

- (void)cropperImage:(UIImage *)image{
    
    PECropViewController *controller = [[PECropViewController alloc] initWithNibName:@"PECropViewController" bundle:nil];
    controller.delegate = self;
    controller.image = image;
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:NO];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 1 && alertView == self.clearAlert) {
        
        [self.photoArray removeObject:[self.photoArray lastObject]];
        if (self.photoArray.count > 1) {
            
            
        }else{
            
            [self.imageView setImage:[UIImage imageNamed:@"overlaygraphic"]];
        }
        
    }else if (buttonIndex == 1 && alertView == self.sendAlert){
        
        
    }
    [self updateCounterLabel];
}

- (NSArray *)convertImageArrayToDataArray:(NSArray *)imageArray{
    
    UIImage *image;
    NSMutableArray *dataArray = @[].mutableCopy;
    for (UIImage *img in self.photoArray) {
        
        [dataArray addObject:[UIImageJPEGRepresentation([self imageWithImage:img convertToSize:img.size], 1.0) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength]];
        
        image = [UIImage imageWithData:UIImageJPEGRepresentation([self imageWithImage:img convertToSize:img.size], 1.0)];
    }
    
    return dataArray;
}

- (NSDictionary *)productDictionaryToSend:(NSArray *)products{
    
    NSMutableDictionary *productsDict = @{}.mutableCopy;
    for (DProductModel *obj in products) {
        [productsDict setObject:@(obj.sectedCount) forKey:[NSString stringWithFormat:@"%@",@(obj.productID)]];
    }
    return productsDict;
}

- (UIImage *)imageWithImage:(UIImage *)image convertToSize:(CGSize)size {
    
    UIGraphicsBeginImageContext(CGSizeMake(size.width*0.4,size.height*0.4));
    [image drawInRect:CGRectMake(0, 0, size.width*0.4,size.height*0.4)];
    UIImage *destImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return destImage;
}
@end
