//
//  IgorParser.m
//  igor
//
//  Created by Dale Emery on 11/17/11.
//  Copyright (c) 2011 Dale H. Emery. All rights reserved.
//

#import "IgorParserException.h"
#import "IgorParser.h"
#import "SubjectPattern.h"
#import "SubjectSubtreeMatcher.h"

@implementation IgorParser

-(id<Matcher>) parse:(NSString*)pattern {
    NSScanner *scanner = [self scannerForPattern:pattern];
    id<Matcher> matcher = [self parseScanner:scanner];
    [self throwIfNotAtEndOfScanner:scanner];
    return matcher;
}

-(id<Matcher>) parseScanner:(NSScanner*)scanner {
    SubjectPattern* subjectParser = [SubjectPattern new];
    id<Matcher> matcher = [subjectParser parse:scanner];
    if([scanner scanString:@"!" intoString:nil]) {
        id<Matcher> subtreeMatcher = [subjectParser parse:scanner];
        matcher = [SubjectSubtreeMatcher withSubjectMatcher:matcher subtreeMatcher:subtreeMatcher];
    }
    return matcher;
}

-(NSScanner*) scannerForPattern:(NSString*)pattern {
    NSString* stripped = [pattern stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSScanner* scanner = [NSScanner scannerWithString:stripped];
    [scanner setCharactersToBeSkipped:nil];
    return scanner;
}

-(void) throwIfNotAtEndOfScanner:(NSScanner*)scanner {
    if(![scanner isAtEnd]) {
        NSString* badCharacters;
        [scanner scanUpToCharactersFromSet:[NSCharacterSet whitespaceCharacterSet] intoString:&badCharacters];
        NSString* reason = [NSString stringWithFormat:@"Unexpected characters %@", badCharacters];
        @throw [IgorParserException exceptionWithReason:reason scanner:scanner];
    }
}

@end
