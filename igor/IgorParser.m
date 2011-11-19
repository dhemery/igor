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
#import "CompoundSelector.h"
#import "PropertyExistsSelector.h"

@implementation IgorParser {
    NSCharacterSet* letters;
}

-(IgorParser*)init {
    if(self = [super init]) {
        letters = [NSCharacterSet letterCharacterSet];
    }
    return self;
}

-(ClassSelector*) parseClassSelector:(NSScanner*)scanner {
    Class targetClass = [UIView class];
    Class selectorClass = [KindOfClassSelector class];
    
    NSString* className;
    if([scanner scanCharactersFromSet:letters intoString:&className]) {
        targetClass = NSClassFromString(className);
        selectorClass = [ClassEqualsSelector class];
    }
    if([scanner scanString:@"*" intoString:nil]) {
        selectorClass = [KindOfClassSelector class];
    }
    return [[selectorClass alloc] initWithTargetClass:targetClass];
}

-(id<Selector>) parsePropertySelector:(NSScanner*)scanner {
    NSString* propertyName = [NSString string];
    if([scanner scanString:@"[" intoString:nil] &&
       [scanner scanCharactersFromSet:letters intoString:&propertyName] &&
       [scanner scanString:@"]" intoString:nil]) {
        return [PropertyExistsSelector selectorWithPropertyName:propertyName];
    }
    return nil;
}

-(id<Selector>) parse:(NSString*)selectorString {
    NSScanner* scanner = [NSScanner scannerWithString:selectorString];

    id<Selector> classSelector = [self parseClassSelector:scanner];
    id<Selector> propertySelector = [self parsePropertySelector:scanner];
    if(!propertySelector) {
        return classSelector;
    }
    CompoundSelector* compoundSelector = [CompoundSelector new];
    [compoundSelector addSelector:classSelector];
    [compoundSelector addSelector:propertySelector];
    return compoundSelector;
}

@end
