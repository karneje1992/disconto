//
//  DBanerModel.m
//  Disconto
//
//  Created by user on 17.05.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import "DBanerModel.h"
#import "DCategoryViewModel.h"
#import "MVVMDProductsViewController.h"

@implementation DBanerModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary withStep:(NSInteger)step
{
    self = [super init];
    if (self) {
        self.type = dictionary[@"type_name"];
        self.banerID = [dictionary[kID] isEqual:[NSNull null]] ? nil : [NSString stringWithFormat:@"%@",dictionary[kID]];
        self.banerImageUrl = [NSURL URLWithString:dictionary[@"img_url"]];
        self.productID =  [dictionary[@"product_id"] isEqual:[NSNull null]] ? nil :  dictionary[@"product_id"];
        self.promoID = [dictionary[@"promo_id"] isEqual:[NSNull null]] ? nil :   dictionary[@"promo_id"];
        self.categoryID = [dictionary[@"category_id"] isEqual:[NSNull null]] ? nil :   dictionary[@"category_id"];
        self.shopID = [dictionary[@"store_id"] isEqual:[NSNull null]] ? nil :   dictionary[@"store_id"];
        self.step = step;
        self.url = [dictionary[@"url"] isEqual:[NSNull null]] ? nil :   dictionary[@"url"];
    }
    return self;
}

+ (void)getBanersWithCallBack:(void (^)(NSArray *resault))callBack{
    
    __block NSMutableArray *array = @[].mutableCopy;
    
    [[NetworkManeger sharedManager] sendGetRequestToServerWithDictionary:@{} andAPICall:[NSString stringWithFormat:@"%@",apiBaners] withCallBack:^(BOOL success, NSDictionary *resault) {
        
        dispatch_async(dispatch_get_main_queue(), ^(void){
            if (success) {
                
                NSInteger step = 0;
                for (NSDictionary *list in resault[kServerData]) {
                    
                    DBanerModel *obj = [[DBanerModel alloc] initWithDictionary:list withStep:step];
                    //  [scrollView addSubview:obj.button];
                    [array addObject:obj];
                    step += 1;
                }
                
                callBack(array);

            }
        });
        
    }];
}

+ (void)getNewBanersWithCallBack:(void (^)(NSArray *resault))callBack{
    
    __block NSMutableArray *array = @[].mutableCopy;

    [[NetworkManeger sharedManager] sendNewGetRequestToServerWith: [NSString stringWithFormat:@"%@banners", APMSERVER] callBack:^(BOOL success, NSDictionary *resault) {
        
        dispatch_async(dispatch_get_main_queue(), ^(void){
            if (success) {
                
                NSInteger step = 0;
                for (NSDictionary *list in resault[kServerData]) {
                    
                    DBanerModel *obj = [[DBanerModel alloc] initWithDictionary:list withStep:step];
                    //  [scrollView addSubview:obj.button];
                    [array addObject:obj];
                    step += 1;
                }
                
                callBack(array);
                
            }
        });
    }];
}

- (void)selectWithType:(DCategoryViewModel *)viewModel controller:(UIViewController *)controller{
    
    [[NetworkManeger sharedManager] sendPostRequestToServerWithDictionary:@{} andAPICall:[NSString stringWithFormat:@"/banners/viewed/%@",self.banerID] withCallBack:^(BOOL success, NSDictionary *resault) {
        
        if (success) {
            
            if ([self.type isEqualToString:@"product"]) {
                DProductModel *prod = [[DProductModel alloc] init];
                prod.productID = [self.productID integerValue];
                [DProductModel updateProduct:prod withCollBack:^(DProductModel *obj) {
                    
                    [controller.navigationController pushViewController:[DSingleProductController openSingleProduct:obj] animated:YES];
                }];
            } else if([self.type isEqualToString:@"free"]){
                
                DTutorialViewController *vc = [DTutorialViewController showTutorialWithImgArray:[DSuperViewController getTutorial] andShowButton:NO];
                vc.delegate = viewModel;
                vc.hidesBottomBarWhenPushed = YES;
                [controller.navigationController pushViewController:vc animated:YES];
                
            } else if ([self.type isEqualToString:@"promo"]){
                
                [[NetworkManeger sharedManager] sendGetRequestToServerWithDictionary:@{} andAPICall:[NSString stringWithFormat:@"/promo/%@",self.promoID] withCallBack:^(BOOL success, NSDictionary *resault) {
                    
                    if (success) {
                        
                        DOfferModel *offer = [DOfferModel getOfferWithDictionary:resault[@"data"]];
                        
                        if (offer.instuctions.count) {
                            DTutorialViewController *vc = [DTutorialViewController showOfferInstruction:offer];
                            vc.delegate = viewModel;
                            [controller.navigationController pushViewController:vc animated:NO];
                        }else{
                            
                            if ([offer gameID]) {
                                
                                [[NetworkManeger sharedManager] sendGetRequestToServerWithDictionary:@{} andAPICall:[NSString stringWithFormat:@"/games/%@",offer.gameID] withCallBack:^(BOOL success, NSDictionary *resault) {
                                    
                                    if (success) {
                                        
                                        DCircleViewController *vc = [DCircleViewController showCircleViewContrlllerWithModel:[[DCircleViewModel alloc] initWithParammetr:@{@"background":resault[@"data"][@"background"],@"image":resault[@"data"][@"image"],@"angle":resault[@"data"][@"angle"],@"pointer":resault[@"data"][@"pointer"],@"message":resault[@"data"][@"message"],@"label":resault[@"data"][@"label"],@"logo":resault[@"data"][@"logo"],@"id":resault[@"data"][@"id"]}]];
                                        vc.gemeID = offer.gameID;
                                        vc.hidesBottomBarWhenPushed = YES;
                                        [controller.navigationController pushViewController:vc animated:NO];
                                    }
                                }];
                            }else{
                                
                                [controller.navigationController pushViewController:[DSingleOfferViewController showSingleOfferWithViewModel:[DSingleOfferViewModel showSingleOffer:offer]] animated:YES];
                            }
                            
                        }
                    }
                }];
                
            } else if ([self.type isEqualToString:@"category"]){
                
                [viewModel.categoryArray enumerateObjectsUsingBlock:^(DCategoryModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                    if([self.categoryID isEqualToString:obj.categoryID]){
                        
                        [controller.navigationController pushViewController:[MVVMDProductsViewController showProductsWithViewModel:[DProductsVM showProductsOfCategory:obj]] animated:YES];
                    }
                }];
            } else if ([self.type isEqualToString:@"store"]){
                
                [DShopPreview getAllShopsWithCallBack:^(NSArray *array) {
                    
                    [array enumerateObjectsUsingBlock:^(DShopPreview* obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        
                        if ([obj isKindOfClass:[DShopPreview class]]) {
                            
                            if([self.shopID isEqualToString:[NSString stringWithFormat:@"%@",@(obj.shopID)]]){
                                
                                DShopModel *shop = [DShopModel new];
                                shop.shopID = obj.shopID;
                                shop.shopName = obj.shopName;
                                [controller.navigationController pushViewController:[MVVMDProductsViewController showProductsWithViewModel:[DProductsVM showProductsOfShop:shop]] animated:YES];
                            }
                        }
                    }];
                }];
            }
        }
    }];
}
@end
