#import "ClassPattern.h"
#import "NodeMatcher.h"
#import "NodePattern.h"
#import "PredicatePattern.h"
#import "PredicateMatcher.h"

@implementation NodePattern {
    NSScanner *_scanner;
}

- (NodePattern *)initWithScanner:(NSScanner *)scanner {
    self = [super init];
    if (self) {
        _scanner = scanner;
    }
    return self;
}

+ (NodePattern *)forScanner:(NSScanner *)scanner {
    return [[self alloc] initWithScanner:scanner];
}

- (NodeMatcher *)parse {
    ClassMatcher *classMatcher = [[ClassPattern new] parse:_scanner];
    PredicateMatcher *predicateMatcher = [[PredicatePattern new] parse:_scanner];
    return [NodeMatcher withClassMatcher:classMatcher predicateMatcher:predicateMatcher];
}

@end
