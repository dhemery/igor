#import <OCHamcrestIOS/HCBaseMatcher.h>


@interface IsKindOfClassMatcher : HCBaseMatcher

+ (IsKindOfClassMatcher *)forClass:(Class)targetClass;

@end
