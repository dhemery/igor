#import "DEAccessibilityIdentifierMatcher.h"

@implementation DEAccessibilityIdentifierMatcher

@synthesize targetAccessibilityIdentifier;


- (NSString *)description {
    return [NSString stringWithFormat:@"#%@", self.targetAccessibilityIdentifier];
}


- (id <DEMatcher>)initWithAccessibilityIdentifier:(NSString *)accessibilityIdentifier {
    self = [super init];
    if (self) {
        targetAccessibilityIdentifier = accessibilityIdentifier;
    }
    return self;
}

+ (id <DEMatcher>)matcherWithAccessibilityIdentifier:(NSString *)identifier {
    return [[self alloc] initWithAccessibilityIdentifier:identifier];
}

- (BOOL)matchesView:(UIView *)view {
    return [self.targetAccessibilityIdentifier isEqualToString:view.accessibilityIdentifier];
}


@end
