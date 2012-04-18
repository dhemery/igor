#import "Matcher.h"

@interface InstanceMatcher : NSObject <Matcher>

@property(strong) NSArray *simpleMatchers;

+ (InstanceMatcher *)matcherWithSimpleMatchers:(NSArray *)simpleMatchers;

@end
