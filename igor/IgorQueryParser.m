#import "IgorQueryParser.h"
#import "InstanceChainParser.h"
#import "IgorQueryScanner.h"
#import "InstanceParser.h"
#import "ComplexMatcher.h"
#import "UniversalMatcher.h"

@implementation IgorQueryParser

+ (id <SubjectMatcher>)complexMatcherFromMatchers:(NSMutableArray *)matchers {
    if ([matchers count] == 0) {
        return [UniversalMatcher new];
    }
    if ([matchers count] == 1) {
        return [matchers lastObject];
    }
    id<SubjectMatcher> matcher = [matchers objectAtIndex:0];
    for (NSUInteger i = 1 ; i < [matchers count] ; i++) {
        matcher = [ComplexMatcher withHead:matcher subject:[matchers objectAtIndex:i] ];
    }
    return matcher;
}

+ (id <SubjectMatcher>)parse:(IgorQueryScanner *)query {
    NSMutableArray* head = [NSMutableArray array];
    NSMutableArray* tail = [NSMutableArray array];
    id<SubjectMatcher> subject;

    [InstanceChainParser parse:query intoArray:head];
    if ([query skipString:@"$"]) {
        subject = [InstanceParser parse:query];
        NSLog(@"Found subject marker. Parsed subject %@", subject);
    } else {
        subject = [head lastObject];
        [head removeLastObject];
        NSLog(@"No subject marker. Stealing subject from head: %@", subject);
        NSLog(@"Head now contains %@", head);
    }
    if ([query skipWhiteSpace]) {
        NSLog(@"Found whitespace after subject. Parsing tail.");
        [InstanceChainParser parse:query intoArray:tail];
    }
    [query failIfNotAtEnd];
    return [ComplexMatcher withHead:[self complexMatcherFromMatchers:head] subject:subject tail:[self complexMatcherFromMatchers:tail]];
}

@end
