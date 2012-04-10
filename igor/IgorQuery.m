#import "IgorQuery.h"
#import "RelationshipPattern.h"
#import "BranchMatcher.h"
#import "PatternScanner.h"
#import "InstancePattern.h"
#import "InstanceMatcher.h"
#import "RelationshipMatcher.h"

@implementation IgorQuery

+ (IgorQuery *)forPattern:(NSString *)pattern {
    return (IgorQuery *) [[self alloc] initWithScanner:[PatternScanner withPattern:pattern]];
}

- (id <SubjectMatcher>)parse {
    RelationshipPattern *relationshipParser = [RelationshipPattern forScanner:self.scanner];
    id <SubjectMatcher> matcher;
    if ([self.scanner skipString:@"$"]) {
        // First subject is marked.
        // Scan the subject.
        id<SubjectMatcher> subject = [[InstancePattern forScanner:self.scanner] parse];
        // Skip the combinator.
        [self.scanner skipWhiteSpace];
        // Scan the rest of the relationship.
        id<SubjectMatcher> tail = [relationshipParser parse];
        // Make a branch matcher.
        matcher = [BranchMatcher withSubjectMatcher:subject descendantMatcher:tail];
    } else {
        // First subject is not marked.
        // As much of a relationship as we can.
        id<SubjectMatcher> head = [relationshipParser parse];
        if ([self.scanner skipString:@"$"]) {
            // A non-first subject is marked.
            // Scan the subject.
            id<SubjectMatcher> subject = [[InstancePattern forScanner:self.scanner] parse];
            if ([self.scanner skipWhiteSpace]) {
                // We have a combinator, so there's a branch.
                // Scan the rest of the relationship.
                id<SubjectMatcher> tail = [relationshipParser parse];
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
    [self.scanner failIfNotAtEnd];
    return matcher;
}

@end
