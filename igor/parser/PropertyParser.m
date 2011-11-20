//
//  PropertyParser.m
//  igor
//
//  Created by Dale Emery on 11/19/11.
//  Copyright (c) 2011 Dale H. Emery. All rights reserved.
//

#import "PropertyParser.h"
#import "PropertyExistsSelector.h"
#import "IgorParserException.h"

@implementation PropertyParser

-(id<Selector>) parse:(NSScanner*)scanner {
    NSString* propertyName = [NSString string];
    if(![scanner scanString:@"[" intoString:nil]) return nil;
    if(![scanner scanCharactersFromSet:[NSCharacterSet letterCharacterSet] intoString:&propertyName]) {
        @throw [IgorParserException exceptionWithReason:@"Missing property name" scanner:scanner];
    }
    if(![scanner scanString:@"]" intoString:nil]) {
        @throw [IgorParserException exceptionWithReason:@"Missing ]" scanner:scanner];
    }
    return [PropertyExistsSelector selectorWithPropertyName:propertyName];
}

@end
