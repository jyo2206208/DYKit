DYKit
==============
[![CocoaPods](http://img.shields.io/cocoapods/v/DYKit.svg?style=flat)](http://cocoapods.org/pods/DYKit)&nbsp;
[![CocoaPods](http://img.shields.io/cocoapods/p/DYKit.svg?style=flat)](http://cocoadocs.org/docsets/DYKit)&nbsp;
[![Support](https://img.shields.io/badge/support-iOS%208%2B%20-blue.svg?style=flat)](https://www.apple.com/nl/ios/)&nbsp;

DYKit是一套使用了ReactiveObjC的系统控件封装库

DYKit将UIkit中的大部分常用组件进行了封装，让这些控件不再使用delegate,datasource等而是可以通过block，RACSignal等形式进行控制，通过链式调用，很多控件从此可以通过一句代码完成。

sample
==============
#### 不需要delegate，datasource。你可以如此简单的创建一个tableView:

```objc
[self.homeTableView assemblyWithAssemblyBlock:^(UITableViewCell *cell, NSString *text, NSIndexPath *indexPath) {
        //这个block充当了cellForRowAtIndexPath的作用
        cell.textLabel.text = text;
}];
    
//设定数据
self.homeTableView.dy_data = @[@"标题1",@"标题2",@"标题3",@"标题4"];
```
1. `dy_data`是一个`NSArray`的属性。你只能给他绑定发送`NSArray`的`RACSignal`.当然你也可以像下面这样直接给他赋值。
`self,homeTableView.dy_data = @[@"标题1",@"标题2",@"标题3",@"标题4"];`  
2. `dy_data`中的每一个元素都会出现在上面那个`assemblyWithAssemblyBlock`中的第二个参数。你可以修改参数成任意类型，比如`model`或`videModel`甚至是`NSString`。



#### 你可以使用下面的方法来创建不同类型的tableView:

```objc
[self.tableView assemblyByReuseIdentifier:@"OneTypeCellByNibTableViewCell" withAssemblyBlock:^(OneTypeCellByNibTableViewCell *cell, User *user, NSIndexPath *indexPath) {
    cell.headImageView.image = [UIImage imageNamed:user.img];
    cell.headImageView.backgroundColor = user.sex == 0 ? [UIColor purpleColor] : [UIColor blackColor];
    cell.nameLabel.text = user.name;
    cell.ageLabel.text = user.age;
    cell.descLabel.text = user.desc;
}];
    
    
User *user1 = [User new];
User *user2 = [User new];
User *user3 = [User new];
    
user1.id = @"001";
user1.name = @"jack";
user1.img = @"head";
user1.age = @"29";
user1.desc = @"她喜欢黑色";
user1.sex = 0;
user2.id = @"002";
user2.name = @"Pink man";
user2.img = @"head";
user2.age = @"18";
user2.desc = @"白老师得意门生";
user2.sex = 1;
user3.id = @"003";
user3.name = @"MR.white";
user3.img = @"head";
user3.age = @"43";
user3.desc = @"平淡无奇的中学化学老师";
user3.sex = 1;
self.tableView.dy_data = @[user1,user2,user3];
```
1. `reuseIdentifier`参数传入一个复用ID。用来自动注册cell和使用复用cell，可支持nib或class创建的cell。(优先寻找`reuseIdentifier`命名的xib文件，找到的情况下直接注册nibcell。找不到的情况下会使用`reuseIdentifier`作为类名的非nib创建cell)


#### 当然你也可以使用下面这些方法来满足不同cell在同一个tableView或者不同的cetion下使用的需求

```objc
/**
 指定section和row进行cell设定

 @param identifier cell的重用ID(使用cell的类名，可以是xib或者class创建)
 @param section 指定section位置
 @param row 指定row位置
 @param block cellForRowAtIndexPath的block
 @return 返回自身，用于链式调用
 */
- (UITableView*) addReuseIdentifier:(NSString *)identifier FromSection:(int)section row:(int)row withAssemblyBlock:(AssemblyBlock)block;

/**
 指定section进行cell设定。默认本section下的cell全部按照block内容进行设定

 @param identifier cell的重用ID(使用cell的类名，可以是xib或者class创建)
 @param section 指定section位置
 @param block cellForRowAtIndexPath的block
 @return 返回自身，用于链式调用
 */
- (UITableView*) addReuseIdentifier:(NSString *)identifier FromSection:(int)section withAssemblyBlock:(AssemblyBlock)block;

/**
 指定row进行cell设定。默认只有一个section

 @param identifier cell的重用ID(使用cell的类名，可以是xib或者class创建)
 @param row 指定row位置
 @param block cellForRowAtIndexPath的block
 @return 返回自身，用于链式调用
 */
- (UITableView*) addReuseIdentifier:(NSString *)identifier FromRow:(int)row withAssemblyBlock:(AssemblyBlock)block;

/**
 指定具体的indexPath进行cell设定，可选择任意位置

 @param identifier cell的重用ID(使用cell的类名，可以是xib或者class创建)
 @param slotBlock 用于指定具体条件的block。通过对参数的indexPath进行判断，返回需要的具体位置
 @param cellBindBlock cellForRowAtIndexPath的block
 @return 返回自身，用于链式调用
 */
- (UITableView*) addReuseIdentifier:(NSString *)identifier FromSlot:(SlotBlock)slotBlock withAssemblyBlock:(AssemblyBlock)cellBindBlock;
```

#### 代理事件
你可以用这些方法获得你需要的代理事件的Signal

```objc
#pragma delegate方法
- (RACSignal*)accessoryButtonTappedForRowWithIndexPathSignal;
- (RACSignal*)didEndDisplayingCellSignal;
- (RACSignal*)didEndDisplayingHeaderViewSignal;
- (RACSignal*)didEndDisplayingFooterViewSignal;
- (RACSignal*)didHighlightRowAtIndexPathSignal;
- (RACSignal*)didUnhighlightRowAtIndexPathSignal;
- (RACSignal*)didSelectRowAtIndexPathSignal;
- (RACSignal*)didDeselectRowAtIndexPathSignal;
- (RACSignal*)didEndEditingRowAtIndexPathSignal;
- (RACSignal*)didUpdateFocusInContextSignal;
- (RACSignal*)performActionSignal;
- (RACSignal*)willBeginEditingRowAtIndexPathSignal;
- (RACSignal*)willDisplayCellSignal;
- (RACSignal*)willDisplayHeaderViewSignal;
- (RACSignal*)willDisplayFooterViewSignal;

#pragma DataSource方法
- (RACSignal*)commitEditingStyleSignal;
- (RACSignal*)moveRowAtIndexPathSignal;
```

#### 回调方法
你也可以通过传入block的方法来设置tableView的属性。名字和原来的那些一样

```objc
#pragma 配置用block
- (UITableView*)setHeightForRowAtIndexPath:(CGFloatTableViewIndexPath)block;
- (UITableView*)setEditActionsForRowAtIndexPath:(EditActionsForRowAtIndexPath)block;
- (UITableView*)setShouldHighlightRowAtIndexPath:(BOOLTableViewIndexPath)block;
- (UITableView*)setCanEditRowAtIndexPath:(BOOLTableViewIndexPath)block;
- (UITableView*)setNumberOfRowsInSection:(NSIntegerTableViewIndexPath)block;
//- (void)setCellForRowAtIndexPath:(UITableViewCellTableViewIndexPath)block;
- (UITableView*)setNumberOfSectionsInTableView:(NSIntegerUITableView)block;
- (UITableView*)setTitleForHeaderInSection:(NSStringTableViewNSInteger)block;
- (UITableView*)setTitleForFooterInSection:(NSStringTableViewNSInteger)block;
- (UITableView*)setCanMoveRowAtIndexPath:(BOOLTableViewIndexPath)block;
- (UITableView*)setSectionIndexTitlesForTableView:(SectionIndexTitlesForTableView)block;
- (UITableView*)setSectionForSectionIndexTitle:(NSIntegerUITableViewNSStringNSInteger)block;
- (UITableView*)setHeightForHeaderInSection:(CGFloatTableViewNSInteger)block;
- (UITableView*)setHeightForFooterInSection:(CGFloatTableViewNSInteger)block;
- (UITableView*)setEstimatedHeightForRowAtIndexPath:(CGFloatTableViewIndexPath)block;
- (UITableView*)setEstimatedHeightForHeaderInSection:(CGFloatTableViewNSInteger)block;
- (UITableView*)setEstimatedHeightForFooterInSection:(CGFloatTableViewNSInteger)block;
- (UITableView*)setViewForHeaderInSection:(UIViewTableViewNSInteger)block;
- (UITableView*)setViewForFooterInSection:(UIViewTableViewNSInteger)block;
- (UITableView*)setWillSelectRowAtIndexPath:(NSIndexPathUITableViewNSIndexPath)block;
- (UITableView*)setWillDeselectRowAtIndexPath:(NSIndexPathUITableViewNSIndexPath)block;
- (UITableView*)setEditingStyleForRowAtIndexPath:(UITableViewCellEditingStyleUITableViewNSIndexPath)block;
- (UITableView*)setTitleForDeleteConfirmationButtonForRowAtIndexPath:(NSStringTableViewIndexPath)block;
- (UITableView*)setShouldIndentWhileEditingRowAtIndexPath:(BOOLTableViewIndexPath)block;
- (UITableView*)setTargetIndexPathForMoveFromRowAtIndexPath:(NSIndexPathUITableViewNSIndexPathNSIndexPath)block;
- (UITableView*)setIndentationLevelForRowAtIndexPath:(NSIntegerUITableViewNSIndexPath)block;
- (UITableView*)setShouldShowMenuForRowAtIndexPath:(BOOLTableViewIndexPath)block;
- (UITableView*)setCanPerformAction:(BOOLUITableViewSELNSIndexPath)block;
- (UITableView*)setCanFocusRowAtIndexPath:(BOOLTableViewIndexPath)block;
- (UITableView*)setShouldUpdateFocusInContext:(BOOLUITableViewFocusUpdateContext)block;
- (UITableView*)setIndexPathForPreferredFocusedViewInTableView:(NSIndexPathUITableView)block;

```






安装
==============

### CocoaPods

1. 在 Podfile 中添加  `pod 'DYKit'`。
2. 执行 `pod install` 或 `pod update`。
3. 导入 \"DYKit.h\"。

将来
==============
1. 实现UIcollectionView的封装
2. 实现UITextView的封装

系统要求
==============
该项目最低支持 `iOS 8.0`。

许可证
==============
DYKit 使用 MIT 许可证，详情见 LICENSE 文件。



