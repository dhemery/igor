#import "DEPatternParser.h"

@protocol DEChainParser;

@interface DEQueryParser : NSObject <DEPatternParser>

@property(strong) id <DEChainParser> chainParser;

+ (id <DEPatternParser>)parserWithChainParser:(id <DEChainParser>)chainParser;

@end
