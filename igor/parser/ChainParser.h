#import "CombinatorParser.h"

@protocol ChainMatcher;
@protocol Combinator;
@protocol Matcher;
@protocol QueryScanner;

@protocol ChainParser <NSObject>

@property (strong) NSArray *subjectParsers;
@property (strong, readonly) id <CombinatorParser> combinatorParser;
@property (strong) id <Combinator> combinator;
@property (strong) id <Matcher> matcher;

@property (readonly, getter=done) BOOL done;

@property (readonly, getter=started) BOOL started;

- (id <Matcher>)parseStepFromScanner:(id <QueryScanner>)scanner;

- (void)parseSubjectChainFromScanner:(id <QueryScanner>)scanner intoMatcher:(id <ChainMatcher>)matcher;

@end

@interface ChainParser : NSObject <ChainParser>

+ (id <ChainParser>)parserWithCombinatorParser:(id <CombinatorParser>)combinatorParser;

+ (id <ChainParser>)parserWithSubjectParsers:(NSArray *)subjectParsers combinatorParser:(id <CombinatorParser>)combinatorParser;

@end
