//
//  ClassParser.m
//  igor
//
//  Created by Dale Emery on 11/19/11.
//  Copyright (c) 2011 Dale H. Emery. All rights reserved.
//

#import "ClassSelector.h"
#import "ClassParser.h"
#import "KindOfClassSelector.h"
#import "ClassEqualsSelector.h"

@implementation ClassParser

-(ClassSelector*) parse:(NSScanner*)scanner {
    Class targetClass = [UIView class];
    Class selectorClass = [KindOfClassSelector class];
    
    NSString* className;
    if([scanner scanCharactersFromSet:[NSCharacterSet letterCharacterSet] intoString:&className]) {
        targetClass = NSClassFromString(className);
        selectorClass = [ClassEqualsSelector class];
    }
    if([scanner scanString:@"*" intoString:nil]) {
        selectorClass = [KindOfClassSelector class];
    }
    return [[selectorClass alloc] initWithTargetClass:targetClass];
}

@end
