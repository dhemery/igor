//
//  PropertyParser.m
//  igor
//
//  Created by Dale Emery on 11/19/11.
//  Copyright (c) 2011 Dale H. Emery. All rights reserved.
//

#import "IgorParserException.h"
#import "PredicatePattern.h"
#import "PredicateMatcher.h"

@implementation PredicatePattern

-(id) parseValue:(NSScanner*)scanner {
    [scanner scanString:@"'" intoString:nil];
    NSString* value;
    [scanner scanCharactersFromSet:[NSCharacterSet letterCharacterSet] intoString:&value];
    [scanner scanString:@"'" intoString:nil];
    return value;
}

-(id) parse:(NSScanner*)scanner {
    NSString* expression = [NSString string];
    if(![scanner scanString:@"[" intoString:nil]) return nil;
    if(![scanner scanUpToString:@"]" intoString:&expression]) {
        @throw [IgorParserException exceptionWithReason:@"Expected predicate" scanner:scanner];
    }
    if(![scanner scanString:@"]" intoString:nil]) {
        @throw [IgorParserException exceptionWithReason:@"Expected ]" scanner:scanner];
    }
    return [PredicateMatcher forPredicateExpression:expression];
}

@end
