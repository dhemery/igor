#import "IdentifierMatcher.h"

@implementation IdentifierMatcher

@synthesize targetAccessibilityIdentifier;

- (NSString *)description {
    return [NSString stringWithFormat:@"#%@", self.targetAccessibilityIdentifier];
}


- (id <Matcher>)initWithAccessibilityIdentifier:(NSString *)accessibilityIdentifier {
    self = [super init];
    if (self) {
        targetAccessibilityIdentifier = accessibilityIdentifier;
    }
    return self;
}

+ (id <Matcher>)matcherWithAccessibilityIdentifier:(NSString *)identifier {
    return [[self alloc] initWithAccessibilityIdentifier:identifier];
}

- (BOOL)matchesView:(UIView *)view {
    return [self.targetAccessibilityIdentifier isEqualToString:view.accessibilityIdentifier];
}


@end