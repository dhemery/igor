#import <OCHamcrestIOS/HCBaseMatcher.h>
#import <objc/objc-api.h>

@interface PredicateMatcherForExpression : HCBaseMatcher

+ (id)forExpression:(NSString *)expression;

@end

OBJC_EXPORT id<HCMatcher> predicateMatcherForExpression(NSString *expression);