//
//  NetworkManeger.h
//  Disconto
//
//  Created by user on 13.05.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkManeger : NSObject<UIAlertViewDelegate>
+ (id)sharedManager;

- (void)sendPostRequestToServerWithDictionary:(NSDictionary *)dictionary andAPICall:(NSString *)api withCallBack:(void (^)(BOOL success, NSDictionary *resault))callBack;
- (void)sendGetRequestToServerWithDictionary:(NSDictionary *)dictionary andAPICall:(NSString *)api withCallBack:(void (^)(BOOL success, NSDictionary *resault))callBack;
- (BOOL)responseValidate:(NSDictionary *)response;

- (void)sendPostRequestToURL:(NSString *)urlString dictionary:(NSDictionary *)dictionary  withCallBack:(void (^)(BOOL success, NSDictionary *resault))callBack;

- (void)sendNewGetRequestToServerWithCallBack:(void (^)(BOOL success, NSDictionary *resault))callBack;

- (void)sendNewGetRequestToServerWith:(NSString *)urlStr callBack:(void (^)(BOOL success, NSDictionary *resault))callBack;
@end
