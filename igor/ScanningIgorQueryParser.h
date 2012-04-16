@protocol IgorQueryScanner;
@protocol SubjectPatternParser;
@class ChainParser;

#import "IgorQueryParser.h"


@interface ScanningIgorQueryParser : NSObject <IgorQueryParser>

+ (id <IgorQueryParser>)parserWithScanner:(id <IgorQueryScanner>)scanner subjectChainParser:(ChainParser *)subjectChainParser;

@end
