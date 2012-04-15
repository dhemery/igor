#import "FalseMatcher.h"

@implementation FalseMatcher

- (NSString *)description {
    return @"{{false}}";
}
- (BOOL)matchesView:(UIView *)view {
    return NO;
}

- (BOOL)matchesView:(UIView *)view inTree:(UIView *)root {
    return NO;
}

@end