@protocol ChainMatcher;
@protocol Combinator;
@protocol Matcher;
@protocol QueryScanner;

@interface ChainParser : NSObject

@property (strong) NSArray *subjectParsers;
@property (strong, readonly) NSArray *combinatorParsers;
@property (strong) id <Combinator> combinator;
@property (strong) id <Matcher> matcher;

@property (readonly, getter=done) BOOL done;

@property (readonly, getter=started) BOOL started;

+ (ChainParser *)parserWithCombinatorParsers:(NSArray *)combinatorParsers;

+ (ChainParser *)parserWithSubjectParsers:(NSArray *)subjectParsers combinatorParsers:(NSArray *)combinatorParsers;

- (id <Matcher>)parseStepFromScanner:(id <QueryScanner>)scanner;

- (void)parseSubjectChainFromScanner:(id <QueryScanner>)scanner intoMatcher:(id <ChainMatcher>)matcher;

@end
