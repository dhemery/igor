#import <OCHamcrestIOS/HCBaseMatcher.h>
#import <objc/objc-api.h>

@interface KindOfClassMatcherForClass : HCBaseMatcher

+ forClass:(Class) targetClass;

@end

OBJC_EXPORT id<HCMatcher> kindOfClassMatcherForClass(Class targetClass);