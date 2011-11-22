//
//  PropertyParser.m
//  igor
//
//  Created by Dale Emery on 11/19/11.
//  Copyright (c) 2011 Dale H. Emery. All rights reserved.
//

#import "IgorParserException.h"
#import "PropertyPattern.h"
#import "PropertyExistsMatcher.h"
#import "PropertyValueEqualsMatcher.h"

@implementation PropertyPattern

-(NSObject*) parseValue:(NSScanner*)scanner {
    [scanner scanString:@"'" intoString:nil];
    NSString* value;
    [scanner scanCharactersFromSet:[NSCharacterSet letterCharacterSet] intoString:&value];
    [scanner scanString:@"'" intoString:nil];
    return value;
}

-(id<Matcher>) parse:(NSScanner*)scanner {
    NSString* propertyName = [NSString string];
    id<Matcher> selector = nil;
    if(![scanner scanString:@"[" intoString:nil]) return nil;
    if(![scanner scanCharactersFromSet:[NSCharacterSet letterCharacterSet] intoString:&propertyName]) {
        @throw [IgorParserException exceptionWithReason:@"Missing property name" scanner:scanner];
    }
    if([scanner scanString:@"]" intoString:nil]) {
        return [PropertyExistsMatcher forProperty:propertyName];
    }
    if([scanner scanString:@"=" intoString:nil]) {
        NSObject* desiredValue = [self parseValue:scanner];
        selector = [PropertyValueEqualsMatcher forProperty:propertyName value:desiredValue];
    }
    if(![scanner scanString:@"]" intoString:nil]) {
        @throw [IgorParserException exceptionWithReason:@"Missing ]" scanner:scanner];
    }
    return selector;
}

@end
