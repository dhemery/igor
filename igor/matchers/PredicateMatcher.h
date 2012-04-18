#import "Matcher.h"

@interface PredicateMatcher : NSObject <Matcher>

@property(strong, readonly) NSPredicate *predicate;
@property(strong, readonly) NSString *expression;

+ (PredicateMatcher *)matcherForPredicateExpression:(NSString *)expression;

@end
