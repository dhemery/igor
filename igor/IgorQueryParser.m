#import "IgorQueryParser.h"
#import "InstanceChainParser.h"
#import "IgorQueryStringScanner.h"
#import "InstanceParser.h"
#import "ComplexMatcher.h"
#import "UniversalMatcher.h"

@implementation IgorQueryParser

+ (id <SubjectMatcher>)subjectMatcherFromMatcherChain:(NSArray *)matcherChain {
    if ([matcherChain count] == 0) {
        return [UniversalMatcher new];
    }
    if ([matcherChain count] == 1) {
        return [matcherChain lastObject];
    }
    id<SubjectMatcher> matcher = [matcherChain objectAtIndex:0];
    for (NSUInteger i = 1 ; i < [matcherChain count] ; i++) {
        matcher = [ComplexMatcher withHead:matcher subject:[matcherChain objectAtIndex:i] ];
    }
    return matcher;
}

+ (id <SubjectMatcher>)matcherFromQuery:(id<IgorQueryScanner>)query {
    NSMutableArray* head = [NSMutableArray array];
    NSMutableArray* tail = [NSMutableArray array];
    id<SubjectMatcher> subject;

    [InstanceChainParser collectInstanceMatchersFromQuery:query intoArray:head];
    if ([query skipString:@"$"]) {
        subject = [InstanceParser instanceMatcherFromQuery:query];
        NSLog(@"Found subject marker. Parsed subject %@", subject);
    } else {
        subject = [head lastObject];
        [head removeLastObject];
        NSLog(@"No subject marker. Stealing subject from head: %@", subject);
        NSLog(@"Head now contains %@", head);
    }
    if ([query skipWhiteSpace]) {
        NSLog(@"Found whitespace after subject. Parsing tail.");
        [InstanceChainParser collectInstanceMatchersFromQuery:query intoArray:tail];
    }
    [query failIfNotAtEnd];
    return [ComplexMatcher withHead:[self subjectMatcherFromMatcherChain:head] subject:subject tail:[self subjectMatcherFromMatcherChain:tail]];
}

@end
