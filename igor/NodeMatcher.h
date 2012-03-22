
#import "Matcher.h"

@interface NodeMatcher : NSObject<Matcher>

@property(retain) NSMutableArray* simpleMatchers;

+(NodeMatcher*) withClassMatcher:(id<Matcher>)classMatcher predicateMatcher:(id<Matcher>)predicateMatcher;

@end
