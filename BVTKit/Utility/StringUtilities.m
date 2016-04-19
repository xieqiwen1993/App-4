#import "StringUtilities.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>

#pragma mark - NSDictionary (Utilities)

@implementation NSDictionary (Utilities)

- (NSString *)JSONString
{
    NSError *error = nil;
    NSData *data = nil;
    NSString *str = nil;
    
    data = [NSJSONSerialization dataWithJSONObject:self options:kNilOptions error:&error];
    if (data != nil)
        str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    return str;
}

- (NSData *)JSONData
{
    NSError *error = nil;
    NSData *data = nil;
    
    data = [NSJSONSerialization dataWithJSONObject:self options:kNilOptions error:&error];
    
    return data;
}

@end




#pragma mark - NSArray (Utilities)

@implementation NSArray (Utilities)

- (NSString *)JSONString
{
    NSError *error = nil;
    NSData *data = nil;
    NSString *str = nil;

    data = [NSJSONSerialization dataWithJSONObject:self options:kNilOptions error:&error];
    if (data != nil)
        str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    return str;
}

- (NSData *)JSONData
{
    NSError *error = nil;
    NSData *data = nil;

    data = [NSJSONSerialization dataWithJSONObject:self options:kNilOptions error:&error];
    
    return data;
}

@end


#pragma mark - NSData (Utilities)

@implementation NSData (Utilities)

- (NSString *)HexString
{
    NSString *result = @"";
    const char *data = self.bytes;
    for (int i=0 ; i<[self length] ; i++)
    {
        int d = (int)data[i];
        result = [result stringByAppendingFormat:@"%x%x", (d>>4)&0xF, d&0xF];
    }
    
    return result;
}


- (NSString *)MD5String
{
	unsigned char result[CC_MD5_DIGEST_LENGTH];
	CC_MD5([self bytes], (unsigned int)[self length], result);
	
//	return [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
//			result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
//			result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]];
    
    NSMutableString *str = [[NSMutableString alloc] init];
    for (int i=0 ; i<CC_MD5_DIGEST_LENGTH ; i++)
        [str appendFormat:@"%02x", result[i]];
    
    return [NSString stringWithString:str];
}

- (NSString *)SHA1String
{
	unsigned char result[CC_SHA1_DIGEST_LENGTH];
	CC_SHA1([self bytes], (unsigned int)[self length], result);
	
    NSMutableString *str = [[NSMutableString alloc] init];
    for (int i=0 ; i<CC_SHA1_DIGEST_LENGTH ; i++)
        [str appendFormat:@"%02x", result[i]];
    
    return [NSString stringWithString:str];
}

- (id)JSONValue
{
    NSError *error = nil;
    id info = nil;

    info = [NSJSONSerialization JSONObjectWithData:self options:kNilOptions error:&error];
    
    return info;
}

@end




#pragma mark - NSString (Utilities)

@implementation NSString (Utilities)

- (NSString *)MD5String
{
	return [[self dataUsingEncoding:NSUTF8StringEncoding] MD5String];
}

- (NSString *)SHA1String
{
    return [[self dataUsingEncoding:NSUTF8StringEncoding] SHA1String];
}

- (NSString *)URLEncodedStringWithCFStringEncoding:(CFStringEncoding)encoding
{
	return (NSString *) CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)[self mutableCopy], NULL, CFSTR("￼=,!$&'()*+;@?\n\"<>#\t :/"), encoding));
}

- (NSString *)URLDecodedStringWithCFStringEncoding:(CFStringEncoding)decoding
{
    return (NSString *) CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault, (CFStringRef)[self mutableCopy], CFSTR(""), decoding));
}

- (NSString *)URLEncodedString
{
	return [self URLEncodedStringWithCFStringEncoding:kCFStringEncodingUTF8];
}

- (NSString *)URLDecodedString
{
    return [self URLDecodedStringWithCFStringEncoding:kCFStringEncodingUTF8];
}

- (id)JSONValue
{
    NSError *error = nil;
    
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    id info = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    if (error)
        NSLog(@"%@", error);
    
    return info;
}

+ (BOOL)isNilOrEmpty:(NSString *)string
{
    return string == nil || [string length] == 0;
}

@end
