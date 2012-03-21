
#import "Matcher.h"

@interface NodeMatcher : NSObject<Matcher>

@property(retain) NSMutableArray* simpleMatchers;

+(NodeMatcher*) withClassMatcher:(id<Matcher>)classmatcher predicateMatcher:(id<Matcher>)predicateMatcher;

@end
