#import "KindOfClassMatcher.h"

@implementation KindOfClassMatcher

@synthesize matchClass;

- (NSString *)description {
    return [NSString stringWithFormat:@"%@*", self.matchClass];
}

+ (KindOfClassMatcher *)matcherForBaseClass:(Class)baseClass {
    return [[self alloc] initForBaseClass:baseClass];
}

- (KindOfClassMatcher *)initForBaseClass:(Class)baseClass {
    self = [super init];
    if (self) {
        matchClass = baseClass;
    }
    return self;
}

- (BOOL)matchesView:(UIView *)view {
    return [view isKindOfClass:self.matchClass];
}

@end
