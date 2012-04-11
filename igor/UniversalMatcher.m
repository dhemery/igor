#import "UniversalMatcher.h"


@implementation UniversalMatcher

- (BOOL)matchesView:(UIView *)view {
    return YES;
}

- (BOOL)matchesView:(UIView *)ignoredView inTree:(UIView *)ignoredRoot {
    return YES;
}

@end