#import "PatternParser.h"

@protocol ChainParser;

@interface QueryParser : NSObject <PatternParser>

@property(strong) id <ChainParser> chainParser;

+ (id <PatternParser>)parserWithChainParser:(id <ChainParser>)chainParser;

@end
