#import "IgorQueryParser.h"
#import "InstanceChainParser.h"
#import "IgorQueryScanner.h"
#import "InstanceParser.h"
#import "ComplexMatcher.h"

@implementation IgorQueryParser

+ (id <SubjectMatcher>)parse:(IgorQueryScanner *)query {
    id <SubjectMatcher> matcher;
    if ([query skipString:@"$"]) {
        // First subject is marked.
        // Scan the subject.
        id<SubjectMatcher> subject = [InstanceParser parse:query];
        // Skip the combinator.
        [query skipWhiteSpace];
        // Scan the rest of the relationship.
        id<SubjectMatcher> tail = [InstanceChainParser parse:query];
        // Make a branch matcher.
        matcher = [ComplexMatcher withSubject:subject tail:tail];
    } else {
        // First subject is not marked.
        // As much of a relationship as we can.
        id<SubjectMatcher> head = [InstanceChainParser parse:query];
        if ([query skipString:@"$"]) {
            // A non-first subject is marked.
            // Scan the subject.
            id<SubjectMatcher> subject = [InstanceParser parse:query];
            if ([query skipWhiteSpace]) {
                // We have a combinator, so there's a branch.
                // Scan the rest of the relationship.
                id<SubjectMatcher> tail = [InstanceChainParser parse:query];
                matcher = ([ComplexMatcher withHead:head subject:subject tail:tail]);
            } else {
                // There's no combinator after the marked subject. So it's just a relationship.
                matcher = ([ComplexMatcher withHead:head subject:subject]);
            }
        } else {
            // No subject is marked.
            // Yield the relationship.
            matcher = head;
        }
    }
    [query failIfNotAtEnd];
    return matcher;
}

@end
