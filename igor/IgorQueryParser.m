#import "IgorQueryParser.h"
#import "RelationshipParser.h"
#import "BranchMatcher.h"
#import "IgorQueryScanner.h"
#import "InstanceParser.h"
#import "InstanceMatcher.h"
#import "RelationshipMatcher.h"

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
        id<SubjectMatcher> tail = [RelationshipParser parse:query];
        // Make a branch matcher.
        matcher = [BranchMatcher withSubjectMatcher:subject descendantMatcher:tail];
    } else {
        // First subject is not marked.
        // As much of a relationship as we can.
        id<SubjectMatcher> head = [RelationshipParser parse:query];
        if ([query skipString:@"$"]) {
            // A non-first subject is marked.
            // Scan the subject.
            id<SubjectMatcher> subject = [InstanceParser parse:query];
            if ([query skipWhiteSpace]) {
                // We have a combinator, so there's a branch.
                // Scan the rest of the relationship.
                id<SubjectMatcher> tail = [RelationshipParser parse:query];
                id<SubjectMatcher> branch = [BranchMatcher withSubjectMatcher:subject descendantMatcher:tail];
                id<SubjectMatcher> relationship = [RelationshipMatcher withSubjectMatcher:branch ancestorMatcher:head];
                matcher = relationship ;
            } else {
                // There's no combinator after the marked subject. So it's just a relationship.
                id<SubjectMatcher> relationship = [RelationshipMatcher withSubjectMatcher:subject ancestorMatcher:head];
                matcher = relationship ;
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
