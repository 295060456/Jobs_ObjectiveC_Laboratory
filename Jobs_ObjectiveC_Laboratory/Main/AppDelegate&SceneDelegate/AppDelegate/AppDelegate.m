//
//  AppDelegate.m
//  Jobs_ObjectiveC_Laboratory
//
//  Created by Jobs on 22/10/2021.
//

#import "AppDelegate.h"

@interface AppDelegate (){
    NSManagedObjectContext *context;
}

@end

@implementation AppDelegate

static AppDelegate *static_appDelegate = nil;
+(instancetype)sharedInstance{
    @synchronized(self){
        if (!static_appDelegate) {
            static_appDelegate = AppDelegate.new;
        }
    }return static_appDelegate;
}

-(void)testSQLToolTwo{
    NSString *sql2 = [SQLToolTwo makeSQL:^(SQLToolTwo *tool) {
        tool.selectTwo(nil).fromTwo(@"").whereTwo(@"");
    }];
    
    NSDictionary *dd = @{
        @(0):@"0",
        @(1):@"1"
    };
    
    /// https://www.jianshu.com/p/c45f928b0519
    [dd enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key,
                                            id  _Nonnull obj,
                                            BOOL * _Nonnull stop) {
        NSLog(@"");
        *stop = YES;
    }];
}

-(void)testCoreData{
    // 创建上下文对象，并发队列设置为主队列
    context = [NSManagedObjectContext.alloc initWithConcurrencyType:NSMainQueueConcurrencyType];
    // 创建托管对象模型，并使用Company.momd路径当做初始化参数
    NSURL *modelPath = [NSBundle.mainBundle URLForResource:@"Company" withExtension:@"momd"];
    NSManagedObjectModel *model = [NSManagedObjectModel.alloc initWithContentsOfURL:modelPath];
    // 创建持久化存储调度器
    NSPersistentStoreCoordinator *coordinator = [NSPersistentStoreCoordinator.alloc initWithManagedObjectModel:model];
    // 创建并关联SQLite数据库文件，如果已经存在则不会重复创建
    NSString *dataPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    dataPath = [dataPath stringByAppendingFormat:@"/%@.sqlite", @"Company"];
    [coordinator addPersistentStoreWithType:NSSQLiteStoreType
                              configuration:nil
                                        URL:[NSURL fileURLWithPath:dataPath]
                                    options:nil
                                      error:nil];
    // 上下文对象设置属性为持久化存储器
    context.persistentStoreCoordinator = coordinator;
}
/// 增加
-(void)create{
    // 开始创建托管对象，并指明好创建的托管对象所属实体名
    Employee *emp = [NSEntityDescription insertNewObjectForEntityForName:@"Employee"
                                                  inManagedObjectContext:context];
    emp.name = @"lxz";
    emp.height = @(1.7);
    emp.brithday = NSDate.date;

    // 通过这样上下文保存对象，并在保存前判断是否有了最新的更改
    NSError *error = nil;
    if (context.hasChanges) {
        [context save:&error];
    }

    // 错误处理
    if (error) {
        NSLog(@"CoreData Insert Data Error : %@", error);
    }
}
/// 查询
-(void)read{
    //  获取数据的请求对象，指明对实体进行查询操作，以Employee为例
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Employee"];

    // 执行获取操作，获取所有Employee托管对象
    NSError *error = nil;
    NSArray<Employee *> *employees = [context executeFetchRequest:request error:&error];
    [employees enumerateObjectsUsingBlock:^(Employee * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"Employee Name : %@, Height : %@, Brithday : %@", obj.name, obj.height, obj.brithday);
    }];

    // 错误处理
    if (error) {
        NSLog(@"CoreData Ergodic Data Error : %@", error);
    }
}
/// 修改
-(void)update{
    // 获取数据的请求对象，指明对实体进行修改操作，以Employee为例
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Employee"];

    // 创建谓词对象，设置过滤条件，找到要修改的对象
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@", @"lxz"];
    request.predicate = predicate;

    // 通过执行获取请求，获取到符合要求的托管对象，修改即可
    NSError *error = nil;
    NSArray<Employee *> *employees = [context executeFetchRequest:request error:&error];
    [employees enumerateObjectsUsingBlock:^(Employee * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.height = @3.f;
    }];

    // 通过调用save将上面的修改进行存储
    if (context.hasChanges) {
        [context save:nil];
    }

    // 错误处理
    if (error) {
        NSLog(@"CoreData Update Data Error : %@", error);
    }
}
/// 删除
-(void)delete{
    // 获取数据的请求对象，指明对实体进行删除操作，以Employee为例
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Employee"];

    // 通过创建谓词对象，然后过滤掉符合要求的对象，也就是要删除的对象
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@", @"lxz"];
    request.predicate = predicate;

    // 通过执行获取操作，找到要删除的对象即可
    NSError *error = nil;
    NSArray<Employee *> *employees = [context executeFetchRequest:request error:&error];

    // 开始真正操作，一一遍历，遍历符合删除要求的对象数组，执行删除操作
    [employees enumerateObjectsUsingBlock:^(Employee * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [context deleteObject:obj];
    }];

    // 最后保存数据，保存上下文。
    if (context.hasChanges) {
        [context save:nil];
    }

    // 错误处理
    if (error) {
        NSLog(@"CoreData Delete Data Error : %@", error);
    }
}

- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
//    [self testSQLToolTwo];
    
//    AppDelegate.sharedInstance.persistentContainer;
//    UIApplication.sharedApplication.delegate;
//    NSManagedObjectContext *context = AppDelegate.sharedInstance.persistentContainer.viewContext;
    //Core Data 取出的实体都是 NSManagedObject 类型的
    
    [self testCoreData];
//    [self create];
//    [self delete];
//    [self update];
    [self read];
    
    return YES;
}
#pragma mark - UISceneSession lifecycle
- (UISceneConfiguration *)application:(UIApplication *)application
configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession
                              options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [UISceneConfiguration.alloc initWithName:@"Default Configuration"
                                        sessionRole:connectingSceneSession.role];
}

- (void)application:(UIApplication *)application
didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}
#pragma mark - Core Data stack
@synthesize persistentContainer = _persistentContainer;
- (NSPersistentContainer *)persistentContainer{
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (!_persistentContainer) {
            _persistentContainer = [NSPersistentContainer.alloc initWithName:@"Jobs_ObjectiveC_Laboratory"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription,
                                                                              NSError *error) {
                if (error) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }return _persistentContainer;
}
#pragma mark - Core Data Saving support
- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] &&
        ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
