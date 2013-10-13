#import "FalseMatcher.h"

@implementation FalseMatcher

- (NSString *)description {
    return @"{false}";
}
- (BOOL)matchesView:(UIView *)view {
    return NO;
}

@end