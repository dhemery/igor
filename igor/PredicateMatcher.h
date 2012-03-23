#import "Matcher.h"

@interface PredicateMatcher : Matcher

@property(readonly, retain) NSString *matchExpression;

+ (id)withPredicateExpression:(NSString *)expression;

@end
