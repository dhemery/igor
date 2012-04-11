#import "UniversalMatcher.h"


@implementation UniversalMatcher

- (NSString *)description {
    return @"[Universal]";
}

- (BOOL)matchesView:(UIView *)view {
    return YES;
}

- (BOOL)matchesView:(UIView *)ignoredView inTree:(UIView *)ignoredRoot {
    return YES;
}

@end
