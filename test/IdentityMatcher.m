#import "IdentityMatcher.h"

@implementation IdentityMatcher {
    UIView *matchView;
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

- (BOOL)matchesView:(UIView *)view withinTree:(UIView *)ignored {
    return matchView == view;
}
@end
