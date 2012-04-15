@protocol IgorQueryScanner;
@protocol SubjectPatternParser;
@class SubjectChainParser;

#import "IgorQueryParser.h"


@interface ScanningIgorQueryParser : NSObject <IgorQueryParser>

+ (id <IgorQueryParser>)parserWithScanner:(id <IgorQueryScanner>)scanner subjectChainParser:(SubjectChainParser *)subjectChainParser;

@end
