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
#import "PredicatePattern.h"
#import "DescendantCombinatorMatcher.h"

@implementation IgorParser

-(id) parseNode:(NSScanner*) scanner {
    id classMatcher = [[ClassPattern new] parse:scanner];
    id propertyMatcher = [[PredicatePattern new] parse:scanner];
    if(!propertyMatcher) {
        return classMatcher;
    }
    id compoundMatcher = [CompoundMatcher new];
    [compoundMatcher addMatcher:classMatcher];
    [compoundMatcher addMatcher:propertyMatcher];
    return compoundMatcher;
}

-(id) parse:(NSString*)pattern {
    NSString* stripped = [pattern stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSScanner* scanner = [NSScanner scannerWithString:stripped];

    id<Matcher> matcher = [self parseNode:scanner];
    while(![scanner isAtEnd]) {
        id<Matcher> ancestorMatcher = matcher;
        id<Matcher> descendantMatcher = [self parseNode:scanner];
        matcher = [DescendantCombinatorMatcher forAncestorMatcher:ancestorMatcher descendantMatcher:descendantMatcher];
    }
    return matcher;
}

@end
