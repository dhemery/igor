#import "IsKindOfClassMatcher.h"
#import "KindOfClassMatcher.h"

#import <OCHamcrestIOS/HCDescription.h>

@implementation IsKindOfClassMatcher {
    Class targetClass;
}

+ (id) forClass:(Class)baseClass {
    return [[self alloc] initWithClass:baseClass];
}

- (id) initWithClass:(Class)baseClass {
    if (self = [super init]) {
        targetClass = baseClass;
    }
    return self;
}

- (BOOL) matches:(id)item {
    if (![item isMemberOfClass:[KindOfClassMatcher class]]) {
        return NO;
    }
    KindOfClassMatcher* matcher = item;
    return targetClass == matcher.matchClass;
}

- (void) describeTo:(id<HCDescription>)description {
    [description appendDescriptionOf:[KindOfClassMatcher forBaseClass:targetClass]];
}

@end
