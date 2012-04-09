#import "SimpleMatcher.h"

@protocol ClassMatcher <SimpleMatcher>

@property(retain, readonly) Class matchClass;

@end
