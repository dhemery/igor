#import "DEUniversalMatcher.h"


@implementation DEUniversalMatcher

- (NSString *)description {
    return @"*";
}

- (BOOL)matchesView:(id)ignoredView {
    return YES;
}

@end
