#import "CombinatorParser.h"

@protocol IgorQueryScanner;

@interface DescendantCombinatorParser : NSObject <CombinatorParser>

+ (id <CombinatorParser>)parserWithScanner:(id <IgorQueryScanner>)theScanner;

@end