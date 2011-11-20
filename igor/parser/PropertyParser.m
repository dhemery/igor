//
//  PropertyParser.m
//  igor
//
//  Created by Dale Emery on 11/19/11.
//  Copyright (c) 2011 Dale H. Emery. All rights reserved.
//

#import "IgorParserException.h"
#import "PropertyParser.h"
#import "PropertyExistsSelector.h"
#import "PropertyValueEqualsSelector.h"

@implementation PropertyParser

-(NSObject*) parseValue:(NSScanner*)scanner {
    [scanner scanString:@"'" intoString:nil];
    NSString* value;
    [scanner scanCharactersFromSet:[NSCharacterSet letterCharacterSet] intoString:&value];
    [scanner scanString:@"'" intoString:nil];
    return value;
}

-(id<Selector>) parse:(NSScanner*)scanner {
    NSString* propertyName = [NSString string];
    id<Selector> selector = nil;
    if(![scanner scanString:@"[" intoString:nil]) return nil;
    if(![scanner scanCharactersFromSet:[NSCharacterSet letterCharacterSet] intoString:&propertyName]) {
        @throw [IgorParserException exceptionWithReason:@"Missing property name" scanner:scanner];
    }
    if([scanner scanString:@"]" intoString:nil]) {
        return [PropertyExistsSelector selectorWithPropertyName:propertyName];
    }
    if([scanner scanString:@"=" intoString:nil]) {
        NSObject* desiredValue = [self parseValue:scanner];
        selector = [PropertyValueEqualsSelector selectorWithPropertyName:propertyName value:desiredValue];
    }
    if(![scanner scanString:@"]" intoString:nil]) {
        @throw [IgorParserException exceptionWithReason:@"Missing ]" scanner:scanner];
    }
    return selector;
}

@end
