@protocol IgorQueryScanner;
@protocol SubjectPatternParser;

#import "SubjectChainParser.h"
#import "IgorQueryParser.h"


@interface ScanningIgorQueryParser : NSObject <IgorQueryParser>

+ (id <IgorQueryParser>)parserWithScanner:(id <IgorQueryScanner>)scanner instanceChainParser:(id <SubjectChainParser>)instanceChainParser;

@end
