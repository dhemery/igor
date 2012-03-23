
#import "ClassMatcher.h"

@implementation ClassMatcher

@synthesize matchClass = _matchClass;

-(ClassMatcher*) initForClass:(Class)matchClass {
    self = [super init];
    if (self) {
        _matchClass = matchClass;
    }
    return self;
}

@end