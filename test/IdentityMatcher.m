#import "IdentityMatcher.h"

@implementation IdentityMatcher {
    UIView *_matchView;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"[Identity:%@]", _matchView];
}

+ (IdentityMatcher *)forView:(UIView *)view {
    return [[IdentityMatcher alloc] initForView:view];
}

- (IdentityMatcher *)initForView:(UIView *)view {
    if ((self = [super init])) {
        _matchView = view;
    }
    return self;
}

- (BOOL)matchesView:(UIView *)view inTree:(UIView *)root {
    return _matchView == view;
}
@end
