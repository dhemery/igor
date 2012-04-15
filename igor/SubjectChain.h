@protocol SubjectMatcher;
@protocol Combinator;

@interface SubjectChain : NSObject

@property(strong) id <SubjectMatcher> matcher;
@property(strong) id <Combinator> combinator;
@property(readonly, getter=isStarted) BOOL started;
@property(readonly, getter=isDone) BOOL done;

+ (SubjectChain *)stateWithMatcher:(id <SubjectMatcher>)subjectMatcher combinator:(id <Combinator>)combinator;

@end