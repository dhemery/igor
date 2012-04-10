#import "ClassMatcher.h"
#import "InstanceMatcher.h"

@implementation InstanceMatcher {
    NSMutableArray *_simpleMatchers;
}

@synthesize simpleMatchers = _simpleMatchers;

- (NSString *)description {
    return [NSString stringWithFormat:@"[Instance:%@]", _simpleMatchers];
}

- (InstanceMatcher *)initWithSimpleMatchers:(NSMutableArray *)simpleMatchers {
    self = [super init];
    if (self) {
        _simpleMatchers = simpleMatchers;
    }
    return self;
}

- (BOOL)matchesView:(UIView *)view withinTree:(UIView *)ignored {
    for (id<SimpleMatcher> matcher in _simpleMatchers) {
        if (![matcher matchesView:view]) return false;
    }
    return true;
}

+ (InstanceMatcher *)withSimpleMatchers:(NSMutableArray *)simpleMatchers {
    return [[self alloc] initWithSimpleMatchers:simpleMatchers];
}
@end
