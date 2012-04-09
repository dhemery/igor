#import "SimpleMatcher.h"

@interface PredicateMatcher : NSObject <SimpleMatcher>

@property(readonly, retain) NSString *matchExpression;

+ (id)withPredicateExpression:(NSString *)expression;

@end
