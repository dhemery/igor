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
#import "SubjectTestMatcher.h"

@implementation IgorParser

@synthesize igor;

+(IgorParser*) forIgor:(Igor*)igor {
    return [[IgorParser alloc] initWithIgor:igor];
}

-(IgorParser*) initWithIgor:(Igor*)theIgor {
    if(self = [super init]) {
        igor = theIgor;
    }
    return self;
}

-(id<Matcher>) parse:(NSString*)pattern {
    NSScanner *scanner = [self scannerForPattern:pattern];
    id<Matcher> matcher = [self parseNode:scanner];
    matcher = [self parseDescendantCombinatorPatternWithAncestor:matcher scanner:scanner];
    if([scanner scanString:@"!" intoString:nil]) {
        matcher = [self parseSubjectTestMatcherForSubject:matcher scanner:scanner];
    }
    [self throwIfNotAtEndOfScanner:scanner];
    return matcher;
}

-(id<Matcher>) parseDescendantCombinatorPatternWithAncestor:(id<Matcher>)ancestor scanner:(NSScanner *)scanner {
    while([scanner scanCharactersFromSet:[NSCharacterSet whitespaceCharacterSet] intoString:nil]) {
        id<Matcher> descendantMatcher = [self parseNode:scanner];
        ancestor = [DescendantCombinatorMatcher forAncestorMatcher:ancestor descendantMatcher:descendantMatcher];
    }
    return ancestor;
}

-(id<Matcher>) parseNode:(NSScanner*) scanner {
    id classMatcher = [[ClassPattern new] parse:scanner];
    id predicateMatcher = [[PredicatePattern new] parse:scanner];
    if(predicateMatcher) {
        return [CompoundMatcher forClassMatcher:classMatcher predicateMatcher:predicateMatcher];
    }
    return classMatcher;
}

-(id<Matcher>) parseSubjectTestMatcherForSubject:(id)subjectMatcher scanner:(NSScanner*)scanner {
    id<Matcher> testMatcher = [self parseNode:scanner];
    testMatcher = [self parseDescendantCombinatorPatternWithAncestor:testMatcher scanner:scanner];
    if([scanner scanString:@"!" intoString:nil]) {
        testMatcher = [self parseSubjectTestMatcherForSubject:testMatcher scanner:scanner];
    }
    [self throwIfNotAtEndOfScanner:scanner];
    return [SubjectTestMatcher forSubject:subjectMatcher test:testMatcher];
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
