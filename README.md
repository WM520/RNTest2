# 使用Cocoapods集成react native
### 对于react native（一下简称RCT）很多人应该都听说过，但真的集成使用，还是没有过的，近期在为已有项目集成RCT遇上了很多坑，发现网上挺多资料，但是看着乱的很，于是自己整理了一下：
在集成之前，你的电脑必须安装：

#### step 1.在项目中加入Cocoapods

Cocoapods是iOS中目前公认的最便捷，合理的第三方框架管理工具，具体的网上很多相关的文章，一搜就可以了。
项目工程根目录下pod initpod install
#### step 2.安装react-native

先创建一个文件夹用来存放react-native
mkdir react
进入创建的react文件中
cd react
创建package.json

文件 记得删除注释

```
{
  "name": "你的项目名",
  "version": "0.0.1",
  "private": true,
  "scripts": {
    "start": "node node_modules/react-native/local-cli/cli.js start"
  },
  "dependencies": {  // 这里填入依赖项
    "react": "15.4.2",  // 其实 react也是作为一个第三方库存在的
    "react-native": "0.41.2"  // 这个也是 - - 依次可以加入很多第三方库，然后使用npm install初始化，其实这里和cocoapods很相似
  }
}
```
在react文件夹中安装react-native
```
npm install
```
创建index.ios.js文件
```
 /**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, { Component } from 'react';
import {
  AppRegistry,
  StyleSheet,
  Text,
  View
} from 'react-native';

export default class ModuleA extends Component {
  render() {
    return (
      <View style={styles.container}>
        <Text style={styles.welcome}>
          Welcome to React Native!
        </Text>
        <Text style={styles.instructions}>
          To get started, edit index.ios.js
        </Text>
        <Text style={styles.instructions}>
          Press Cmd+R to reload,{'\n'}
          Cmd+D or shake for dev menu
        </Text>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
  instructions: {
    textAlign: 'center',
    color: '#333333',
    marginBottom: 5,
  },
});

AppRegistry.registerComponent('ModuleA', () => ModuleA);
```
#### step 3.使用Cocoapods集成react-native

在Podfile中添加React
```
pod 'React', :path => ‘./react/node_modules/react-native', :subspecs => [
  'Core',
  'ART',
  'RCTActionSheet',
  'RCTAdSupport',
  'RCTGeolocation',
  'RCTImage',
  'RCTNetwork',
  'RCTPushNotification',
  'RCTSettings',
  'RCTText',
  'RCTVibration',
  'RCTWebSocket',
  'RCTLinkingIOS',
]
```
#### 根据需求添加项目中需要的模块
注意：./react/node_modules/react-native这个react是和你开始创建的存放RCT的目录是相同的。记得要添加所有你需要的依赖！举例来说， 元素如果不添加RCTText依赖就不能运行。

更新pod
```
pod update --no-repo-update
```
到这里，配置工作就基本完成了，接下来跑起来试一下
#### step 4.run run run

先进入开始安装RCT的目录中，开启服务
```
react-native start
```
在iOS 9以上的系统中，除非明确指明，否则应用无法通过http协议连接到localhost主机。 我们建议你在Info.plist文件中将localhost列为App Transport Security的例外。 如果不这样做，在尝试通过http连接到服务器时，会遭遇这个错误 - Could not connect to development server.

打开工程中的 Info.list 文件，添加下面配置即可：
```
<key>NSAppTransportSecurity</key> 
<dict> 
  <key>NSExceptionDomains</key> 
  <dict> 
    <key>localhost</key> 
    <dict>   
      <key>NSTemporaryExceptionAllowsInsecureHTTPLoads</key> 
      <true/> 
    </dict> 
  </dict>
</dict>
```
做完配置，就可以开始写代码了
```
NSString * strUrl = @"http://localhost:8081/index.ios.bundle?platform=ios&dev=true";
NSURL * jsCodeLocation = [NSURL URLWithString:strUrl]; 
RCTRootView * rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation moduleName:@"ModuleA" initialProperties:nil launchOptions:nil]; 
[self.view addSubview:rootView];rootView.frame = CGRectMake(0, 20, 300, 300);
```
