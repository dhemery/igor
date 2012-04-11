#import "IsKindOfClassMatcher.h"
#import "KindOfClassMatcher.h"

#import <OCHamcrestIOS/HCDescription.h>

@implementation IsKindOfClassMatcher {
    Class _targetClass;
}

+ (id) forClass:(Class)targetClass {
    return [[self alloc] initWithClass:targetClass];
}

- (id) initWithClass:(Class)targetClass {
    if (self = [super init]) {
        _targetClass = targetClass;
    }
    return self;
}

- (BOOL) matches:(id)item {
    if (![item isMemberOfClass:[KindOfClassMatcher class]]) {
        return NO;
    }
    KindOfClassMatcher* matcher = item;
    return _targetClass == matcher.matchClass;
}

- (void) describeTo:(id<HCDescription>)description {
    [description appendDescriptionOf:[KindOfClassMatcher forClass:_targetClass]];
}

@end
