//
//  IgorParser.m
//  igor
//
//  Created by Dale Emery on 11/17/11.
//  Copyright (c) 2011 Dale H. Emery. All rights reserved.
//

#import "IgorParser.h"
#import "CompoundSelector.h"
#import "ClassParser.h"
#import "PropertyParser.h"

@implementation IgorParser

-(id<Selector>) parse:(NSString*)selectorString {
    NSScanner* scanner = [NSScanner scannerWithString:selectorString];

    id<Selector> classSelector = [[ClassParser new] parse:scanner];
    id<Selector> propertySelector = [[PropertyParser new] parse:scanner];
    if(!propertySelector) {
        return classSelector;
    }
    CompoundSelector* compoundSelector = [CompoundSelector new];
    [compoundSelector addSelector:classSelector];
    [compoundSelector addSelector:propertySelector];
    return compoundSelector;
}

@end
