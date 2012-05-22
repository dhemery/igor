#import "DEMatcher.h"

@interface DEPredicateMatcher : NSObject <DEMatcher>

@property(strong, readonly) NSPredicate *predicate;
@property(strong, readonly) NSString *expression;

+ (DEPredicateMatcher *)matcherForPredicateExpression:(NSString *)expression;

@end
