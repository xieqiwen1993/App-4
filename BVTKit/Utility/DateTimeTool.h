//
//  DateTimeTool.h
//  Dragon
//
//  Created by Yooli on 12/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


#define A_SECOND (1)
#define A_MINITE (60)
#define AN_HOUR  (60*60)
#define A_DAY    (24*60*60)
#define A_MONTH  (30*24*60*60)
#define A_YEAR   (365*24*60*60)


typedef NS_ENUM(NSInteger, DateSeparatorStyle) {
    DateSeparatorStyleDot,   // .
    DateSeparatorStyleDash,  // -
    DateSeparatorStyleSpace, //
    DateSeparatorStyleWord,  // 年月日
};

@interface DateTimeTool : NSObject

+ (NSString *)StringTimestamp:(int64_t)timestamp defaultValue:(NSString *)defaultValue;
+ (NSString *)StringTimeRemain:(int64_t)duration space:(BOOL)space;
+ (NSString *)StringTimeRemainWithinOneDay:(int64_t)duration space:(BOOL)space;//一天以内用“XX小时XX分钟XX秒”格式输出，超过一天的以24小时计算
+ (NSString *)StringDateDay:(int64_t)timestamp;
+ (NSString *)StringDateDayDD:(int64_t)timestamp;

+ (NSString *)StringDateYMdhm:(int64_t)timestamp style:(DateSeparatorStyle)style;
+ (NSString *)StringDateYMd:(int64_t)timestamp style:(DateSeparatorStyle)style;
+ (NSString *)StringDateMd:(int64_t)timestamp style:(DateSeparatorStyle)style;

+ (NSString *)StringDateMMdd:(int64_t)timestamp style:(DateSeparatorStyle)style;

+ (NSUInteger)secondSinceAppStart;

+ (NSString *)StringDate:(int64_t)timestamp withDateFormat:(NSString *)format;

+ (NSString *)StringWeekDay:(int64_t)timestamp;

+ (NSDate *)dateFromStringYMD:(NSString *)dateString style:(DateSeparatorStyle)style;

@end
