//
//  IgorParser.m
//  igor
//
//  Created by Dale Emery on 11/17/11.
//  Copyright (c) 2011 Dale H. Emery. All rights reserved.
//

#import "IgorParser.h"
#import "CompoundMatcher.h"
#import "ClassPattern.h"
#import "PropertyPattern.h"

@implementation IgorParser

-(id<Matcher>) parse:(NSString*)selectorString {
    NSScanner* scanner = [NSScanner scannerWithString:selectorString];

    id<Matcher> classSelector = [[ClassPattern new] parse:scanner];
    id<Matcher> propertySelector = [[PropertyPattern new] parse:scanner];
    if(!propertySelector) {
        return classSelector;
    }
    CompoundMatcher* compoundSelector = [CompoundMatcher new];
    [compoundSelector addMatcher:classSelector];
    [compoundSelector addMatcher:propertySelector];
    return compoundSelector;
}

@end
