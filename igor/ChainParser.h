#import "ChainParserState.h"

@protocol IgorQueryScanner;

@interface ChainParser : NSObject

@property (strong) NSArray *subjectParsers;

- (ChainParserState *)parseOne;

- (ChainParserState *)parseChain;

+ (ChainParser *)parserWithCombinatorParsers:(NSArray *)combinatorParsers;

+ (ChainParser *)parserWithSubjectParsers:(NSArray *)subjectParsers combinatorParsers:(NSArray *)combinatorParsers;

@end
