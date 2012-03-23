#import "Matcher.h"

@interface PredicateMatcher : NSObject<Matcher>

@property(readonly, retain) NSString *matchExpression;

+ (id)withPredicateExpression:(NSString *)expression;

@end
