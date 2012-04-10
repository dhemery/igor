#import "IgorQuery.h"
#import "RelationshipPattern.h"
#import "BranchMatcher.h"
#import "PatternScanner.h"
#import "InstancePattern.h"
#import "InstanceMatcher.h"

@implementation IgorQuery

+ (IgorQuery *)forPattern:(NSString *)pattern {
    return (IgorQuery *) [[self alloc] initWithScanner:[PatternScanner withPattern:pattern]];
}

- (id <SubjectMatcher>)parse {
    RelationshipPattern *relationshipParser = [RelationshipPattern forScanner:self.scanner];
    id <SubjectMatcher> matcher;
    if ([self.scanner skipString:@"$"]) {
        id<SubjectMatcher> subjectMatcher = [[InstancePattern forScanner:self.scanner] parse];
        [self.scanner skipWhiteSpace];
        id<SubjectMatcher> descendantMatcher = [relationshipParser parse];
        matcher = [BranchMatcher withSubjectMatcher:subjectMatcher descendantMatcher:descendantMatcher];
    } else {
        matcher = [relationshipParser parse];
    }
    [self.scanner failIfNotAtEnd];
    return matcher;
}

@end
