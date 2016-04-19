//
//  BaseModel.h
//  TXSLiCai
//
//  Created by huangkai on 15/11/3.
//  Copyright © 2015年 Arvin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject
-(void)setValue:(id)value forUndefinedKey:(NSString *)key;
-(id)valueForUndefinedKey:(NSString *)key;


@end
