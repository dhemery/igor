#import "InstanceMatcher.h"

@implementation InstanceMatcher

@synthesize simpleMatchers;

- (NSString *)description {
    return [NSString stringWithFormat:@"[Instance(%@)]", [self.simpleMatchers componentsJoinedByString:@","]];
}

- (InstanceMatcher *)initWithSimpleMatchers:(NSArray *)matchers {
    self = [super init];
    if (self) {
        simpleMatchers = matchers;
    }
    return self;
}

- (BOOL)matchesView:(UIView *)view inTree:(UIView *)root {
    for (id<SimpleMatcher> matcher in self.simpleMatchers) {
        if (![matcher matchesView:view]) return false;
    }
    return true;
}

+ (InstanceMatcher *)withSimpleMatchers:(NSArray *)matchers {
    return [[self alloc] initWithSimpleMatchers:matchers];
}
@end
