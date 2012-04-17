#import "PatternParser.h"

@protocol QueryScanner;

@interface ClassParser : NSObject <PatternParser>

+ (id <PatternParser>)parserWithScanner:(id <QueryScanner>)scanner;

@end
