//
//  DAnswerModel.h
//  Disconto
//
//  Created by user on 25.03.16.
//  Copyright © 2016 StudioVision. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DAnswerModel : NSObject

@property NSInteger answerID;
@property NSString *answerText;
@property BOOL chack;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end
