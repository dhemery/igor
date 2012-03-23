#import "IgorPattern.h"
#import "Matcher.h"
#import "SubjectPattern.h"
#import "SubjectSubtreeMatcher.h"
#import "PatternScanner.h"

@implementation IgorPattern

+ (IgorPattern *)forPattern:(NSString *)pattern {
    return (IgorPattern *)[[self alloc] initWithScanner:[PatternScanner withPattern:pattern]];
}

- (Matcher *)parse {
    SubjectPattern *subjectParser = [SubjectPattern forScanner:self.scanner];
    Matcher *matcher = [subjectParser parse];
    if ([self.scanner skipString:@"!"]) {
        Matcher *subtreeMatcher = [subjectParser parse];
        matcher = [SubjectSubtreeMatcher withSubjectMatcher:matcher subtreeMatcher:subtreeMatcher];
    }
    [self.scanner failIfNotAtEnd];
    return matcher;
}

@end
