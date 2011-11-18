//
//  IgorParser.m
//  igor
//
//  Created by Dale Emery on 11/17/11.
//  Copyright (c) 2011 Dale H. Emery. All rights reserved.
//

#import "IgorParser.h"
#import "UniversalSelector.h"
#import "ClassEqualsSelector.h"
#import "KindOfClassSelector.h"

@implementation IgorParser
-(id<Selector>) parse:(NSString*)selectorString {
    NSCharacterSet* asterisk = [NSCharacterSet characterSetWithCharactersInString:@"*"];
    NSScanner* scanner = [NSScanner scannerWithString:selectorString];
    [scanner scanCharactersFromSet:[NSCharacterSet whitespaceAndNewlineCharacterSet] intoString:nil];
    if([scanner scanCharactersFromSet:asterisk intoString:nil]) {
        return [UniversalSelector new];
    }
    NSString* className = [NSString string];
    [scanner scanCharactersFromSet:[NSCharacterSet letterCharacterSet] intoString:&className];
    Class targetClass = NSClassFromString(className);
    if([scanner scanCharactersFromSet:asterisk intoString:nil]) {
        return [[KindOfClassSelector alloc] initWithTargetClass:targetClass];
    }
    return [[ClassEqualsSelector alloc] initWithTargetClass:targetClass];
}
@end
