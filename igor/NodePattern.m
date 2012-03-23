#import "ClassPattern.h"
#import "NodeMatcher.h"
#import "NodePattern.h"
#import "PredicatePattern.h"
#import "PredicateMatcher.h"

@implementation NodePattern

- (NodeMatcher *)parse:(NSScanner *)scanner {
    ClassMatcher *classMatcher = [[ClassPattern new] parse:scanner];
    PredicateMatcher *predicateMatcher = [[PredicatePattern new] parse:scanner];
    return [NodeMatcher withClassMatcher:classMatcher predicateMatcher:predicateMatcher];
}

@end
