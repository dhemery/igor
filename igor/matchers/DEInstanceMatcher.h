#import "DEMatcher.h"

@interface DEInstanceMatcher : NSObject <DEMatcher>

@property(strong) NSArray *simpleMatchers;

+ (DEInstanceMatcher *)matcherWithSimpleMatchers:(NSArray *)simpleMatchers;

@end
