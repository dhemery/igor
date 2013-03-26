#import "DEIdentifierMatcher.h"

@implementation DEIdentifierMatcher

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

- (BOOL)matchesView:(id)view {
    NSString *accessibilityIdentifier;
    #if TARGET_OS_IPHONE
    accessibilityIdentifier = [view accessibilityIdentifier];
    #else
    accessibilityIdentifier = [view identifier];
    #endif
    return [self.targetAccessibilityIdentifier isEqualToString:accessibilityIdentifier];
}


@end