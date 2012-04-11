#import "IdentityMatcher.h"

@implementation IdentityMatcher {
    UIView *matchView;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"[Identity:%@]", matchView];
}

+ (IdentityMatcher *)forView:(UIView *)view {
    return [[IdentityMatcher alloc] initForView:view];
}

- (IdentityMatcher *)initForView:(UIView *)view {
    if ((self = [super init])) {
        matchView = view;
    }
    return self;
}

- (BOOL)matchesView:(UIView *)view inTree:(UIView *)root {
    return matchView == view;
}
@end
