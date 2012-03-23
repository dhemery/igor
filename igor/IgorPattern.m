#import "IgorPattern.h"
#import "SubjectPattern.h"
#import "SubjectSubtreeMatcher.h"
#import "PatternScanner.h"

@implementation IgorPattern

+ (IgorPattern *)forPattern:(NSString *)pattern {
    return (IgorPattern *)[[self alloc] initWithScanner:[PatternScanner withPattern:pattern]];
}

- (id<RelationshipMatcher>)parse {
    SubjectPattern *subjectParser = [SubjectPattern forScanner:self.scanner];
    id<RelationshipMatcher> matcher = [subjectParser parse];
    if ([self.scanner skipString:@"!"]) {
        [self.scanner skipWhiteSpace];
        id<RelationshipMatcher> subtreeMatcher = [subjectParser parse];
        matcher = [SubjectSubtreeMatcher withSubjectMatcher:matcher subtreeMatcher:subtreeMatcher];
    }
    [self.scanner failIfNotAtEnd];
    return matcher;
}

@end
