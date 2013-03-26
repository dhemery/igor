#import "DEInstanceMatcher.h"

// TODO Test
@implementation DEInstanceMatcher

@synthesize simpleMatchers;

- (NSString *)description {
    return [NSString stringWithFormat:@"%@", [self.simpleMatchers componentsJoinedByString:@","]];
}

- (DEInstanceMatcher *)initWithSimpleMatchers:(NSArray *)matchers {
    self = [super init];
    if (self) {
        simpleMatchers = matchers;
    }
    return self;
}

- (BOOL)matchesView:(id)view {
    for (id <DEMatcher> matcher in self.simpleMatchers) {
        if (![matcher matchesView:view]) return false;
    }
    return true;
}

+ (DEInstanceMatcher *)matcherWithSimpleMatchers:(NSArray *)simpleMatchers {
    return [[self alloc] initWithSimpleMatchers:simpleMatchers];
}
@end
