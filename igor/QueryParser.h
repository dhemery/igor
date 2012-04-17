#import "PatternParser.h"

@class ChainParser;

@interface QueryParser : NSObject <PatternParser>

+ (id <PatternParser>)parserWithChainParser:(ChainParser *)chainParser;

@end
