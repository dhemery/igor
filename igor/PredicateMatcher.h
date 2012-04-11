#import "SimpleMatcher.h"

@interface PredicateMatcher : NSObject <SimpleMatcher>

@property(strong, readonly) NSPredicate* predicate;
@property(strong, readonly) NSString* expression;

+ (id)withPredicateExpression:(NSString *)expression;

@end
