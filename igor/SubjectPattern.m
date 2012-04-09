#import "SubjectAndAncestorMatcher.h"
#import "InstancePattern.h"
#import "InstanceMatcher.h"
#import "SubjectPattern.h"
#import "PatternScanner.h"

@implementation SubjectPattern

+ (SubjectPattern *)forScanner:(PatternScanner *)scanner {
    return (SubjectPattern *) [[self alloc] initWithScanner:scanner];
}

- (id <RelationshipMatcher>)parse {
    id <RelationshipMatcher> matcher = [[InstancePattern forScanner:self.scanner] parse];
    while ([self.scanner skipWhiteSpace]) {
        InstanceMatcher *descendantMatcher = [[InstancePattern forScanner:self.scanner] parse];
        matcher = [SubjectAndAncestorMatcher withSubjectMatcher:descendantMatcher ancestorMatcher:matcher];
    }
    return matcher;
}

@end
