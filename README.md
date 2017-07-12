DYKit
==============
[![CocoaPods](http://img.shields.io/cocoapods/v/YYKit.svg?style=flat)](http://cocoapods.org/pods/DYKit)&nbsp;
[![CocoaPods](http://img.shields.io/cocoapods/p/YYKit.svg?style=flat)](http://cocoadocs.org/docsets/DYKit)&nbsp;
[![Support](https://img.shields.io/badge/support-iOS%208%2B%20-blue.svg?style=flat)](https://www.apple.com/nl/ios/)&nbsp;

DYKit是一套使用了ReactiveObjC的UI库

DYKit将UIkit中的大部分常用组件进行了封装，让这些控件不再使用delegate,datasource等而是可以通过block，RACSignal等形式进行控制，很多控件从此可以通过一句代码完成。

sample
==============
####↓不需要delegate，datasource。你可以如此简单的创建一个tableView:

```objc
//固定UItableViewCell的TableView
[self.homeTableView bindingForBindingBlock:^(UITableViewCell *cell, NSString *text, NSIndexPath *indexPath) {
    //这个block充当了cellForRowAtIndexPath的作用
    cell.textLabel.text = text;
}];
//绑定数据源
RAC(self,homeTableView.dy_data) = [RACSignal return:@[@"标题1",@"标题2",@"标题3",@"标题4"]];
```
1. dy_data是一个NSArray的属性。你只能给他绑定发送NSArray的RACSignal.当然你也可以像下面这样直接给他赋值。
//self,homeTableView.dy_data = @[@"标题1",@"标题2",@"标题3",@"标题4"];  
2. dy_data中的每一个元素都会出现在上面那个BindingBlock中的第二个参数。你可以修改参数成任意类型，比如model或VideModel。



####↓你可以使用下面的方法来创建不同类型的tableView:

```objc
    @weakify(self)
    [self.oneTypeCellByNibTableView bindingForBindingBlock:^(OneTypeCellByNibTableViewCell *cell, OneTypeCellByNibTableViewCellViewModel *viewModel, NSIndexPath *indexPath) {
        @strongify(self)
        RAC(cell,nameLabel.text) = [RACObserve(viewModel, user.name) takeUntil:cell.rac_prepareForReuseSignal];
        RAC(cell,headImageView.image) = [[RACObserve(viewModel, user.img) takeUntil:cell.rac_prepareForReuseSignal] map:^id _Nullable(NSString *value) {
            return [UIImage imageNamed:value];
        }];
        RAC(cell,ageLabel.text) = [[RACObserve(viewModel, user.age) takeUntil:cell.rac_prepareForReuseSignal] map:^id _Nullable(NSString *value) {
            return [NSString stringWithFormat:@"age:%@",value];
        }];;
        RAC(cell,descLabel.text) = [RACObserve(viewModel, user.desc) takeUntil:cell.rac_prepareForReuseSignal];
    } reuseIdentifier:@"OneTypeCellByNibTableViewCell"];
    
    
    User *user1 = [[User alloc] init];
    user1.name = @"jack";
    user1.img = @"head";
    user1.age = @"12";
    user1.desc = @"Like black";
    OneTypeCellByNibTableViewCellViewModel *viewModel1 = [[OneTypeCellByNibTableViewCellViewModel alloc] init];
    viewModel1.user = user1;
    User *user2 = [[User alloc] init];
    user2.name = @"pinkMan";
    user2.img = @"head";
    user2.age = @"28";
    user2.desc = @"partner of the world's biggest drug dealer";
    OneTypeCellByNibTableViewCellViewModel *viewModel2 = [[OneTypeCellByNibTableViewCellViewModel alloc] init];
    viewModel2.user = user2;
    RAC(self,oneTypeCellByNibTableView.dy_data) = [RACSignal return:@[viewModel1,viewModel2]];
```
1. reuseIdentifier参数传入一个复用ID。用来自动注册cell和使用复用cell，可支持nib或class创建的cell。(优先寻找reuseIdentifier命名的xib文件，找到的情况下直接注册nibcell。找不到的情况下会使用reuseIdentifier作为类名的非nib创建cell)


####↓当然你也可以使用下面这两个方法传入多个reuseIdentifier来满足不同cell在同一个tableView使用的需求 

```objc
- (void) bindingForBindingBlock:(CellBindBlock)block reuseIdentifierArray:(NSArray *)identifiers;
- (void) bindingForBindingBlock:(CellBindBlock)block reuseIdentifiers:(NSString *)identifiers,...;
```

####代理事件
你可以用这些方法获得你需要的代理事件的Signal

```objc
#pragma delegate方法
(RACSignal*)accessoryButtonTappedForRowWithIndexPathSignal;
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

####回调方法
你也可以通过传入block的方法来设置tableView的属性。名字和原来的那些一样

```objc
- (void)setHeightForRowAtIndexPath:(CGFloatTableViewIndexPath)block;
- (void)setEditActionsForRowAtIndexPath:(EditActionsForRowAtIndexPath)block;
- (void)setShouldHighlightRowAtIndexPath:(BOOLTableViewIndexPath)block;
- (void)setCanEditRowAtIndexPath:(BOOLTableViewIndexPath)block;
- (void)setNumberOfRowsInSection:(NSIntegerTableViewIndexPath)block;
- (void)setCellForRowAtIndexPath:(UITableViewCellTableViewIndexPath)block;
- (void)setNumberOfSectionsInTableView:(NSIntegerUITableView)block;
- (void)setTitleForHeaderInSection:(NSStringTableViewNSInteger)block;
- (void)setTitleForFooterInSection:(NSStringTableViewNSInteger)block;
- (void)setCanMoveRowAtIndexPath:(BOOLTableViewIndexPath)block;
- (void)setSectionIndexTitlesForTableView:(SectionIndexTitlesForTableView)block;
- (void)setSectionForSectionIndexTitle:(NSIntegerUITableViewNSStringNSInteger)block;
- (void)setHeightForHeaderInSection:(CGFloatTableViewNSInteger)block;
- (void)setHeightForFooterInSection:(CGFloatTableViewNSInteger)block;
//- (void)setEstimatedHeightForRowAtIndexPath:(CGFloatTableViewIndexPath)block;
//- (void)setEstimatedHeightForHeaderInSection:(CGFloatTableViewNSInteger)block;
//- (void)setEstimatedHeightForFooterInSection:(CGFloatTableViewNSInteger)block;
- (void)setViewForHeaderInSection:(UIViewTableViewNSInteger)block;
- (void)setViewForFooterInSection:(UIViewTableViewNSInteger)block;
- (void)setWillSelectRowAtIndexPath:(NSIndexPathUITableViewNSIndexPath)block;
- (void)setWillDeselectRowAtIndexPath:(NSIndexPathUITableViewNSIndexPath)block;
- (void)setEditingStyleForRowAtIndexPath:(UITableViewCellEditingStyleUITableViewNSIndexPath)block;
- (void)setTitleForDeleteConfirmationButtonForRowAtIndexPath:(NSStringTableViewIndexPath)block;
- (void)setShouldIndentWhileEditingRowAtIndexPath:(BOOLTableViewIndexPath)block;
- (void)setTargetIndexPathForMoveFromRowAtIndexPath:(NSIndexPathUITableViewNSIndexPathNSIndexPath)block;
- (void)setIndentationLevelForRowAtIndexPath:(NSIntegerUITableViewNSIndexPath)block;
- (void)setShouldShowMenuForRowAtIndexPath:(BOOLTableViewIndexPath)block;
- (void)setCanPerformAction:(BOOLUITableViewSELNSIndexPath)block;
- (void)setCanFocusRowAtIndexPath:(BOOLTableViewIndexPath)block;
- (void)setShouldUpdateFocusInContext:(BOOLUITableViewFocusUpdateContext)block;
- (void)setIndexPathForPreferredFocusedViewInTableView:(NSIndexPathUITableView)block;

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


