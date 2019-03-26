//
//  DPhotoListViewController.m
//  Disconto
//
//  Created by Rostislav on 26.10.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import "DPhotoListViewController.h"
#import "DImageTableViewCell.h"
static const CGFloat scaleParam = 0.5;
//static const NSInteger cellHight = 200;
static const NSInteger sectionCount = 1;

@interface DPhotoListViewController ()
@property UIBarButtonItem *rghtButton;
@property UIBarButtonItem *cameraButton;
@property NSMutableArray *imageArray;
@property NSArray<UIImage *> *imgArray;

@end

@implementation DPhotoListViewController

+ (instancetype)showImageListControllerWithArray:(NSArray<UIImage *> *)imageArray{
    
    return [[DPhotoListViewController alloc] initWithNibName:NSStringFromClass([DPhotoListViewController class]) bundle:nil andImageArray:imageArray];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andImageArray:(NSArray<UIImage *> *)imageArray
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.products = @[].mutableCopy;
        self.imgArray = @[];
        self.imageArray = imageArray.mutableCopy;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView reloadData];
    
    UIBarButtonItem *back = [[UIBarButtonItem alloc]
                             initWithImage:[UIImage imageNamed:@"back"]
                             style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.title = photoControllerTitle;
    
    self.rghtButton = [[UIBarButtonItem alloc] initWithTitle:textChange style:UIBarButtonItemStylePlain target:self action:@selector(editer)];
//    self.cameraButton = [[UIBarButtonItem alloc]
//                         initWithImage:[UIImage imageNamed:@"takePhoto"]
//                         style:UIBarButtonItemStylePlain target:self action:@selector(camera)];
    
    [self.navigationItem setLeftBarButtonItems:@[back]];
    self.navigationItem.rightBarButtonItem = self.rghtButton;
    [self.rghtButton setEnabled:self.imageArray.count];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    self.imgArray = self.imageArray;
    [self.tableView reloadData];
    if (self.imageArray.count > 1) {
        [self.bottonImage setAlpha:1];
    }else{
    
        [self.bottonImage setAlpha:0];
    }
}

- (void)camera{
    
    [self.delegate imageListController:self exitWithArray:self.imageArray];
}
- (void)back{
    
    [self.delegate imageListControllerExit:self];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //#warning Incomplete implementation, return the number of sections
    return sectionCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //#warning Incomplete implementation, return the number of rows
    return self.imgArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DImageTableViewCell *cell = [DImageTableViewCell getCellForTableView:tableView andClassCellString:NSStringFromClass([DImageTableViewCell class]) andIndexPath:indexPath];
    UIImageView *imageViewLeft = [[UIImageView alloc] initWithFrame:cell.contentView.bounds];
    imageViewLeft.contentMode = UIViewContentModeScaleToFill;
    // imageViewLeft.clipsToBounds = YES;
    imageViewLeft.image = self.imgArray[indexPath.row];
    [cell.contentView addSubview:imageViewLeft];
    
    return cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat height = scrollView.frame.size.height;
    
    CGFloat contentYoffset = scrollView.contentOffset.y;
    
    CGFloat distanceFromBottom = scrollView.contentSize.height - contentYoffset;
    
    if(distanceFromBottom < height)
    {
        [self.bottonImage setAlpha:0];
    }else if(self.imageArray.count > 1 && distanceFromBottom > height){
    
        [self.bottonImage setAlpha:1];
    }
}
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [self.imageArray removeObjectAtIndex:indexPath.row];
        [tableView reloadData];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self getHeightWithImage:_imgArray[indexPath.row]];
}

- (CGFloat)getHeightWithImage:(UIImage *)image{
    
    return image.size.height*(self.tableView.bounds.size.width/image.size.width);
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 86.5;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *view = [UIView new];
    [view setBackgroundColor:[UIColor blackColor]];
    return view;
}

- (void)send{
    
    SHOW_PROGRESS;
    NSMutableDictionary *dict = @{}.mutableCopy;
    [dict setObject:@(self.storeID) forKey:@"store_id"];
    [dict setObject:[self convertImageArrayToDataArray:self.imageArray] forKey:@"files"];
    [dict setObject:[self productDictionaryToSend:self.products] forKey:@"products"];
    [[NetworkManeger sharedManager] sendPostRequestToServerWithDictionary:dict andAPICall:[NSString stringWithFormat:@"/checktab"] withCallBack:^(BOOL success, NSDictionary *resault) {
        
        if (success) {
            SHOW_MESSAGE(textAlertFromSending, resault[kServerData][@"limit"] ? resault[kServerData][@"limit"] : textAlertFromSending2)
            RESTART;
        }
        HIDE_PROGRESS;
    }];
    
}

- (NSArray *)convertImageArrayToDataArray:(NSArray *)imageArray{
    
    UIImage *image;
    NSMutableArray *dataArray = @[].mutableCopy;
    for (UIImage *img in self.imageArray) {
        
        [dataArray addObject:[UIImageJPEGRepresentation([self imageWithImage:img convertToSize:img.size], 1.0) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength]];
        
        image = [UIImage imageWithData:UIImageJPEGRepresentation([self imageWithImage:img convertToSize:img.size], 1.0)];
    }
    
    return dataArray;
}

- (UIImage *)imageWithImage:(UIImage *)image convertToSize:(CGSize)size {
    
    UIGraphicsBeginImageContext(CGSizeMake(size.width*scaleParam,size.height*scaleParam));
    [image drawInRect:CGRectMake(0, 0, size.width*scaleParam,size.height*scaleParam)];
    UIImage *destImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return destImage;
}

- (NSDictionary *)productDictionaryToSend:(NSArray *)products{
    
    NSMutableDictionary *productsDict = @{}.mutableCopy;
    for (DProductModel *obj in products) {
        [productsDict setObject:@(obj.sectedCount) forKey:[NSString stringWithFormat:@"%@",@(obj.productID)]];
    }
    return productsDict;
}

- (IBAction)deleteLastPhoto:(id)sender {
    
    [[[UIAlertView alloc] initWithTitle:@"" message:textDeletePhotoAlert delegate:self cancelButtonTitle:@"Нет" otherButtonTitles:@"Удалить", nil] show];

}

- (IBAction)sendToServer:(id)sender {
    
    [self send];
}

- (IBAction)addPhoto:(id)sender {
    
    [self camera];
}

- (void)editer{
    
    if (self.imageArray.count) {
        PECropViewController *controller = [[PECropViewController alloc] initWithNibName:@"PECropViewController" bundle:nil];
        controller.delegate = self;
        controller.image = [self.imageArray lastObject];
        controller.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:controller animated:NO];
    }
}

- (void)cropViewController:(PECropViewController *)controller didFinishCroppingImage:(UIImage *)croppedImage{
    
    [controller.navigationController popViewControllerAnimated:NO];
    [self.imageArray removeObject:[self.imageArray lastObject]];
    [self.imageArray addObject:croppedImage];
    [self.tableView reloadData];
}

- (void)cropViewControllerDidCancel:(PECropViewController *)controller{
    
    [controller.navigationController popViewControllerAnimated:NO];
    [self.imageArray removeObject:[self.imageArray lastObject]];
    [self.tableView reloadData];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (buttonIndex > 0) {
        if (self.imageArray.count) {
            [self.imageArray removeObject:[self.imageArray lastObject]];
            [self.tableView reloadData];
            if (self.imageArray.count < 1) {
                [self camera];
            }
        }
    }
}
@end
