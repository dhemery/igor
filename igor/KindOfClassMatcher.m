#import "KindOfClassMatcher.h"

@implementation KindOfClassMatcher

- (NSString *)description {
    return [NSString stringWithFormat:@"[KindOfClassMatcher:%@]", self.matchClass];
}

+ (KindOfClassMatcher *)forClass:(Class)targetClass {
    return (KindOfClassMatcher *) [[self alloc] initForClass:targetClass];
}

- (BOOL)matchesView:(UIView *)view {
    return [view isKindOfClass:self.matchClass];
}

@end
