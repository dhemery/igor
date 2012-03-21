
#import "Matcher.h"

@interface DescendantCombinatorMatcher : NSObject<Matcher>

@property(retain) id<Matcher> ancestorMatcher;
@property(retain) id<Matcher> descendantMatcher;

+(DescendantCombinatorMatcher*) withAncestorMatcher:(id<Matcher>)ancestorMatcher descendantMatcher:(id<Matcher>) descendantMatcher;

@end
