//
//  D DSharesModel.h
//  Disconto
//
//  Created by user on 19.08.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DSharesModel : NSObject

@property NSInteger sharesID;
@property NSURL *imgURL;
@property NSString *sharesName;
@property NSMutableArray *instructionArray;
@property BOOL unloced;
@property NSURL *rootURL;
@property NSString *type;
@property NSString *gameID;


+ (void)getFullItemsForCollectionViewWithCallBack:(void (^)(NSArray <DSharesModel *> *modelsArray))callBack;
+ (void)getFullItemsCuponsForCollectionViewWithUser:(DUserModel *)user withCallBack:(void (^)(NSArray <DSharesModel *> *modelsArray))callBack;
- (instancetype)initWithDictioary:(NSDictionary *)dictionary;
@end
