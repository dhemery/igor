#import "ClassMatcher.h"
#import "InstanceMatcher.h"

@implementation InstanceMatcher

@synthesize classMatcher = _classMatcher;
@synthesize predicateMatcher = _predicateMatcher;


- (NSString *)description {
    return [NSString stringWithFormat:@"[NodeMatcher:%@%@]", _classMatcher, _predicateMatcher];
}

- (InstanceMatcher *)initWithClassMatcher:(id<ClassMatcher>)classMatcher predicateMatcher:(id<SimpleMatcher>)predicateMatcher {
    self = [super init];
    if (self) {
        _classMatcher = classMatcher;
        _predicateMatcher = predicateMatcher;
    }
    return self;
}

- (BOOL)matchesView:(UIView *)view withinTree:(UIView *)ignored {
    return [_classMatcher matchesView:view] && [_predicateMatcher matchesView:view];
}

+ (InstanceMatcher *)withClassMatcher:(id<ClassMatcher>)classMatcher predicateMatcher:(id<SimpleMatcher>)predicateMatcher {
    return [[self alloc] initWithClassMatcher:classMatcher predicateMatcher:predicateMatcher];
}

@end
