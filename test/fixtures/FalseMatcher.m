#import "FalseMatcher.h"

@implementation FalseMatcher

- (NSString *)description {
    return @"{false}";
}
- (BOOL)matchesView:(id)view {
    return NO;
}

@end