#import "KindOfClassMatcher.h"

@implementation KindOfClassMatcher

@synthesize matchClass;

- (NSString *)description {
    return [NSString stringWithFormat:@"[KindOfClass:%@]", self.matchClass];
}

+ (KindOfClassMatcher *)forBaseClass:(Class)baseClass {
    return [[self alloc] initForBaseClass:baseClass];
}

- (KindOfClassMatcher*)initForBaseClass:(Class)baseClass {
    if (self = [super init]) {
        matchClass = baseClass;
    }
    return self;
}

- (BOOL)matchesView:(UIView *)view {
    return [view isKindOfClass:self.matchClass];
}

@end
