//
//  StringUtilities.h
//  ReApp
//
//  Created by Zhai Yuxuan on 11-6-14.
//  Copyright 2011年 Broventure Technologies, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSDictionary (Utilities)

- (NSString *)JSONString;
- (NSData *)JSONData;

@end


@interface NSArray (Utilities)

- (NSString *)JSONString;
- (NSData *)JSONData;

@end


@interface NSData (Utilities)

- (id)JSONValue;
- (NSString *)HexString;
- (NSString *)MD5String;
- (NSString *)SHA1String;

@end


@interface NSString (Utilities)

- (NSString *)MD5String;
- (NSString *)SHA1String;
- (NSString *)URLEncodedString;
- (NSString *)URLDecodedString;
- (id)JSONValue;
+ (BOOL)isNilOrEmpty:(NSString *)string;

@end

