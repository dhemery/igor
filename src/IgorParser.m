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

-(id) parse:(NSString*)pattern {
    NSScanner* scanner = [NSScanner scannerWithString:pattern];

    id classMatcher = [[ClassPattern new] parse:scanner];
    id propertyMatcher = [[PropertyPattern new] parse:scanner];
    if(!propertyMatcher) {
        return classMatcher;
    }
    id compoundMatcher = [CompoundMatcher new];
    [compoundMatcher addMatcher:classMatcher];
    [compoundMatcher addMatcher:propertyMatcher];
    return compoundMatcher;
}

@end
