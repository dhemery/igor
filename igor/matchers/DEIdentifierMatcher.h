#import "DEMatcher.h"

@interface DEIdentifierMatcher : NSObject <DEMatcher>

@property(strong) NSString *targetAccessibilityIdentifier;

+ (id <DEMatcher>)matcherWithAccessibilityIdentifier:(NSString *)name;

@end