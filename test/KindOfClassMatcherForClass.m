#import "KindOfClassMatcherForClass.h"
#import "KindOfClassMatcher.h"

#import <OCHamcrestIOS/HCDescription.h>

@implementation KindOfClassMatcherForClass {
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

- (BOOL) matches:(id)item
{
    if ([item class] != [KindOfClassMatcher class]) {
        return NO;
    }

    return [((KindOfClassMatcher*) item) matchClass] == _targetClass;
}

- (void) describeTo:(id<HCDescription>)description;
{
    [[description appendText:@"Kind of class matcher for class "] appendDescriptionOf:[_targetClass class]];
}

@end


id<HCMatcher> kindOfClassMatcherForClass(Class targetClass)
{
    return [KindOfClassMatcherForClass forClass:targetClass];
}
