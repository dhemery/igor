#import "DescendantCombinatorMatcher.h"
#import "NodePattern.h"
#import "SubjectPattern.h"

@implementation SubjectPattern

- (Matcher *)parse:(NSScanner *)scanner {
    Matcher *matcher = [[NodePattern forScanner:scanner] parse];
    while ([scanner scanCharactersFromSet:[NSCharacterSet whitespaceCharacterSet] intoString:nil]) {
        NodeMatcher *descendantMatcher = [[NodePattern forScanner:scanner] parse];
        matcher = [DescendantCombinatorMatcher withAncestorMatcher:matcher descendantMatcher:descendantMatcher];
    }
    return matcher;
}

@end
