@protocol ChainMatcher;
@protocol Combinator;
@protocol Matcher;
@protocol QueryScanner;

@protocol ChainParser <NSObject>

@property (strong) NSArray *subjectParsers;
@property (strong, readonly) NSArray *combinatorParsers;
@property (strong) id <Combinator> combinator;
@property (strong) id <Matcher> matcher;

@property (readonly, getter=done) BOOL done;

@property (readonly, getter=started) BOOL started;

- (id <Matcher>)parseStepFromScanner:(id <QueryScanner>)scanner;

- (void)parseSubjectChainFromScanner:(id <QueryScanner>)scanner intoMatcher:(id <ChainMatcher>)matcher;

@end

@interface ChainParser : NSObject <ChainParser>

+ (id <ChainParser>)parserWithCombinatorParsers:(NSArray *)combinatorParsers;

+ (id <ChainParser>)parserWithSubjectParsers:(NSArray *)subjectParsers combinatorParsers:(NSArray *)combinatorParsers;

@end
