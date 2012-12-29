//
//  Utilities.m
//  pound-client
//
//  Created by Ryan Cole on 12/28/12.
//  Copyright (c) 2012 Ryan Cole. All rights reserved.
//

#import "Utilities.h"

@implementation Utilities

+ (NSString *)relativeTime:(NSDate *)timestamp
{
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
        
        dateString = @"Yesterday";
        
    } else if ([messageDateComponents year] == [todayDateComponents year] && dayOfYearForMessage > (dayOfYearForToday-6)) {
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"EEEE"];
        dateString = [dateFormatter stringFromDate:timestamp];
        
    } else {
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yy"];
        dateString = [NSString stringWithFormat:@"%02d/%02d/%@", [messageDateComponents day], [messageDateComponents month], [dateFormatter stringFromDate:timestamp]];
        
    }
    
    return dateString;
}

@end
