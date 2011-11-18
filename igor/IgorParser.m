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

-(Class) parseTargetClass:(NSScanner*)scanner {
    NSString* className = [NSString string];
    if([scanner scanCharactersFromSet:letters intoString:&className]) {
        return NSClassFromString(className);
    } else {
        return [UIView class];
    }
}

-(ClassSelector*) parseClassSelector:(NSScanner*)scanner {
    Class targetClass = [self parseTargetClass:scanner];
        
    if([scanner scanCharactersFromSet:asterisk intoString:nil]) {
        return [[KindOfClassSelector alloc] initWithTargetClass:targetClass];
    } else {
        return [[ClassEqualsSelector alloc] initWithTargetClass:targetClass];
    }
}

-(id<Selector>) parseAttributeSelector:(NSScanner*)scanner {
    return nil;
}

-(id<Selector>) parse:(NSString*)selectorString {
    NSScanner* scanner = [NSScanner scannerWithString:selectorString];

    ClassSelector* classSelector = [self parseClassSelector:scanner];
    id<Selector> attributeSelector = [self parseAttributeSelector:scanner];
    if(!attributeSelector) {
        return classSelector;
    }
    CompoundSelector* compoundSelector = [CompoundSelector new];
    [compoundSelector addSelector:classSelector];
    [compoundSelector addSelector:attributeSelector];
    return compoundSelector;
}

@end
