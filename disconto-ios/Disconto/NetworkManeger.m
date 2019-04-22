//
//  NetworkManeger.m
//  Disconto
//
//  Created by user on 13.05.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import "NetworkManeger.h"
#import "AFNetworking.h"
#import <sys/utsname.h>
 #import "SDVersion.h"

@interface NetworkManeger ()

@property NSString *lastUrl;
@property NSURLComponents *comps;
@end

@implementation NetworkManeger

+ (id)sharedManager {
    static NetworkManeger *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.lastUrl = @"";
    }
    return self;
}

- (void)sendPostRequestToURL:(NSString *)urlString dictionary:(NSDictionary *)dictionary  withCallBack:(void (^)(BOOL success, NSDictionary *resault))callBack{
    
   // SHOW_PROGRESS;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]
                                        initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", urlString]]];
        NSError *error;
        
        NSData *jsonData;
        
        NSMutableDictionary *dict = dictionary.mutableCopy;
        //    if (USER_IS_LOGINED) {
        //
//        if (TOKEN) {
//            [dict setObject:TOKEN forKey:@"UID"];
//        }
//
//        [dict setObject:DEVICEUUID forKey:@"token"];
        
        NSMutableArray<NSURLQueryItem *> *queryItems = @[].mutableCopy;
        
        [@{@"UID": TOKEN, @"token": DEVICEUUID} enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            
            [queryItems addObject:[[NSURLQueryItem alloc] initWithName:key value:obj]];
        }];
        
        self.comps = [NSURLComponents componentsWithURL:request.URL resolvingAgainstBaseURL:NO];
        [self.comps setQueryItems:queryItems];
        
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        
        jsonData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:&error];
        NSString *jsonString;
        if (! jsonData) {
            NSLog(@"Got an error: %@", error);
        } else {
            jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            
            NSMutableData *requestData = [NSMutableData dataWithBytes:[jsonString UTF8String] length:[jsonString lengthOfBytesUsingEncoding:NSUTF8StringEncoding]];
            
            [request setHTTPMethod:@"POST"];
            [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
            [request setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
            [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[requestData length]] forHTTPHeaderField:@"Content-Length"];
            
            NSMutableArray<NSURLQueryItem *> *queryItems = @[].mutableCopy;
            
            [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                
                [queryItems addObject:[[NSURLQueryItem alloc] initWithName:key value:obj]];
            }];

            
            
            [request setHTTPBody: requestData];
            
            
            
            [request setValue:[NSString stringWithFormat:@"ios/%@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]] forHTTPHeaderField:@"App-Version"];
            [request setValue:@"disconto-app" forHTTPHeaderField:@"X-APP"];
            [self getUserAgentRequest:request];
            
            NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
            
            configuration.requestCachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
            AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
            
            request.URL = self.comps.URL;
            
            [[manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                
                if ([self hederResponse:response]) {
                    
                    [[[UIAlertView alloc] initWithTitle:@"Доступна новая версия" message:@"" delegate:self cancelButtonTitle:@"Нет" otherButtonTitles:@"Загрузить", nil] show];
                    callBack(NO,@{});
                  //  RESTART;
                }
                
                if (!error) {
                    NSLog(@"Reply JSON: %@", responseObject);
                    
                    if ([responseObject isKindOfClass:[NSDictionary class]]) {
                        callBack([self responseValidate:responseObject],responseObject);
                    }
                    
                } else {
                    
                    
                    if (error.code == 400){
                        
                        SHOW_MESSAGE(nil, @"");
                        callBack(NO,@{});
                    }
                    
                    if (error.code < -1000 && error.code != -1011) {
                        
                        SHOW_MESSAGE(nil, @"Ошибка обработки запроса, возможны проблемы с интернетом");
                        callBack(NO,@{});
                        
                    }else{
                        
                        NSLog(@"Error: %@, %@, %@", error, response, responseObject);
                        callBack([self responseValidate:responseObject],responseObject);
                    }
                    
                }
                HIDE_PROGRESS;
            }] resume];
            
        }
        
    });
}

- (void)sendPostRequestToServerWithDictionary:(NSDictionary *)dictionary andAPICall:(NSString *)api withCallBack:(void (^)(BOOL success, NSDictionary *resault))callBack{
    
    SHOW_PROGRESS;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]
                                        initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SERVER,api]]];
        NSError *error;
        
        NSData *jsonData;
        
        NSMutableDictionary *dict = dictionary.mutableCopy;
        //    if (USER_IS_LOGINED) {
        //
        if (TOKEN) {
            [dict setObject:TOKEN forKey:@"UID"];
        }
        
        [dict setObject:DEVICEUUID forKey:@"token"];
        
        jsonData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:&error];
        NSString *jsonString;
        if (! jsonData) {
            NSLog(@"Got an error: %@", error);
        } else {
            jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            
            NSMutableData *requestData = [NSMutableData dataWithBytes:[jsonString UTF8String] length:[jsonString lengthOfBytesUsingEncoding:NSUTF8StringEncoding]];
            
            [request setHTTPMethod:@"POST"];
            [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
            [request setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
            [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[requestData length]] forHTTPHeaderField:@"Content-Length"];
            
            if ([api isEqualToString:apiLogin]) {

                NSMutableArray<NSURLQueryItem *> *queryItems = @[].mutableCopy;
                
                [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                   
                    [queryItems addObject:[[NSURLQueryItem alloc] initWithName:key value:obj]];
                }];

                self.comps = [NSURLComponents componentsWithURL:request.URL resolvingAgainstBaseURL:NO];
                [self.comps setQueryItems:queryItems];

                [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
                NSData *postData = [self.comps.URL.query dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
               [request setHTTPBody:postData];

            }else{
            
                [request setHTTPBody: requestData];
            }
            
            [request setValue:[NSString stringWithFormat:@"ios/%@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]] forHTTPHeaderField:@"App-Version"];
            [request setValue:@"disconto" forHTTPHeaderField:@"App"];
            [self getUserAgentRequest:request];
            
            NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
            
            configuration.requestCachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
            AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
            
            [[manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                
                if ([self hederResponse:response]) {
                    
                    [[[UIAlertView alloc] initWithTitle:@"Доступна новая версия" message:@"" delegate:self cancelButtonTitle:@"Нет" otherButtonTitles:@"Загрузить", nil] show];
                    callBack(NO,@{});
                    RESTART;
                }
                
                if (!error) {
                    NSLog(@"Reply JSON: %@", responseObject);
                    
                    if ([responseObject isKindOfClass:[NSDictionary class]]) {
                        callBack([self responseValidate:responseObject],responseObject);
                    }
                    
                } else {
                    
                    if (error.code < -1000 && !responseObject[@"status"]) {
                        
                        SHOW_MESSAGE(@"Ой! Что-то сломалось :(",
                                     @"Мы уже уведомлены об ошибке и работаем над исправлением.");
                        callBack(NO,@{});
                        
                    }else{
                        
                        NSLog(@"Error: %@, %@, %@", error, response, responseObject);
                        callBack([self responseValidate:responseObject],responseObject);
                    }
                    
                }
                HIDE_PROGRESS;
            }] resume];
            
        }

    });
}

- (void)sendNewGetRequestToServerWith:(NSString *)urlStr callBack:(void (^)(BOOL success, NSDictionary *resault))callBack{
    
    SHOW_PROGRESS;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString: urlStr]];
    [request setHTTPMethod:@"GET"];
    [request setValue:[NSString stringWithFormat:@"ios/%@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]] forHTTPHeaderField:@"App-Version"];
    [request setValue:@"disconto" forHTTPHeaderField:@"App"];

    NSMutableArray<NSURLQueryItem *> *queryItems = @[].mutableCopy;
    
    [@{@"UID": TOKEN, @"token": DEVICEUUID} enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:key value:obj]];
    }];
    
    self.comps = [NSURLComponents componentsWithURL:request.URL resolvingAgainstBaseURL:NO];
    [self.comps setQueryItems:queryItems];
    
    [request setValue:@"disconto-app" forHTTPHeaderField:@"X-APP"];
    
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    configuration.requestCachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    
    self.lastUrl = request.URL.absoluteString;
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    request.URL = self.comps.URL;
    
    [[manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if ([self hederResponse:response]) {
            
            [[[UIAlertView alloc] initWithTitle:@"Доступна новая версия" message:@"" delegate:self cancelButtonTitle:@"Нет" otherButtonTitles:@"Загрузить", nil] show];
            callBack(NO,@{@"update":@(YES)});
            
            RESTART;
        }
        
        if (!error) {
            NSLog(@"Reply JSON: %@", responseObject);
            
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                callBack([self responseValidate:responseObject],responseObject);
            }
        } else {
            
            if (error.code < -1000 && !responseObject[@"status"]) {
                
                SHOW_MESSAGE(@"Ой! Что-то сломалось :(",
                             @"Мы уже уведомлены об ошибке и работаем над исправлением.");
                callBack(NO,@{});
                
            }else{
                
                NSLog(@"Error: %@, %@, %@", error, response, responseObject);
                callBack([self responseValidate:responseObject],responseObject);
            }
            
        }
        HIDE_PROGRESS;
    }] resume];
    });
}

- (void)sendNewGetRequestToServerWithCallBack:(void (^)(BOOL success, NSDictionary *resault))callBack{
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString: [NSString stringWithFormat:@"%@offers", APMSERVER]]];
        [request setHTTPMethod:@"GET"];
        [request setValue:[NSString stringWithFormat:@"ios/%@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]] forHTTPHeaderField:@"App-Version"];
        [request setValue:@"disconto" forHTTPHeaderField:@"App"];
        [self getUserAgentRequest:request];
        
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        configuration.requestCachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
        
        self.lastUrl = request.URL.absoluteString;
        AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
        SHOW_PROGRESS;
        [[manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
            
            if ([self hederResponse:response]) {
                
                [[[UIAlertView alloc] initWithTitle:@"Доступна новая версия" message:@"" delegate:self cancelButtonTitle:@"Нет" otherButtonTitles:@"Загрузить", nil] show];
                callBack(NO,@{@"update":@(YES)});
                
                RESTART;
            }
            
            if (!error) {
                NSLog(@"Reply JSON: %@", responseObject);
                
                if ([responseObject isKindOfClass:[NSDictionary class]]) {
                    callBack([self responseValidate:responseObject],responseObject);
                }
            } else {
                
                if (error.code < -1000 && !responseObject[@"status"]) {
                    
                    SHOW_MESSAGE(@"Ой! Что-то сломалось :(",
                                 @"Мы уже уведомлены об ошибке и работаем над исправлением.");
                    callBack(NO,@{});
                    
                }else{
                    
                    NSLog(@"Error: %@, %@, %@", error, response, responseObject);
                    callBack([self responseValidate:responseObject],responseObject);
                }
                
            }
            HIDE_PROGRESS;
        }] resume];
    });
}

- (void)sendGetRequestToServerWithDictionary:(NSDictionary *)dictionary andAPICall:(NSString *)api withCallBack:(void (^)(BOOL success, NSDictionary *resault))callBack{
    
    SHOW_PROGRESS;
    
    
        NSMutableDictionary *dict = dictionary.mutableCopy;
        
        if (TOKEN) {
            [dict setObject:TOKEN forKey:@"UID"];
        }
        
        [dict setObject:DEVICEUUID forKey:@"token"];
        //  [dict setObject:[NSString stringWithFormat:@"ios/%@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]] forKey:@"appversion"];
        
        NSArray *keys = [dict allKeys];
        NSString *param = @"";
        for (NSString *str in keys) {
            param = [NSString stringWithFormat:@"%@&%@=%@",param,str,[dict objectForKey:str]];
        }
        if (param.length > 0) {
            param = [param substringFromIndex:1];
        }
        NSString *strinForRequest = [NSString stringWithFormat:@"%@%@?%@",SERVER,api,param];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:strinForRequest]];
        [request setHTTPMethod:@"GET"];
        [request setValue:[NSString stringWithFormat:@"ios/%@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]] forHTTPHeaderField:@"App-Version"];
        [request setValue:@"disconto" forHTTPHeaderField:@"App"];
        [self getUserAgentRequest:request];
    
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        configuration.requestCachePolicy = NSURLRequestReloadIgnoringLocalCacheData;

        self.lastUrl = request.URL.absoluteString;
        AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
        [[manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
            
            if ([self hederResponse:response]) {
                
                [[[UIAlertView alloc] initWithTitle:@"Доступна новая версия" message:@"" delegate:self cancelButtonTitle:@"Нет" otherButtonTitles:@"Загрузить", nil] show];
                callBack(NO,@{@"update":@(YES)});
                
                RESTART;
            }
            
            if (!error) {
                NSLog(@"Reply JSON: %@", responseObject);
                
                if ([responseObject isKindOfClass:[NSDictionary class]]) {
                    callBack([self responseValidate:responseObject],responseObject);
                }
            } else {
                
                if (error.code < -1000 && !responseObject[@"status"]) {
                    
                    SHOW_MESSAGE(@"Ой! Что-то сломалось :(",
                                 @"Мы уже уведомлены об ошибке и работаем над исправлением.");
                    callBack(NO,@{});
                    
                }else{
                    
                    NSLog(@"Error: %@, %@, %@", error, response, responseObject);
                    callBack([self responseValidate:responseObject],responseObject);
                }
                
            }
            HIDE_PROGRESS;
        }] resume];

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 0) {
        
        
    }else{
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/ru/app/diskonto/id1003256356?mt=8"]];
    }
}

- (void)getUserAgentRequest:(NSMutableURLRequest *)request{


    @try {
        NSString *string = @"";
        struct utsname systemInfo;
        uname(&systemInfo);
        
        string = [NSString stringWithFormat:@"disconto|version:%@|model:%@|os:%@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"],[SDVersion deviceNameString],[[UIDevice currentDevice] systemVersion]];
        [request setValue:string forHTTPHeaderField:@"User-Agent"];
        
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
    }

}

- (BOOL)hederResponse:(NSURLResponse *)headerResponse{

   __block BOOL result = NO;
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"update"]) {
        
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"update"];
    }
    NSDictionary* headers = [(NSHTTPURLResponse *)headerResponse allHeaderFields];
    [headers enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        if ([key isEqualToString:@"Disconto-Update"]) {
            result = [key isEqualToString:@"Disconto-Update"];
            [[NSUserDefaults standardUserDefaults] setObject:@(YES) forKey:@"update"];
            return ;
        }
        
    }];
    
    return result;
}

- (BOOL)responseValidate:(NSDictionary *)response{
    
   
    NSLog(@"%@",PUSH_TOKEN);
    
    if (response[@"userFacingMessage"]){
        
        SHOW_MESSAGE(nil, (NSString *)response[@"userFacingMessage"])
        return NO;
    }
    
    if (response[@"code"] ) {
        switch ([response[@"code"] integerValue]) {
                
            case 58:
                return NO;
            case 48:{
            
                SHOW_MESSAGE(@"Данный телефон уже используется", nil);
                return NO;
            }
                break;
            case 49:{
                SHOW_MESSAGE(socRegMailError, nil);
                return NO;
            }
                break;
            case 11:
            case 12:
            case 13:
            case 14:
            case -4:
            {
                SHOW_MESSAGE(@"Disconto", response[titleMessage]);
                if (14 == [response[@"code"] integerValue]) {
                    
                    //  SHOW_MESSAGE(@"Disconto", response[titleMessage]);
                }
                RESTART;
                [DSuperViewController logOut];
                return NO;
            }
            case 2004:{
                SHOW_MESSAGE(@"Disconto", @"Неправильный логин или пароль");
                return NO;
            }
                break;
                
            case 429:
            case -2:
            case -1:
                SHOW_MESSAGE(@"Ой! Что-то сломалось :(",
                             @"Мы уже уведомлены об ошибке и работаем над исправлением.");
                // RESTART;
                return NO;
            case 22:
                
            case 4006:
            case 2006:
            case 2002:
            {
                if ([response[titleMessage] isEqualToString:@"not-exists"]) {
                    return NO;
                }else if(response[titleMessage]){
                    
                    SHOW_MESSAGE(@"Disconto", response[titleMessage]);
                }
                
                return NO;
            }
            case 500 < 600:
                
                SHOW_MESSAGE(@"Ой! Что-то сломалось :(",
                             @"Мы уже уведомлены об ошибке и работаем над исправлением.");
                return NO;
            default:
                return YES;
        }
    }else if(response[titleMessage]){
    
        SHOW_MESSAGE(@"Disconto", response[titleMessage]);
        return NO;
    }else{
    
        return YES;
    }

    
}
@end

