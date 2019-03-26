//
//  DSingleProductController.m
//  Disconto
//
//  Created by Ross on 21.05.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import "DSingleProductController.h"

@interface DSingleProductController () <TTTAttributedLabelDelegate, UITableViewDelegate, UITableViewDataSource>

@property CGFloat headerSize;
@property NSInteger shopsRowsCount;
@end

@implementation DSingleProductController

+ (instancetype)openSingleProduct:(DProductModel *)product{
    
    return [[DSingleProductController alloc] initWithNibName:NSStringFromClass([DSingleProductController class]) bundle:nil andProduct:product];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andProduct:(DProductModel *)product {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.product = product;
//        [DProductModel updateProduct:product withCollBack:^(DProductModel *obj) {
//            
//            self.product = obj;
//            self.shopsRowsCount = roundf((float)self.product.stores.count*0.5);
//            [self.tableView reloadData];
//        }];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    self.actionButton.layer.cornerRadius = 4;
    self.actionButton.alpha = 0;
  //  SHOW_PROGRESS;
    
    [self setTitle: self.product.productName];
    [StyleChangerClass changeButton:self.actionButton andController:self andTitle:titleGetPhotoChak];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    UIBarButtonItem *rghBtn = [[UIBarButtonItem alloc]
                               initWithImage:[UIImage imageNamed:@"shareNew"] style:UIBarButtonItemStylePlain target:self action:@selector(share)];
    self.navigationItem.rightBarButtonItem = rghBtn;
//    SHOW_PROGRESS;
//    [DProductModel updateProduct:self.product withCollBack:^(DProductModel *obj) {
//        self.navigationItem.title = obj.productName;
//        self.product = obj;
//        self.shopsRowsCount = roundf((float)self.product.stores.count*0.5);
//        [self.tableView reloadData];
//        
//        switch (self.product.status) {
//                
//            case DisLocked:
//                [self.actionButton setTitle:unlockDiscontButtonTitle forState:UIControlStateNormal];
//                break;
//            case DisInprogress:{
//                
//                [self.actionButton setEnabled:NO];
//                [self.actionButton setTitle:@"Дисконт в обработке" forState:UIControlStateNormal];
//                [self.actionButton setBackgroundColor:[UIColor lightGrayColor]];
//            }
//                break;
//                
//            default:
//                [StyleChangerClass changeButton:self.actionButton andController:self andTitle:titleGetPhotoChak];
//                break;
//        }
//        
//        self.actionButton.alpha = 1;
//        HIDE_PROGRESS;
//    }];
}

#pragma mark - UITableView DataSourse/Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor lightGrayColor];
    view.alpha = 0.5;
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    switch (section) {

      //  case sShops:
         case sPrice:
            return 1;
        case sHeader:
        case sName:
        case sDescription:
            
            return 0;
        case sLegal:
        default:
            return 10;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if (section == sLegal) {
        return 66;
    }else{
        
        return 0;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return sSectionCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case sHeader:{
            
            DProductHeaderCell *headerCell = [DProductHeaderCell getHeaderWithProduct:self.product andTableView:tableView];
            [headerCell updateCell];
            _headerSize = tableView.bounds.size.width / headerCell.productImageView.image.size.width * headerCell.productImageView.image.size.height;
            headerCell.statusImageView.layer.cornerRadius = headerCell.statusImageView.bounds.size.width*0.5;
            headerCell.statusImageView.layer.masksToBounds = YES;
            headerCell.statusImageView.layer.borderWidth = 1;
            headerCell.statusImageView.layer.borderColor = SYSTEM_COLOR.CGColor;
            [headerCell.productImageView setAlpha:_headerSize];
          
            return headerCell;
        }
        case sName:{
            
            DColorTextCell *nameCell = [DColorTextCell getCellForTableView:tableView andClassCellString:NSStringFromClass([DColorTextCell class])];
            
            [nameCell showProductName:self.product];
          
            return nameCell;
        }
        case sPrice:{
            
            DColorTextCell *priseCell = [DColorTextCell getCellForTableView:tableView andClassCellString:NSStringFromClass([DColorTextCell class])];
            
            [priseCell showProductPrice:self.product];

            return priseCell;
        }
        case sDescription:{
            
            DDescriptionCell *smallCell = [DDescriptionCell getCellForTableView:tableView andClassCellString:NSStringFromClass([DDescriptionCell class])];

            ((TTTAttributedLabel *)smallCell.descriptionLabel).enabledTextCheckingTypes = NSTextCheckingTypeLink|NSTextCheckingTypePhoneNumber;
            ((TTTAttributedLabel *)smallCell.descriptionLabel).delegate = self;
            
            [smallCell showSmallDescriptionFromProduct:self.product];
            return smallCell;
        }
        case sFullDescriptin:{
            
            DDescriptionCell *smallCell = [DDescriptionCell getCellForTableView:tableView andClassCellString:NSStringFromClass([DDescriptionCell class])];

            
            ((TTTAttributedLabel *)smallCell.descriptionLabel).enabledTextCheckingTypes = NSTextCheckingTypeLink|NSTextCheckingTypePhoneNumber;
            ((TTTAttributedLabel *)smallCell.descriptionLabel).delegate = self;
            
            [smallCell showFullDescriptionFromProduct:self.product];
            return smallCell;
        }

        case sLegal:{
            
            DDescriptionCell *smallCell = [DDescriptionCell getCellForTableView:tableView andClassCellString:NSStringFromClass([DDescriptionCell class])];

            
            ((TTTAttributedLabel *)smallCell.descriptionLabel).enabledTextCheckingTypes = NSTextCheckingTypeLink|NSTextCheckingTypePhoneNumber;
            ((TTTAttributedLabel *)smallCell.descriptionLabel).delegate = self;
            
            [smallCell showLegal:self.product];

            return smallCell;
        }

    }
    
    return [UITableViewCell new];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
        case sHeader:
            return isnan(_headerSize) ? tableView.bounds.size.height*0.5 : _headerSize;
            break;
        case sFullDescriptin:
            if (self.product.fullDescription.length < 1) {
                return 0;
            }
            break;
        case sLegal:
            if (self.product.legalDescription.length < 1) {
                return 0;
            }
            break;
        default:
            return UITableViewAutomaticDimension;
            break;
    }
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 200.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
}

- (IBAction)action:(id)sender {
    
    [self.navigationController pushViewController:[DScannerViewController showScannerViewController] animated:NO];
}

- (void)share{
    
    NSString *textToShare = self.product.descriptionProduct;
    NSMutableArray *objectsToShare = @[].mutableCopy;
    
    [objectsToShare addObjectsFromArray:@[textToShare,@"#Дисконто",@"Здесь Вы зарабатываете!",@"https://disconto.me"]];
    if ([ValidatorValues urlConnectionSucsess:self.product.productImageURL]) {
        
        [objectsToShare addObject:[UIImage imageWithData:[NSData dataWithContentsOfURL:self.product.productImageURL]]];
    }
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:objectsToShare applicationActivities:nil];
    
    NSArray *excludeActivities = @[];
    
    activityVC.excludedActivityTypes = excludeActivities;
    
    [self presentViewController:activityVC animated:YES completion:nil];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight = 30;
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}

#pragma mark - mail veryFary

- (void)changeEmail{
    
    [DUserModel updateProfileWithCallBack:^(DUserModel *resault) {
        DChangeEmailViewController *vc = [DChangeEmailViewController changeEmail:[resault.verifications firstObject].emailNew];
        vc.delegete = self;
        vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        [self.navigationController presentViewController:vc animated:NO completion:nil];
    }];
}

- (void)toSupp{
    
    DSendToSupportController *vc = [[DSendToSupportController alloc] initWithNibName:NSStringFromClass([DSendToSupportController class]) bundle:nil];
    vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:vc];
    vc.alternative = YES;
    [self presentViewController:navController animated:NO completion:nil];
}

- (void)resend{
    
    [DUserModel updateProfileWithCallBack:^(DUserModel *resault) {
        
        //        [DUserModel resendToUser:resault withCallBack:^(BOOL succsess) {
        //
        //            [[[UIAlertView alloc] initWithTitle:@"На вашу почту отправлено сообщение для подтверждения" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
        //        }];
    }];
    
}

- (void)exit{
    
}

- (void)controller:(id)controller isChanged:(BOOL)isChanged{

    if (isChanged) {
        [controller dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithURL:(NSURL *)url {
    
    [[UIApplication sharedApplication] openURL:url];
}
@end
