#import "DescendantCombinatorMatcher.h"
#import "NodePattern.h"
#import "SubjectPattern.h"

@implementation SubjectPattern

+ (SubjectPattern *)forScanner:(NSScanner *)scanner {
    return (SubjectPattern *)[[self alloc] initWithScanner:scanner];
}

- (Matcher *)parse {
    Matcher *matcher = [[NodePattern forScanner:self.scanner] parse];
    while ([self.scanner scanCharactersFromSet:[NSCharacterSet whitespaceCharacterSet] intoString:nil]) {
        NodeMatcher *descendantMatcher = [[NodePattern forScanner:self.scanner] parse];
        matcher = [DescendantCombinatorMatcher withAncestorMatcher:matcher descendantMatcher:descendantMatcher];
    }
    return matcher;
}

@end
