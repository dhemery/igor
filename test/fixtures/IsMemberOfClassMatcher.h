#import <OCHamcrestIOS/HCBaseMatcher.h>

@interface IsMemberOfClassMatcher : HCBaseMatcher

+ (IsMemberOfClassMatcher *)forExactClass:(Class)exactClass;

@end
