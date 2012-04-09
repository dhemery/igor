#import "IgorQuery.h"
#import "RelationshipPattern.h"
#import "BranchMatcher.h"
#import "PatternScanner.h"

@implementation IgorQuery

+ (IgorQuery *)forPattern:(NSString *)pattern {
    return (IgorQuery *) [[self alloc] initWithScanner:[PatternScanner withPattern:pattern]];
}

- (id <SubjectMatcher>)parse {
    RelationshipPattern *subjectParser = [RelationshipPattern forScanner:self.scanner];
    id <SubjectMatcher> matcher = [subjectParser parse];
    if ([self.scanner skipString:@"!"]) {
        [self.scanner skipWhiteSpace];
        id <SubjectMatcher> descendantMatcher = [subjectParser parse];
        matcher = [BranchMatcher withSubjectMatcher:matcher descendantMatcher:descendantMatcher];
    }
    [self.scanner failIfNotAtEnd];
    return matcher;
}

@end
