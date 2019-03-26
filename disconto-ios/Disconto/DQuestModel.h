//
//  DQuestModel.h
//  Disconto
//
//  Created by user on 24.03.16.
//  Copyright © 2016 StudioVision. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DUserModel.h"

#import "DAnswerModel.h"
@interface DQuestModel : NSObject

@property BOOL complitedQuest;
@property NSInteger questID;
@property NSURL *questImageURL;
@property NSURL *questSiteURL;
@property NSInteger pointOfQuest;
@property NSInteger timeOutQuest;
@property NSString *title;
@property NSInteger questType;
@property NSURL *questVideoURL;
@property NSURL *questPrevieVideoImage;
@property NSString *questMessage;
@property NSURL *fbURL;
@property NSURL *vkURL;
@property NSURL *okURL;
@property NSMutableArray *answerArray;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
- (void)compliteWithProduct:(DProductModel *)product CollBack:(void (^)(DQuestModel *obj))callBack;
@end
