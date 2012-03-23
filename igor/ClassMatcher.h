#import "Matcher.h"

@interface ClassMatcher : Matcher

@property(retain,readonly) Class matchClass;

-(ClassMatcher*) initForClass:(Class)matchClass;

@end
