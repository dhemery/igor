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
    NSCharacterSet* asterisk;
    NSCharacterSet* letters;
}

-(IgorParser*)init {
    if(self = [super init]) {
        asterisk = [NSCharacterSet characterSetWithCharactersInString:@"*"];
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
    if([scanner scanCharactersFromSet:asterisk intoString:nil]) {
        selectorClass = [KindOfClassSelector class];
    }
    return [[selectorClass alloc] initWithTargetClass:targetClass];
}

-(id<Selector>) parsePropertySelector:(NSScanner*)scanner {
    NSCharacterSet* leftBracket = [NSCharacterSet characterSetWithCharactersInString:@"["];
    NSCharacterSet* rightBracket = [NSCharacterSet characterSetWithCharactersInString:@"]"];

    NSString* propertyName = [NSString string];
    if([scanner scanCharactersFromSet:leftBracket intoString:nil] &&
       [scanner scanCharactersFromSet:letters intoString:&propertyName] &&
       [scanner scanCharactersFromSet:rightBracket intoString:nil]) {
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
