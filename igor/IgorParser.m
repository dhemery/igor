//
//  IgorParser.m
//  igor
//
//  Created by Dale Emery on 11/17/11.
//  Copyright (c) 2011 Dale H. Emery. All rights reserved.
//

#import "IgorParser.h"
#import "ClassEqualsSelector.h"
#import "KindOfClassSelector.h"

@implementation IgorParser
-(id<Selector>) parse:(NSString*)selectorString {
    NSCharacterSet* asterisk = [NSCharacterSet characterSetWithCharactersInString:@"*"];
    NSCharacterSet* letters = [NSCharacterSet letterCharacterSet];
    NSCharacterSet* whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSScanner* scanner = [NSScanner scannerWithString:selectorString];

    [scanner scanCharactersFromSet:whitespace intoString:nil];

    Class targetClass;
    NSString* className = [NSString string];
    if([scanner scanCharactersFromSet:letters intoString:&className]) {
        targetClass = NSClassFromString(className);
    } else {
        targetClass = [UIView class];
    }

    if([scanner scanCharactersFromSet:asterisk intoString:nil]) {
        return [[KindOfClassSelector alloc] initWithTargetClass:targetClass];
    }
    return [[ClassEqualsSelector alloc] initWithTargetClass:targetClass];
}
@end
