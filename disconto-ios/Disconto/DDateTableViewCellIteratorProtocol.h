//
//  DDateTableViewCellIteratorProtocol.h
//  Disconto
//
//  Created by Rostislav on 7/3/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

@protocol DDateTableViewCellIteratorProtocol <NSObject>

- (void)setDayValue:(NSString *)day;
- (void)setMonthValue:(NSString *)month;
- (void)setYearValue:(NSString *)year;
- (NSString *)getDay;
- (NSString *)getMonth;
- (NSString *)getYear;

@end
