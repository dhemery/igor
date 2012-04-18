#import "PatternParser.h"

@protocol QueryScanner;
@protocol ChainParser;

// TODO Test
@interface BranchParser : NSObject <PatternParser>

+ (id <PatternParser>)parserWithChainParser:(id <ChainParser>)chainParser;

@end