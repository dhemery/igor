//
//  ViewFactory.h
//  igor
//
//  Created by Dale Emery on 3/20/12.
//  Copyright (c) 2012 Dale H. Emery. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ViewFactory : NSObject

+(UIButton*) button;
+(UIButton*) buttonWithAccessibilityHint:(NSString*)hint;
+(UIControl*) control;
+(UIView*) view;
+(UIWindow*) window;

@end
