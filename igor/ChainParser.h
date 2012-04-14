#import "CombinatorParser.h"
#import "SubjectPatternParser.h"

@protocol IgorQueryScanner;
@class ChainParserState;

@interface ChainParser : NSObject <SubjectPatternParser, CombinatorParser>

@property (strong) NSArray *subjectParsers;

- (ChainParserState *)parseOne;

- (ChainParserState *)parseChain;

+ (ChainParser *)parserWithCombinatorParsers:(NSArray *)combinatorParsers;

+ (ChainParser *)parserWithSubjectParsers:(NSArray *)subjectParsers combinatorParsers:(NSArray *)combinatorParsers;

@end