//
//  ClassParser.m
//  igor
//
//  Created by Dale Emery on 11/19/11.
//  Copyright (c) 2011 Dale H. Emery. All rights reserved.
//

#import "ClassMatcher.h"
#import "ClassPattern.h"
#import "KindOfClassMatcher.h"
#import "MemberOfClassMatcher.h"

@implementation ClassPattern

-(ClassMatcher*) parse:(NSScanner*)scanner {
    Class targetClass = [UIView class];
    Class selectorClass = [KindOfClassMatcher class];
    
    NSString* className;
    if([scanner scanCharactersFromSet:[NSCharacterSet letterCharacterSet] intoString:&className]) {
        targetClass = NSClassFromString(className);
        selectorClass = [MemberOfClassMatcher class];
    }
    if([scanner scanString:@"*" intoString:nil]) {
        selectorClass = [KindOfClassMatcher class];
    }
    return [[selectorClass alloc] initWithTargetClass:targetClass];
}

@end
