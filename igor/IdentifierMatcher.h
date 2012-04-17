#import "Matcher.h"

@interface IdentifierMatcher : NSObject <Matcher>

@property(strong) NSString *targetAccessibilityIdentifier;

+ (id <Matcher>)matcherWithAccessibilityIdentifier:(NSString *)name;

@end