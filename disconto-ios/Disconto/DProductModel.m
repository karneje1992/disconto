//
//  DQuestModel.m
//  Disconto
//
//  Created by user on 24.03.16.
//  Copyright © 2016 StudioVision. All rights reserved.
//

#import "DProductModel.h"


@implementation DProductModel


-(BOOL) stringIsNumeric:(NSString *) str {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    NSNumber *number = [formatter numberFromString:str];
    return !!number; // If the string is not numeric, number will be nil
}

- (instancetype)initWithResponse:(NSDictionary *)response
{
    self = [super init];
    if (self) {
        
        self.quests = @[].mutableCopy;
        self.stores = @[].mutableCopy;
        NSMutableDictionary *dataDictionary = @{}.mutableCopy;
        
        [response enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
            if ([obj isKindOfClass:[NSString class]]) {
                
                NSAttributedString *attributedString = [HTMLAttributedString attributedStringWithHtml: (NSString *)obj andBodyFont:[UIFont fontWithName:@"Helvetica" size:12.0]];
                
                [dataDictionary setObject:attributedString.string forKey:key];
                
                
            } else {
                
                [dataDictionary setObject:obj forKey:key];
            }
            
        }];
        
        
        self.productCategory = [dataDictionary[@"category_id"] isEqual:[NSNull null]] ?  0 : [dataDictionary[@"category_id"] integerValue];
        self.descriptionProduct = dataDictionary[@"description"];
        self.favorite =  [dataDictionary[@"favorites"] isEqual:[NSNull null]] ? 0 : [dataDictionary[@"favorites"] boolValue];
        self.productID =  [dataDictionary[kID] isEqual:[NSNull null]] ? 0 : [dataDictionary[kID] integerValue];
        self.productImageURL = [NSURL URLWithString:dataDictionary[@"img_url"]];
        self.productName = dataDictionary[@"name"];
        self.productPoint = [dataDictionary[@"points"] isEqual:[NSNull null]] ? 0 : [dataDictionary[@"points"] floatValue];
        self.totalFavorites = [dataDictionary[@"total_favorites"] isEqual:[NSNull null]] ? 0 : [dataDictionary[@"total_favorites"] integerValue];
        self.legalDescription = [dataDictionary[@"legal_description"] isEqual:[NSNull null]] ? @"" : dataDictionary[@"legal_description"];
        self.unlocedCount = [self stringIsNumeric:dataDictionary[@"unlocked_count"]]?[dataDictionary[@"unlocked_count"] integerValue] : [dataDictionary[@"unlocked_count"] integerValue];
        
        self.fullDescription = [dataDictionary[@"full_description"] isEqual:[NSNull null]] ? @"" : dataDictionary[@"full_description"];
        self.status = [dataDictionary[@"total_favorites"] isEqual:[NSNull null]] ? 0 : [dataDictionary[@"status"] integerValue];
        self.expires = [self stringToDate:dataDictionary[@"expires_at"]];
        self.infinity = [[NSString stringWithFormat:@"%@",dataDictionary[@"unlocked_count"]] isEqualToString:[NSString stringWithFormat:@"unlimited"]];
        
        if (self.infinity) {
            
            self.unlocedCount = 9999;
        }
        self.step = [dataDictionary[@"step"] integerValue];
       
        for (NSDictionary *questDictionarty in dataDictionary[@"quests"]) {
            
            DQuestModel *quest =  [[DQuestModel alloc] initWithDictionary:questDictionarty];
           // quest.questImageURL ? [quest setQuestImageURL:quest.questImageURL] : [quest setQuestImageURL:self.productImageURL];
            
            if (!quest.complitedQuest) {
                [self.quests addObject:quest];
            }
            
        }
        
        for (NSDictionary *infoShop in dataDictionary[@"stores"]) {
            
            DShopModel *shop = [[DShopModel alloc] initWithResponsDictionary:infoShop];
            [self.stores addObject:shop];
        }
        
        
    }
    
    return self;
}

- (instancetype)initWithShortResponse:(NSDictionary *)shortResponse {
    self = [super init];
    if (self) {
        
        self.infinity = [[NSString stringWithFormat:@"%@",shortResponse[@"unlocked_count"]] isEqualToString:[NSString stringWithFormat:@"unlimited"]];
        self.unlocedCount = [self stringIsNumeric:shortResponse[@"unlocked_count"]]?[shortResponse[@"unlocked_count"] integerValue] : [shortResponse[@"unlocked_count"] integerValue];
        self.productCategory = [shortResponse[@"category_id"] integerValue];
        self.productID = [shortResponse[kID] integerValue];
        self.productImageURL = [NSURL URLWithString:shortResponse[@"img_url"]];
        self.productName = shortResponse[@"name"];
        self.productPoint = [shortResponse[@"points"] floatValue];
        self.status = [shortResponse[@"status"] integerValue];
        self.expires = [self stringToDate:shortResponse[@"expires_at"]];
        self.productID = [shortResponse[@"product_id"] integerValue];
        if (self.infinity) {
            
            self.unlocedCount = 9999;
        }
        self.step = [shortResponse[@"step"] integerValue];
    }
    return self;
}

- (NSString *)stringToDate:(NSString *)stringDate{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"ru_RU"];
    [dateFormatter setLocale:usLocale];
    // this is imporant - we set our input date format to match our input string
    // if format doesn't match you'll get nil from your string, so be careful
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *dateFromString = [[NSDate alloc] init];
    // voila!
    dateFromString = [dateFormatter dateFromString:stringDate];
    //    dateFormatter = [NSDateFormatter new];
    // NSTimeInterval diff = [dateFromString timeIntervalSinceDate:[NSDate date]];
    NSTimeInterval  tiNow = [dateFromString timeIntervalSinceReferenceDate];
    NSDate * newNow = [NSDate dateWithTimeIntervalSinceReferenceDate:tiNow];
    [dateFormatter setDateFormat:@"dd LLL yyyy"];
    NSString *str = [dateFormatter stringFromDate:newNow];
    
    return [NSString stringWithFormat:@"до %@",str];
}

+ (void)getNewAllProductsWithCollectionView:(UICollectionView *)colectionView skip:(NSInteger)skip category:(DCategoryModel *)category andCallBack:(void (^)(NSArray *array))callBack{
    
    NSMutableArray *array = @[].mutableCopy;
    
    NSString *strUrl = skip == 0 ? [NSString stringWithFormat:@"%@offers", APMSERVER] : [NSString stringWithFormat:@"%@offers/%ld",APMSERVER,(long)skip];
    
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_async(queue, ^{
    [[NetworkManeger sharedManager] sendNewGetRequestToServerWith: strUrl callBack:^(BOOL success, NSDictionary *resault) {
        
            if (success) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    if ([resault[kServerData] isKindOfClass:[NSDictionary class]]){
                        
                        [array addObject:[[DProductModel alloc] initWithResponse:resault[kServerData]]];
                    }else{
                        
                        for (NSDictionary *list in resault[kServerData]) {
                            
                            [array addObject:[[DProductModel alloc] initWithResponse:list]];
                        }
                        
                    }
                    
                    callBack(array);
                    
                });
            }

    }];
//    });
}

+ (void)getAllProductsWithCollectionView:(UICollectionView *)colectionView skip:(NSInteger)skip category:(DCategoryModel *)category andCallBack:(void (^)(NSArray *array))callBack{
    
    NSMutableArray *array = @[].mutableCopy;
    NSString *type = @"";
    
    if([category.categoryID isEqualToString:@"top"]){
        category.categoryID = @"0";
    }
    
    [[NetworkManeger sharedManager] sendGetRequestToServerWithDictionary:@{@"category_id":category.categoryID, @"skip":@(skip),kServerType:type} andAPICall:[NSString stringWithFormat:@"%@",apiProductForCategory] withCallBack:^(BOOL success, NSDictionary *resault) {
        
        if (success) {
            
            for (NSDictionary *list in resault[kServerData]) {
                
                [array addObject:[[DProductModel alloc] initWithResponse:list]];
            }
            callBack(array);
        }
    }];
}

- (DSelectProductCell *)getCelllWithProduct:(DProductModel *)product tableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{

    DSelectProductCell *cell = [DSelectProductCell getCellForTableView:tableView andClassCellString:NSStringFromClass([DSelectProductCell class])];
    [cell.productImage sd_setImageWithURL:product.productImageURL
                             placeholderImage:nil
                                    completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                        // [cell.progress setAlpha:0];
                                    }];
    cell.productLabel.text = product.productName;
    cell.unlocedCountLabel.text = [NSString stringWithFormat:@"%@",@(product.unlocedCount)];
    cell.stepperProduct.maximumValue = product.unlocedCount;
    [cell.unlocedCountLabel setText:[NSString stringWithFormat:@"%@",@(product.unlocedCount)]];
    cell.dateLabel.text = [NSString stringWithFormat:@"%@",product.expires];
    cell.priceLabel.text = [NSString stringWithFormat:@"%1.1f %@",product.productPoint,kRub];
    [cell.productImage sd_setImageWithURL:product.productImageURL];
    cell.unlocedCountLabel.clipsToBounds = YES;
    cell.unlocedCountLabel.layer.cornerRadius = 10;
    cell.product = self;
    cell.selectedLabel.text = [NSString stringWithFormat:@"%@",@(product.sectedCount * product.step)];
    [cell.selectedLabel setTextColor:product.sectedCount > 0 ? SYSTEM_COLOR : [UIColor lightGrayColor]];
    [cell.statusImage setAlpha:product.infinity];
    cell.statusImage.image = [UIImage imageNamed:@"infinity"];
    cell.layer.cornerRadius = cell.bounds.size.width*0.5;
    cell.statusImage.layer.cornerRadius = cell.statusImage.bounds.size.width*0.5;
    cell.statusImage.layer.borderWidth = 1;
    cell.statusImage.layer.borderColor = SYSTEM_COLOR.CGColor;
    [cell.statusImage setBackgroundColor:[UIColor whiteColor]];
    [cell.unlocedCountLabel setBackgroundColor:[UIColor whiteColor]];
    [cell.unlocedCountLabel setAlpha:!product.infinity];
    return cell;
}

- (DProductCollectionViewCell *)getCellsWithCollectionView:(UICollectionView *)collection indexPath:(NSIndexPath *)indexPath andProduct:(DProductModel *)product{
    
    DProductCollectionViewCell *cell = [DProductCollectionViewCell getCellForTableView:collection andClassCellString:NSStringFromClass([DProductCollectionViewCell class]) andIndexPath:indexPath];
    cell.productLabel.text = product.productName;
    [cell.productImageView sd_setImageWithURL:product.productImageURL
                             placeholderImage:nil
                                    completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                        // [cell.progress setAlpha:0];
                                    }];
    cell.priceLabel.text = [NSString stringWithFormat:@"%1.1f %@",product.productPoint,kRub];
    cell.dateLabel.text = product.expires;
    [cell.statusImage setAlpha:1];
    [cell.counterLabel setAlpha:1];
    cell.counterLabel.layer.cornerRadius = cell.counterLabel.bounds.size.width*0.5;
    cell.counterLabel.layer.borderColor = SYSTEM_COLOR.CGColor;
    cell.counterLabel.layer.borderWidth = 1;
    cell.statusImage.layer.cornerRadius = cell.statusImage.bounds.size.width*0.5;
    cell.statusImage.layer.borderWidth = 1;
    cell.statusImage.layer.borderColor = SYSTEM_COLOR.CGColor;
    if (product.status == 0) {
        
        [cell.counterLabel setAlpha:0];
        [cell.statusImage setImage:[UIImage imageNamed:@"task_lock_0"]];
        cell.statusImage.layer.cornerRadius = cell.statusImage.bounds.size.width*0.5;
    }else if (product.status == 4){
    
        [cell.counterLabel setAlpha:0];
        [cell.statusImage setAlpha:0];
    }
    
    else{
        
        if (product.infinity) {
            [cell.counterLabel setAlpha:0];
            [cell.statusImage setImage:[UIImage imageNamed:@"infinity"]];
            [cell.statusImage setAlpha:1];
            
        }else{
            [cell.counterLabel setAlpha:1];
            cell.counterLabel.layer.masksToBounds = YES;
            cell.counterLabel.layer.cornerRadius = cell.counterLabel.bounds.size.width*0.5;
            [cell.statusImage setAlpha:0];
            [cell.counterLabel setText:[NSString stringWithFormat:@"%@",@(product.unlocedCount)]];
            
        }
    }
    cell.layer.cornerRadius = 4;
    cell.statusImage.layer.cornerRadius = cell.statusImage.bounds.size.width*0.5;
    if (product.infinity) {
        
        cell.statusImage.image = [UIImage imageNamed:@"infinity"];
    }
    cell.counterLabel.layer.cornerRadius = cell.counterLabel.bounds.size.width*0.5;
    [cell.statusImage setBackgroundColor:[UIColor whiteColor]];
    [cell.counterLabel setBackgroundColor:[UIColor whiteColor]];
    return cell;
}

+ (void)updateProduct:(DProductModel *)product withCollBack:(void (^)(DProductModel *obj))callBack{
    
    [[NetworkManeger sharedManager] sendGetRequestToServerWithDictionary:@{} andAPICall:[NSString stringWithFormat:@"%@/%@",apiProduct,@(product.productID)] withCallBack:^(BOOL success, NSDictionary *resault) {
        
        if (success) {
            
            callBack([[DProductModel alloc] initWithResponse:resault]);
        }
    }];
}

+ (void)getUnloceadProductsWithProduct:(DProductModel *)product andShop:(DShopModel *)shop withCollBack:(void (^)(DProductModel *obj))callBack{
    
    [[NetworkManeger sharedManager] sendGetRequestToServerWithDictionary:@{@"product_id":@(product.productID), @"store_id":@(shop.shopID)} andAPICall:apiGetUnlocedProduct withCallBack:^(BOOL success, NSDictionary *resault) {
        
        if (success) {
            
            callBack([[DProductModel alloc] initWithResponse:resault]);
        }
    }];
}

+ (void)getFavoriteProductsWithCallBack:(void (^)(NSArray<DProductModel *> *array))callBack{
    
    NSMutableArray *array = @[].mutableCopy;
    [[NetworkManeger sharedManager] sendGetRequestToServerWithDictionary:@{} andAPICall:[NSString stringWithFormat:@"%@",apiProfileProducts] withCallBack:^(BOOL success, NSDictionary *resault) {
        
        if (success) {
            
            for (NSDictionary *list in resault[kServerData]) {
                
                [array addObject:[[DProductModel alloc] initWithResponse:list]];
            }
        }
        callBack(array);
    }];
}

- (void)getUnlocedProductsWithShop:(DShopModel *)shop callBack:(void (^)(NSArray<DProductModel *> *array))callBack{
    
    NSMutableArray *array = @[].mutableCopy;
    [[NetworkManeger sharedManager] sendGetRequestToServerWithDictionary:@{@"store_id":@(shop.shopID),@"select":@(YES),@"unlocked":@(YES)} andAPICall:[NSString stringWithFormat:@"%@",@"/products"] withCallBack:^(BOOL success, NSDictionary *resault) {
        
        if (success) {
            
            for (NSDictionary *list in resault[kServerData]) {
                
                DProductModel *item = [[DProductModel alloc] initWithResponse:list];
                if (item.status != 0) {
                    [array addObject:item];
                }
            }
        }
        callBack(array);
    }];
}

+ (void)getAllProductsWithSkip:(UICollectionView *)colectionView skip:(NSInteger)skip shopID:(NSInteger)shopID andCallBack:(void (^)(NSArray *))callBack{
    
    NSMutableArray *array = @[].mutableCopy;
    [[NetworkManeger sharedManager] sendGetRequestToServerWithDictionary:@{@"store_id":@(shopID),@"skip":@(skip)} andAPICall:[NSString stringWithFormat:@"%@",apiProductForCategory] withCallBack:^(BOOL success, NSDictionary *resault) {
        if (success) {
            
            for (NSDictionary *list in resault[kServerData]) {
                
                [array addObject:[[DProductModel alloc] initWithResponse:list]];
            }
        }
        callBack(array);
    }];
}

+ (void)getAllProductsWithCollectionView:(UICollectionView *)colectionView skip:(NSInteger)skip shopID:(NSInteger)shopID andCallBack:(void (^)(NSArray *))callBack{
    
    NSMutableArray *array = @[].mutableCopy;
    [[NetworkManeger sharedManager] sendGetRequestToServerWithDictionary:@{@"store_id":@(shopID),@"skip":@(skip)} andAPICall:[NSString stringWithFormat:@"%@",apiProductForCategory] withCallBack:^(BOOL success, NSDictionary *resault) {
        if (success) {
            
            for (NSDictionary *list in resault[kServerData]) {
                
                [array addObject:[[DProductModel alloc] initWithResponse:list]];
            }
        }
        callBack(array);
    }];
}

+ (BOOL)isNumber:(NSString *)string{
    if([string rangeOfCharacterFromSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]].location == NSNotFound) {
        return YES;
    }else {
        return NO;
    }
}

- (NSString *) stringByStrippingHTML {
    NSRange r;
    NSString *s = [self copy];
    while ((r = [s rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
        s = [s stringByReplacingCharactersInRange:r withString:@""];
    return s;
}

@end
