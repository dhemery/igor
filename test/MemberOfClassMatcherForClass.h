#import <OCHamcrestIOS/HCBaseMatcher.h>
#import <objc/objc-api.h>

@interface MemberOfClassMatcherForClass : HCBaseMatcher

+ forClass:(Class) targetClass;

@end

OBJC_EXPORT id<HCMatcher> memberOfClassMatcherForClass(Class targetClass);