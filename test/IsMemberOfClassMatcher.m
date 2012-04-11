#import "IsMemberOfClassMatcher.h"
#import "MemberOfClassMatcher.h"

#import <OCHamcrestIOS/HCDescription.h>

@implementation IsMemberOfClassMatcher {
    Class _targetClass;
}

+ (id) forClass:(Class)targetClass {
    return [[self alloc] initWithClass:targetClass];
}

- (id) initWithClass:(Class)targetClass {    ;
    if (self = [super init]) {
        _targetClass = targetClass;
    }
    return self;
}

- (BOOL) matches:(id)item {
    if (![item isMemberOfClass:[MemberOfClassMatcher class]]) {
        return NO;
    }
    MemberOfClassMatcher* matcher = item;
    return _targetClass == matcher.matchClass;
}

- (void) describeTo:(id<HCDescription>)description; {
    [description appendDescriptionOf:[MemberOfClassMatcher forClass:_targetClass]];
}

@end
