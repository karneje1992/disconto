//
//  DQuestModel.m
//  Disconto
//
//  Created by user on 24.03.16.
//  Copyright © 2016 StudioVision. All rights reserved.
//

#import "DQuestModel.h"

@implementation DQuestModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.questID = [dictionary[kID] integerValue];
        self.answerArray = @[].mutableCopy;
        self.questType = [dictionary[kServerType] integerValue];
        self.timeOutQuest = [dictionary[@"timeout"] integerValue];
        self.pointOfQuest = [dictionary[@"points"] integerValue];
       // self.questImageURL = [NS]
        //dictionary[@"q_image"] ? [NSURL URLWithString:dictionary[@"q_image"]] : [NSURL URLWithString:dictionary[@"data3"]];
        self.questSiteURL = [NSURL URLWithString:dictionary[@"page_url_vk"]] ? [NSURL URLWithString:dictionary[@"page_url_vk"]]: [NSURL URLWithString:dictionary[@"page_url"]];
        switch ([dictionary[kServerType] integerValue]) {
            case video:
                self.title = @"Просмотреть видео";
                break;
            case fact:
                self.title = @"Прочитать факт";
                break;
            case question:
                self.title = @"Ответить на вопрос";
                break;
            case visit:
                self.title = @"Посетить сайт";
                break;
            case share:
                self.title = @"Поделится в соц сетях";
                break;
            default:
                break;
        }
        _fbURL = [[NSURL URLWithString:dictionary[@"page_url_fb"]] isEqual:[NSNull null]] ? [NSURL URLWithString:@"https://disconto.me"] : [NSURL URLWithString:dictionary[@"page_url_fb"]];
        _vkURL = [[NSURL URLWithString:dictionary[@"page_url_vk"]]  isEqual:[NSNull null]] ? [NSURL URLWithString:@"https://disconto.me"] : [NSURL URLWithString:dictionary[@"page_url_vk"]];
        if (dictionary[@"page_url_ok"]) {
            
            if (dictionary[@"page_url_ok"] == (NSString *)[NSNull null]) {
                
                _okURL = [NSURL URLWithString:@"https://disconto.me"];
            }else{
            
                _okURL = [NSURL URLWithString:dictionary[@"page_url_ok"]];
            }
        }
        _okURL =  dictionary[@"page_url_ok"] == (NSString *)[NSNull null] ?
        nil :
        [NSURL URLWithString:dictionary[@"page_url_ok"]];
        self.questPrevieVideoImage = [[NSURL URLWithString:dictionary[@"preview_image"]] isEqual:[NSNull null]] ? nil : [NSURL URLWithString:dictionary[@"preview_image"]];
        self.questMessage = dictionary[titleMessage] ? dictionary[titleMessage] : dictionary[kServerData];
        self.complitedQuest = [dictionary[@"completed"] boolValue];
        for (NSDictionary *answerInfo in dictionary[@"answers"]) {
            [self.answerArray addObject:[[DAnswerModel alloc] initWithDictionary:answerInfo]];
        }
        [self convertQuest:self andList:dictionary];
//        if (self.questType == fact && self.questMessage.length < 3) {
//            
//            self.questType = visit;
//            self.questSiteURL = self.questImageURL;
//        }
    }
    return self;
}

- (void)compliteWithProduct:(DProductModel *)product CollBack:(void (^)(DQuestModel *obj))callBack{

    NSInteger answerID = -1;
    for (DAnswerModel * answer in self.answerArray) {
        if (answer.chack) {
            
            answerID = answer.answerID;
        }
    }
    
    [[NetworkManeger sharedManager] sendPostRequestToServerWithDictionary:@{@"answer":@(answerID)} andAPICall:[NSString stringWithFormat:@"%@/%@/%@",apiQuestComplit,@(self.questID),@(product.productID)] withCallBack:^(BOOL success, NSDictionary *resault) {
        
        if (success) {
            
            callBack([product.quests firstObject]);
        }else{
        
            callBack(nil);
        }
    }];
}

- (void)convertQuest:(DQuestModel *)quest andList:(NSDictionary *)list{
    
    quest.questMessage = list[kServerData];
    if ([list[@"data2"] isEqual:[NSNull null]]) {
        
    }else{
        quest.questImageURL = [NSURL URLWithString:list[@"data2"]];
        
    }
    switch (quest.questType) {
        case fact:{
            
            quest.questImageURL = [NSURL URLWithString:![list[@"data2"] isEqual:[NSNull null]]?list[@"data2"]:@""];
        }
            break;
        case video:{
        
            quest.questVideoURL = [NSURL URLWithString:![list[@"data2"] isEqual:[NSNull null]]?list[@"data2"]:[NSURL new]];
            
        }
            
            break;
        case visit:
            
            quest.questSiteURL = [NSURL URLWithString:![list[@"data2"] isEqual:[NSNull null]]?list[@"data2"]:[NSURL new]];
            break;
        case share:
            
            break;
        case question:
            
            quest.questMessage = list[kServerData];
            if (list[@"data3"]) {
                quest.questImageURL = [NSURL URLWithString:![list[@"data3"] isEqual:[NSNull null]]?list[@"data3"]:[NSURL new]];
            }
            
            
            break;
        default:
            break;
    }
}
@end
