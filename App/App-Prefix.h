//
//  App-Prefix.h
//  App
//
//  Created by zhaoxm on 15/5/5.
//  Copyright (c) 2015年 yooli. All rights reserved.
//

#ifndef App_App_Prefix_h
#define App_App_Prefix_h

#ifdef DISTRIBUTION_MODE
#define NSLog(...){};
#endif

#import <Foundation/Foundation.h>
#import "UI.h"
#import "Defines.h"
#import "AppDelegate.h"

#define MAS_SHORTHAND

#endif
