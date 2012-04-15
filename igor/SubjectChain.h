@protocol SubjectMatcher;
@protocol Combinator;

@interface SubjectChain : NSObject

@property(nonatomic, strong) id <Combinator> combinator;
@property(nonatomic, readonly, getter=isDone) BOOL done;
@property(nonatomic, strong) id <SubjectMatcher> matcher;
@property(nonatomic, readonly, getter=isStarted) BOOL started;

+ (SubjectChain *)stateWithMatcher:(id <SubjectMatcher>)subjectMatcher combinator:(id <Combinator>)combinator;

@end