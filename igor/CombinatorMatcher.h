#import "ChainMatcher.h"

@protocol Combinator;

@interface CombinatorMatcher : NSObject <ChainMatcher>

@property (strong) id <Matcher> subjectMatcher;
@property (strong) id <Combinator> combinator;
@property (strong) id <Matcher> relativeMatcher;

+ (id <ChainMatcher>)matcherWithSubjectMatcher:(id <Matcher>)matcher;

@end
