#import "ChainStep.h"

@protocol ChainMatcher;

@interface ChainParser : NSObject

@property (strong) NSArray *subjectParsers;
@property (strong, readonly) NSArray *combinatorParsers;
@property (strong) id <Combinator> combinator;
@property (strong) id <Matcher> matcher;w

+ (ChainParser *)parserWithCombinatorParsers:(NSArray *)combinatorParsers;

+ (ChainParser *)parserWithSubjectParsers:(NSArray *)subjectParsers combinatorParsers:(NSArray *)combinatorParsers;

- (id <Matcher>)parseSubjectMatcher;

- (void)parseSubjectChainIntoMatcher:(id <ChainMatcher>)matcher;

@end
