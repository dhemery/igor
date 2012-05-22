#import "IsKindOfClassMatcher.h"
#import "DEKindOfClassMatcher.h"

#import <OCHamcrestIOS/HCDescription.h>

@implementation IsKindOfClassMatcher {
    Class targetClass;
}

+ (IsKindOfClassMatcher *)forClass:(Class)baseClass {
    return [[self alloc] initWithClass:baseClass];
}

- (IsKindOfClassMatcher *)initWithClass:(Class)baseClass {
    self = [super init];
    if (self) {
        targetClass = baseClass;
    }
    return self;
}

- (BOOL)matches:(id)item {
    if (![item isMemberOfClass:[DEKindOfClassMatcher class]]) {
        return NO;
    }
    DEKindOfClassMatcher *matcher = item;
    return targetClass == matcher.matchClass;
}

- (void)describeTo:(id <HCDescription>)description {
    [description appendDescriptionOf:[DEKindOfClassMatcher matcherForBaseClass:targetClass]];
}

@end
