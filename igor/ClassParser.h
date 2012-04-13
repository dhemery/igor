#import "SimplePatternParser.h"

@protocol IgorQueryScanner;

@interface ClassParser : NSObject <SimplePatternParser>

+ (id<SimplePatternParser>)parserWithScanner:(id<IgorQueryScanner>)scanner;

@end
