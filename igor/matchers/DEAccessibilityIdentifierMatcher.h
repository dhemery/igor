#import "DEMatcher.h"

@interface DEAccessibilityIdentifierMatcher : NSObject <DEMatcher>

@property(strong) NSString *targetAccessibilityIdentifier;

+ (id <DEMatcher>)matcherWithAccessibilityIdentifier:(NSString *)name;

@end
