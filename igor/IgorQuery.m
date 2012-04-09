#import "IgorQuery.h"
#import "RelationshipPattern.h"
#import "SubjectAndDescendantMatcher.h"
#import "PatternScanner.h"

@implementation IgorQuery

+ (IgorQuery *)forPattern:(NSString *)pattern {
    return (IgorQuery *) [[self alloc] initWithScanner:[PatternScanner withPattern:pattern]];
}

- (id <RelationshipMatcher>)parse {
    RelationshipPattern *subjectParser = [RelationshipPattern forScanner:self.scanner];
    id <RelationshipMatcher> matcher = [subjectParser parse];
    if ([self.scanner skipString:@"!"]) {
        [self.scanner skipWhiteSpace];
        id <RelationshipMatcher> descendantMatcher = [subjectParser parse];
        matcher = [SubjectAndDescendantMatcher withSubjectMatcher:matcher descendantMatcher:descendantMatcher];
    }
    [self.scanner failIfNotAtEnd];
    return matcher;
}

@end
