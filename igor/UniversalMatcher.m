#import "UniversalMatcher.h"


@implementation UniversalMatcher

- (NSString *)description {
    return @"*";
}

- (BOOL)matchesView:(UIView *)ignoredView {
    return [self matchesView:ignoredView inTree:nil];
}

- (BOOL)matchesView:(UIView *)ignoredView inTree:(UIView *)ignoredRoot {
    return YES;
}

@end
