#import "InstanceMatcher.h"

@implementation InstanceMatcher {
    NSArray *_simpleMatchers;
}

@synthesize simpleMatchers = _simpleMatchers;

- (NSString *)description {
    return [NSString stringWithFormat:@"[Instance:%@]", _simpleMatchers];
}

- (InstanceMatcher *)initWithSimpleMatchers:(NSArray *)simpleMatchers {
    self = [super init];
    if (self) {
        _simpleMatchers = simpleMatchers;
    }
    return self;
}

- (BOOL)matchesView:(UIView *)view inTree:(UIView *)root {
    for (id<SimpleMatcher> matcher in _simpleMatchers) {
        if (![matcher matchesView:view]) return false;
    }
    return true;
}

+ (InstanceMatcher *)withSimpleMatchers:(NSArray *)simpleMatchers {
    return [[self alloc] initWithSimpleMatchers:simpleMatchers];
}
@end
