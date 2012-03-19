//
//  IgorParser.m
//  igor
//
//  Created by Dale Emery on 11/17/11.
//  Copyright (c) 2011 Dale H. Emery. All rights reserved.
//

#import "IgorParserException.h"
#import "IgorParser.h"
#import "CompoundMatcher.h"
#import "ClassPattern.h"
#import "PredicatePattern.h"
#import "DescendantCombinatorMatcher.h"

@implementation IgorParser

-(id) parseNode:(NSScanner*) scanner {
    id classMatcher = [[ClassPattern new] parse:scanner];
    id predicateMatcher = [[PredicatePattern new] parse:scanner];
    [scanner scanString:@"!" intoString:nil];
    if(predicateMatcher) {
        return [CompoundMatcher forClassMatcher:classMatcher predicateMatcher:predicateMatcher];
    }
    return classMatcher;
}

- (void)throwIfNotAtEndOfScanner:(NSScanner *)scanner {
    if(![scanner isAtEnd]) {
        NSString* badCharacters;
        [scanner scanUpToCharactersFromSet:[NSCharacterSet whitespaceCharacterSet] intoString:&badCharacters];
        NSString* reason = [NSString stringWithFormat:@"Unexpected characters %@", badCharacters];
        @throw [IgorParserException exceptionWithReason:reason scanner:scanner];
    }
}

- (NSScanner *)scannerForPattern:(NSString *)pattern {
    NSString* stripped = [pattern stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSScanner* scanner = [NSScanner scannerWithString:stripped];
    [scanner setCharactersToBeSkipped:nil];
    return scanner;
}

-(id) parse:(NSString*)pattern {
    NSScanner *scanner = [self scannerForPattern:pattern];

    id<Matcher> matcher = [self parseNode:scanner];
    while([scanner scanCharactersFromSet:[NSCharacterSet whitespaceCharacterSet] intoString:nil]) {
        id<Matcher> descendantMatcher = [self parseNode:scanner];
        matcher = [DescendantCombinatorMatcher forAncestorMatcher:matcher descendantMatcher:descendantMatcher];
    }
    [self throwIfNotAtEndOfScanner:scanner];
    return matcher;
}

@end
