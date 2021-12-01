//
//  AppDelegate.h
//  Jobs_ObjectiveC_Laboratory
//
//  Created by Jobs on 22/10/2021.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "SQLToolTwo.h"
#import "Employee.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property(readonly,strong)NSPersistentContainer *persistentContainer;

+(instancetype)sharedInstance;
-(void)saveContext;

@end

