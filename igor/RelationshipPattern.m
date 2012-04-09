#import "RelationshipMatcher.h"
#import "InstancePattern.h"
#import "InstanceMatcher.h"
#import "RelationshipPattern.h"
#import "PatternScanner.h"

@implementation RelationshipPattern

+ (RelationshipPattern *)forScanner:(PatternScanner *)scanner {
    return (RelationshipPattern *) [[self alloc] initWithScanner:scanner];
}

- (id <SubjectMatcher>)parse {
    id <SubjectMatcher> matcher = [[InstancePattern forScanner:self.scanner] parse];
    while ([self.scanner skipWhiteSpace]) {
        InstanceMatcher *descendantMatcher = [[InstancePattern forScanner:self.scanner] parse];
        matcher = [RelationshipMatcher withSubjectMatcher:descendantMatcher ancestorMatcher:matcher];
    }
    return matcher;
}

@end
