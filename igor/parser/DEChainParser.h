#import "DECombinatorParser.h"

@protocol DEChainMatcher;
@protocol DECombinator;
@protocol DEMatcher;
@protocol DEQueryScanner;

@protocol DEChainParser <NSObject>

@property (strong) NSArray *subjectParsers;
@property (strong, readonly) id <DECombinatorParser> combinatorParser;
@property (strong) id <DECombinator> combinator;
@property (strong) id <DEMatcher> matcher;

@property (readonly, getter=done) BOOL done;

@property (readonly, getter=started) BOOL started;

- (id <DEMatcher>)parseStepFromScanner:(id <DEQueryScanner>)scanner;

- (void)parseSubjectChainFromScanner:(id <DEQueryScanner>)scanner intoMatcher:(id <DEChainMatcher>)matcher;

@end

@interface DEChainParser : NSObject <DEChainParser>

+ (id <DEChainParser>)parserWithCombinatorParser:(id <DECombinatorParser>)combinatorParser;

+ (id <DEChainParser>)parserWithSubjectParsers:(NSArray *)subjectParsers combinatorParser:(id <DECombinatorParser>)combinatorParser;

@end
