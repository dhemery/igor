#import "DescendantCombinatorMatcher.h"
#import "NodePattern.h"
#import "NodeMatcher.h"
#import "SubjectPattern.h"
#import "PatternScanner.h"

@implementation SubjectPattern

+ (SubjectPattern *)forScanner:(PatternScanner *)scanner {
    return (SubjectPattern *)[[self alloc] initWithScanner:scanner];
}

- (id<RelationshipMatcher>)parse {
    id<RelationshipMatcher> matcher = [[NodePattern forScanner:self.scanner] parse];
    while ([self.scanner skipWhiteSpace]) {
        NodeMatcher *descendantMatcher = [[NodePattern forScanner:self.scanner] parse];
        matcher = [DescendantCombinatorMatcher withAncestorMatcher:matcher descendantMatcher:descendantMatcher];
    }
    return matcher;
}

@end
