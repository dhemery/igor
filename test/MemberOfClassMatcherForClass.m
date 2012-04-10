#import "MemberOfClassMatcherForClass.h"
#import "MemberOfClassMatcher.h"

#import <OCHamcrestIOS/HCDescription.h>

@implementation MemberOfClassMatcherForClass {
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
    if ([item class] != [MemberOfClassMatcher class]) {
        return NO;
    }

    return [((MemberOfClassMatcher*) item) matchClass] == _targetClass;
}

- (void) describeTo:(id<HCDescription>)description; {
    [[description appendText:@"Member of class matcher for class "] appendDescriptionOf:[_targetClass class]];
}

@end


id<HCMatcher> memberOfClassMatcherForClass(Class targetClass) {
    return [MemberOfClassMatcherForClass forClass:targetClass];
}
