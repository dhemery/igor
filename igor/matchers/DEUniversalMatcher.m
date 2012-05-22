#import "DEUniversalMatcher.h"


@implementation DEUniversalMatcher

- (NSString *)description {
    return @"*";
}

- (BOOL)matchesView:(UIView *)ignoredView {
    return YES;
}

@end
