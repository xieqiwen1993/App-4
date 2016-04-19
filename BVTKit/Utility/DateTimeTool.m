//
//  DateTimeTool.m
//  Dragon
//
//  Created by Yooli on 12/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DateTimeTool.h"
#include <stdio.h>
#include <sys/timeb.h>

@implementation DateTimeTool

+ (NSString *)StringTimestamp:(int64_t)timestamp defaultValue:(NSString *)defaultValue
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];
    int64_t secondsFromDateToNow = ([date timeIntervalSinceNow]);
    if (secondsFromDateToNow > 0)
        secondsFromDateToNow = 0;
    secondsFromDateToNow = llabs(secondsFromDateToNow);
    
    if (secondsFromDateToNow <= 0)
        return defaultValue;
    else if (secondsFromDateToNow < A_MINITE)
        return [NSString stringWithFormat:@"%llu%@", secondsFromDateToNow, NSLocalizedString(@"秒前", @"")];
    else if (secondsFromDateToNow < AN_HOUR)
        return [NSString stringWithFormat:@"%llu%@", secondsFromDateToNow/A_MINITE, NSLocalizedString(@"分钟前", @"")];
    else if (secondsFromDateToNow < A_DAY)
        return [NSString stringWithFormat:@"%llu%@", secondsFromDateToNow/AN_HOUR, NSLocalizedString(@"小时前", @"")];
    else
        return [DateTimeTool StringDateYMd:timestamp style:DateSeparatorStyleDot];
}

+ (NSString *)StringTimeRemain:(int64_t)duration space:(BOOL)space
{
    if (duration < 0)
    {
        return NSLocalizedString(@"未知", @"");
    }
    
    if (duration == 0)
    {
        return space ? @"-- : -- : --" : @"--:--:--";
    }
    
    NSMutableString *durationDisplay = [[NSMutableString alloc] init];
    if (duration >= A_DAY)
    {
        int days  = (int)duration/A_DAY;
        if (space)
            [durationDisplay appendFormat:@"%d%@ ", days, NSLocalizedString(@"天", @"")];
        else
            [durationDisplay appendFormat:@"%d%@", days, NSLocalizedString(@"天", @"")];
    }
    
    int timeRemain = (duration%A_DAY);
    if (space)
        [durationDisplay appendFormat:@"%02d : %02d : %02d", timeRemain/AN_HOUR, (timeRemain%AN_HOUR)/A_MINITE, (timeRemain%AN_HOUR)%A_MINITE];
    else
        [durationDisplay appendFormat:@"%02d:%02d:%02d", timeRemain/AN_HOUR, (timeRemain%AN_HOUR)/A_MINITE, (timeRemain%AN_HOUR)%A_MINITE];
    
    return [NSString stringWithString:durationDisplay];
}

+ (NSString *)StringTimeRemainWithinOneDay:(int64_t)duration space:(BOOL)space
{
    duration = MIN(duration,A_DAY);
    if (duration < 0)
    {
        return NSLocalizedString(@"未知", @"");
    }
    
    if (duration == 0)
    {
        return space ? @"-- : -- : --" : @"--:--:--";
    }
    
    NSMutableString *durationDisplay = [[NSMutableString alloc] init];
    
    int timeRemain = (int)duration;
    
    NSString *_space = @"";
    if (space)
    {
        _space = @" ";
    }
    if (timeRemain/AN_HOUR != 0) {
        [durationDisplay appendString:[NSString stringWithFormat:@"%02d小时%@",timeRemain/AN_HOUR,_space]];
    }
    [durationDisplay appendString:[NSString stringWithFormat:@"%02d分%@",(timeRemain%AN_HOUR)/A_MINITE,_space]];
    [durationDisplay appendString:[NSString stringWithFormat:@"%02d秒",(timeRemain%AN_HOUR)%A_MINITE]];
    
    return [NSString stringWithString:durationDisplay];
}

+ (NSUInteger)TodayOfWeek
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    [gregorian setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8*AN_HOUR]];
    NSDateComponents *weekdayComponents = [gregorian components:NSWeekdayCalendarUnit fromDate:[NSDate date]];
    return weekdayComponents.weekday-1;
}

+ (NSString *)StringDateDayDD:(int64_t)timestamp
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8*AN_HOUR]];
    [dateFormatter setDateFormat:@"dd"];
    
    NSString *ret = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:timestamp]];
    
    return ret;
}

+ (NSString *)StringDateDay:(int64_t)timestamp
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8*AN_HOUR]];
    [dateFormatter setDateFormat:@"d"];
    
    NSString *ret = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:timestamp]];
    
    return ret;
}

+ (NSString *)StringDateYMdhm:(int64_t)timestamp style:(DateSeparatorStyle)style
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8*AN_HOUR]];
    switch (style)
    {
        case DateSeparatorStyleDash:
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
            break;
        case DateSeparatorStyleSpace:
            [dateFormatter setDateFormat:@"yyyy MM dd HH:mm"];
            break;
        case DateSeparatorStyleWord:
            [dateFormatter setDateFormat:@"yyyy年MM月dd日 HH:mm"];
            break;
        case DateSeparatorStyleDot:
        default:
            [dateFormatter setDateFormat:@"yyyy.MM.dd HH:mm"];
            break;
    }
    
    NSString *ret = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:timestamp]];
    
    return ret;
}

+ (NSString *)StringDateYMd:(int64_t)timestamp style:(DateSeparatorStyle)style
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8*AN_HOUR]];
    switch (style)
    {
        case DateSeparatorStyleDash:
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            break;
        case DateSeparatorStyleSpace:
            [dateFormatter setDateFormat:@"yyyy MM dd"];
            break;
        case DateSeparatorStyleWord:
            [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
            break;
        case DateSeparatorStyleDot:
        default:
            [dateFormatter setDateFormat:@"yyyy.MM.dd"];
            break;
    }
    
    NSString *ret = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:timestamp]];
    
    return ret;
}

+ (NSString *)StringDateMd:(int64_t)timestamp style:(DateSeparatorStyle)style
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8*AN_HOUR]];
    switch (style)
    {
        case DateSeparatorStyleDash:
            [dateFormatter setDateFormat:@"M-d"];
            break;
        case DateSeparatorStyleSpace:
            [dateFormatter setDateFormat:@"M d"];
            break;
        case DateSeparatorStyleWord:
            [dateFormatter setDateFormat:@"M月d日"];
            break;
        case DateSeparatorStyleDot:
        default:
            [dateFormatter setDateFormat:@"M.d"];
            break;
    }
    
    NSString *ret = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:timestamp]];

    
    return ret;
}

+ (NSString *)StringDateMMdd:(int64_t)timestamp style:(DateSeparatorStyle)style
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8*AN_HOUR]];
    switch (style)
    {
        case DateSeparatorStyleDash:
            [dateFormatter setDateFormat:@"MM-dd"];
            break;
        case DateSeparatorStyleSpace:
            [dateFormatter setDateFormat:@"MM dd"];
            break;
        case DateSeparatorStyleWord:
            [dateFormatter setDateFormat:@"MM月dd日"];
            break;
        case DateSeparatorStyleDot:
        default:
            [dateFormatter setDateFormat:@"MM.dd"];
            break;
    }
    
    NSString *ret = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:timestamp]];
    
    
    return ret;
}

+ (NSUInteger)secondSinceAppStart
{
//    clock_t t = clock();
//    NSLog(@"%lu", t/100000);
//    NSLog(@"%f", [NSProcessInfo processInfo].systemUptime);
//    return t/100000;
    return (NSUInteger)[NSProcessInfo processInfo].systemUptime;
}

+ (NSString *)StringTermUnit:(NSInteger)unit
{
    if (unit == 0x00)
        return NSLocalizedString(@"年", @"");
    if (unit == 0x01)
        return NSLocalizedString(@"季", @"");
    if (unit == 0x02)
        return NSLocalizedString(@"个月", @"");
    if (unit == 0x04)
        return NSLocalizedString(@"周", @"");
    if (unit == 0x08)
        return NSLocalizedString(@"日", @"");
    if (unit == 0x0A)
        return NSLocalizedString(@"工作日", @"");
    
    return @"";
}

+ (NSString *)StringDate:(int64_t)timestamp withDateFormat:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
    [dateFormatter setDateFormat:format];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];
    NSString *str = [dateFormatter stringFromDate:date];
    return str;
}

+ (NSString *)StringWeekDay:(int64_t)timestamp
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    [gregorian setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8*AN_HOUR]];
    NSDateComponents *weekdayComponents = [gregorian components:NSWeekdayCalendarUnit fromDate:date];
   
    switch (weekdayComponents.weekday)
    {
        case 1:
            return NSLocalizedString(@"星期日", @"");
            break;
        case 2:
            return NSLocalizedString(@"星期一", @"");
            break;
        case 3:
            return NSLocalizedString(@"星期二", @"");
            break;
        case 4:
            return NSLocalizedString(@"星期三", @"");
            break;
        case 5:
            return NSLocalizedString(@"星期四", @"");
            break;
        case 6:
            return NSLocalizedString(@"星期五", @"");
            break;
        case 7:
            return NSLocalizedString(@"星期六", @"");
            break;
        default:
            break;
    }
    return nil;
}

+ (NSDate *)dateFromStringYMD:(NSString *)dateString style:(DateSeparatorStyle)style
{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	switch (style)
	{
		case DateSeparatorStyleDash:
			[dateFormatter setDateFormat:@"yyyy-MM-dd"];
			break;
		case DateSeparatorStyleSpace:
			[dateFormatter setDateFormat:@"yyyy MM dd"];
			break;
		case DateSeparatorStyleWord:
			[dateFormatter setDateFormat:@"yyyy年MM月dd日"];
			break;
		case DateSeparatorStyleDot:
		default:
			[dateFormatter setDateFormat:@"yyyy.MM.dd"];
			break;
	}
	NSDate *date = [dateFormatter dateFromString:dateString];
	return date;
}

@end
