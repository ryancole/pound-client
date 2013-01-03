//
//  Utilities.m
//  pound-client
//
//  Created by Ryan Cole on 12/28/12.
//  Copyright (c) 2012 Ryan Cole. All rights reserved.
//

#import "Utilities.h"

@implementation Utilities

+ (Utilities *)sharedInstance {
    
    static Utilities *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        _sharedInstance = [[Utilities alloc] init];
        
    });
    
    return _sharedInstance;
    
}

+ (NSString *)relativeTime:(NSDate *)timestamp {
    
    // intiailize the calendar
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned int unitFlags =  NSYearCalendarUnit|NSMonthCalendarUnit|NSWeekCalendarUnit|NSWeekdayOrdinalCalendarUnit|NSWeekdayCalendarUnit|NSDayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit;
    NSDateComponents *messageDateComponents = [calendar components:unitFlags fromDate:timestamp];
    NSDateComponents *todayDateComponents = [calendar components:unitFlags fromDate:[NSDate date]];
    
    NSUInteger dayOfYearForMessage = [calendar ordinalityOfUnit:NSDayCalendarUnit inUnit:NSYearCalendarUnit forDate:timestamp];
    NSUInteger dayOfYearForToday = [calendar ordinalityOfUnit:NSDayCalendarUnit inUnit:NSYearCalendarUnit forDate:[NSDate date]];
    
    NSString *dateString;
    
    if ([messageDateComponents year] == [todayDateComponents year] &&
        [messageDateComponents month] == [todayDateComponents month] &&
        [messageDateComponents day] == [todayDateComponents day]) {
        
        dateString = [NSDateFormatter localizedStringFromDate:timestamp
                                                    dateStyle:NSDateFormatterNoStyle
                                                    timeStyle:NSDateFormatterShortStyle];
        
    } else if ([messageDateComponents year] == [todayDateComponents year] && dayOfYearForMessage == (dayOfYearForToday-1)) {
        
        dateString = [NSString stringWithFormat:@"Yesterday %@", [NSDateFormatter localizedStringFromDate:timestamp
                                                                                                dateStyle:NSDateFormatterNoStyle
                                                                                                timeStyle:NSDateFormatterShortStyle]];
        
    } else {
        
        dateString = [NSDateFormatter localizedStringFromDate:timestamp
                                                    dateStyle:NSDateFormatterShortStyle
                                                    timeStyle:NSDateFormatterShortStyle];
        
    }
    
    return dateString;
}

@end
