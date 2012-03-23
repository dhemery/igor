#import "Matcher.h"

@interface ClassMatcher : NSObject<Matcher>

@property(retain, readonly) Class matchClass;

- (ClassMatcher *)initForClass:(Class)matchClass;

@end
