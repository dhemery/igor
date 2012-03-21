
#import "ClassPattern.h"
#import "NodeMatcher.h"
#import "NodePattern.h"
#import "PredicatePattern.h"

@implementation NodePattern

-(id<Matcher>) parse:(NSScanner*)scanner {
    id classMatcher = [[ClassPattern new] parse:scanner];
    id predicateMatcher = [[PredicatePattern new] parse:scanner];
    if(predicateMatcher) {
        return [NodeMatcher withClassMatcher:classMatcher predicateMatcher:predicateMatcher];
    }
    return classMatcher;
}

@end
