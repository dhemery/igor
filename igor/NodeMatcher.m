#import "ClassMatcher.h"
#import "NodeMatcher.h"
#import "PredicateMatcher.h"

@implementation NodeMatcher

@synthesize classMatcher = _classMatcher;
@synthesize predicateMatcher = _predicateMatcher;


- (NSString *)description {
    return [NSString stringWithFormat:@"[NodeMatcher:%@%@]", _classMatcher, _predicateMatcher];
}

- (NodeMatcher *)initWithClassMatcher:(ClassMatcher *)classMatcher predicateMatcher:(PredicateMatcher *)predicateMatcher {
    self = [super init];
    if (self) {
        _classMatcher = classMatcher;
        _predicateMatcher = predicateMatcher;
    }
    return self;
}

- (BOOL)matchesView:(UIView *)view {
    return [_classMatcher matchesView:view] && [_predicateMatcher matchesView:view];
}

+ (NodeMatcher *)withClassMatcher:(ClassMatcher *)classMatcher predicateMatcher:(PredicateMatcher *)predicateMatcher {
    return [[self alloc] initWithClassMatcher:classMatcher predicateMatcher:predicateMatcher];
}

@end
