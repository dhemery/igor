#import "UniversalMatcher.h"


@implementation UniversalMatcher

- (NSString *)description {
    return @"*";
}

- (BOOL)matchesView:(UIView *)ignoredView {
    return YES;
}

@end
