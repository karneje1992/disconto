//
//  ShareModel.m
//  Disconto
//
//  Created by Rostislav on 12/28/16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import "ShareModel.h"

@implementation ShareModel


- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        

        self.shareID = [NSString stringWithFormat:@"%@",@([dictionary[@"id"] longLongValue])];
        self.title = dictionary[@"name"];
        self.imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:dictionary[@"img_url"]]];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"ru_RU"];
        [dateFormatter setLocale:usLocale];
        // this is imporant - we set our input date format to match our input string
        // if format doesn't match you'll get nil from your string, so be careful
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        self.dateFrom = [dateFormatter dateFromString:dictionary[@"starts_at"]];
        self.dateTo = [dateFormatter dateFromString:dictionary[@"expires_at"]];
        NSString *to = [NSDateFormatter localizedStringFromDate:self.dateTo
                                                      dateStyle:NSDateFormatterShortStyle
                                                      timeStyle:NSDateFormatterNoStyle];
        NSString *text = [NSString stringWithFormat:@"%@ ",to];
        self.dateText = [NSString stringWithFormat:@"Конец акции: %@",text];
        self.fullDescription = dictionary[@"name"];
        
    }
    return self;
}

@end
