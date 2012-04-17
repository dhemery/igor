#import "PatternParser.h"

@protocol QueryScanner;
@class ChainParser;

// TODO Test
@interface BranchParser : NSObject <PatternParser>

+ (id <PatternParser>)parserWithChainParser:(ChainParser *)chainParser;

@end