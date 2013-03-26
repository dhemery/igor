#import "IsMemberOfClassMatcher.h"
#import "DEMemberOfClassMatcher.h"

@implementation IsMemberOfClassMatcher {
    Class targetClass;
}

+ (IsMemberOfClassMatcher *)forExactClass:(Class)exactClass {
    return [[self alloc] initWithExactClass:exactClass];
}

- (IsMemberOfClassMatcher *)initWithExactClass:(Class)exactClass {
    self = [super init];
    if (self) {
        targetClass = exactClass;
    }
    return self;
}

- (BOOL)matches:(id)item {
    if (![item isMemberOfClass:[DEMemberOfClassMatcher class]]) {
        return NO;
    }
    DEMemberOfClassMatcher *matcher = item;
    return targetClass == matcher.matchClass;
}

- (void)describeTo:(id <HCDescription>)description; {
    [description appendDescriptionOf:[DEMemberOfClassMatcher matcherForExactClass:targetClass]];
}

@end
