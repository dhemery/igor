#import "ClassParser.h"

@protocol IgorQueryScanner;

@interface ScanningClassParser : NSObject <ClassParser>

+ (id<ClassParser>)parserWithScanner:(id<IgorQueryScanner>)scanner;

@end
