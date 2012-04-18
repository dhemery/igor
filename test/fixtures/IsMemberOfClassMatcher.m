#import "IsMemberOfClassMatcher.h"
#import "MemberOfClassMatcher.h"

#import <OCHamcrestIOS/HCDescription.h>

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
    if (![item isMemberOfClass:[MemberOfClassMatcher class]]) {
        return NO;
    }
    MemberOfClassMatcher *matcher = item;
    return targetClass == matcher.matchClass;
}

- (void)describeTo:(id <HCDescription>)description; {
    [description appendDescriptionOf:[MemberOfClassMatcher matcherForExactClass:targetClass]];
}

@end
