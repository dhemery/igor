
#import "DescendantCombinatorMatcher.h"
#import "NodePattern.h"
#import "SubjectPattern.h"

@implementation SubjectPattern

-(Matcher*) parse:(NSScanner *)scanner {
    Matcher* matcher = [[NodePattern alloc] parse:scanner];
    while([scanner scanCharactersFromSet:[NSCharacterSet whitespaceCharacterSet] intoString:nil]) {
        NodeMatcher* descendantMatcher = [[NodePattern alloc] parse:scanner];
        matcher = [DescendantCombinatorMatcher withAncestorMatcher:matcher descendantMatcher:descendantMatcher];
    }
    return matcher;
}

@end
