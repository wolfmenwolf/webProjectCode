import React from 'react';
import {createDrawerNavigator, createStackNavigator,SafeAreaView,DrawerItems} from 'react-navigation';
import Page1 from '../pages/Page1'
import Page2 from '../pages/Page2'
import Page3 from '../pages/Page3'
import Page4 from '../pages/Page4'
import Page5 from '../pages/Page5'
import HomePage from '../pages/HomePage'
import {Button, Platform,ScrollView,} from 'react-native'
import Ionicons from 'react-native-vector-icons/Ionicons';
import MaterialIcons from 'react-native-vector-icons/MaterialIcons';
import {createBottomTabNavigator, BottomTabBar} from 'react-navigation-tabs';

class TabBarComponent extends React.Component {
    constructor(props) {
        super(props);
        this.theme = {
            tintColor: props.activeTintColor,
            updateTime: new Date().getTime()
        }
    }

    render() {
        const {routes, index} = this.props.navigation.state;
        const {theme} = routes[index].params;
        if (theme && theme.updateTime > this.theme.updateTime) {
            this.theme = theme;
        }
        /**
         * custom tabBarComponent
         * https://github.com/react-navigation/react-navigation/issues/4297
         */
        return (
            <BottomTabBar
                {...this.props}
                activeTintColor={this.theme.tintColor || this.props.activeTintColor}
            />
        );
    }

}

export const AppTabNavigator = createBottomTabNavigator({
    Page1: {
        screen: Page1,
        navigationOptions: {
            tabBarLabel: 'Page1',
            tabBarIcon: ({tintColor, focused}) => (
                <Ionicons
                    name={focused ? 'ios-home' : 'ios-home-outline'}
                    size={26}
                    style={{color: tintColor}}
                />
            ),
        }
    },
    Page2: {
        screen: Page2,
        navigationOptions: {
            tabBarLabel: 'Page2',
            tabBarIcon: ({tintColor, focused}) => (
                <Ionicons
                    name={focused ? 'ios-people' : 'ios-people-outline'}
                    size={26}
                    style={{color: tintColor}}
                />
            ),
        }
    },
    Page3: {
        screen: Page3,
        navigationOptions: {
            tabBarLabel: 'Page3',
            tabBarIcon: ({tintColor, focused}) => (
                <Ionicons
                    name={focused ? 'ios-chatboxes' : 'ios-chatboxes-outline'}
                    size={26}
                    style={{color: tintColor}}
                />
            ),
        }
    },
}, {
    tabBarComponent: TabBarComponent,
    tabBarOptions: {
        activeTintColor: Platform.OS === 'ios' ? '#e91e63' : '#fff',
    }
});
export const DrawerNav = createDrawerNavigator({
        Page4: {
            screen: Page4,
            navigationOptions: {
                drawerLabel: 'Page4',
                drawerIcon: ({tintColor}) => (
                    <MaterialIcons name="drafts" size={24} style={{color: tintColor}}/>
                ),
            }
        },
        Page5: {
            screen: Page5,
            navigationOptions: {
                drawerLabel: 'Page5',
                drawerIcon: ({tintColor}) => (
                    <MaterialIcons
                        name="move-to-inbox"
                        size={24}
                        style={{color: tintColor}}
                    />
                ),
            }
        },
    },
    {
        initialRouteName: 'Page4',
        contentOptions: {
            activeTintColor: '#e91e63',
        },
        contentComponent:(props) => (
            <ScrollView style={{backgroundColor:'#987656',flex:1}}>
                <SafeAreaView forceInset={{ top: 'always', horizontal: 'never' }}>
                    <DrawerItems {...props} />
                </SafeAreaView>
            </ScrollView>
        )
    }
);
export const AppStackNavigator = createStackNavigator({
    HomePage: {
        screen: HomePage
    },
    Page1: {
        screen: Page1,
        navigationOptions: ({navigation}) => ({
            title: `${navigation.state.params.name}页面名`//动态设置navigationOptions
        })
    },
    Page2: {
        screen: Page2,
        navigationOptions: {//在这里定义每个页面的导航属性，静态配置
            title: "This is Page2.",
        }
    },
    Page3: {
        screen: Page3,
        navigationOptions: (props) => {//在这里定义每个页面的导航属性，动态配置
            const {navigation} = props;
            const {state, setParams} = navigation;
            const {params} = state;
            return {
                title: params.title ? params.title : 'This is Page3',
                headerRight: (
                    <Button
                        title={params.mode === 'edit' ? '保存' : '编辑'}
                        onPress={() =>
                            setParams({mode: params.mode === 'edit' ? '' : 'edit'})}
                    />
                ),
            }
        }
    },
    TabNav: {
        screen: AppTabNavigator,
        navigationOptions: {//在这里定义每个页面的导航属性，静态配置
            title: "This is TabNavigator.",
        }
    }, DrawerNav: {
        screen: DrawerNav,
        navigationOptions: {//在这里定义每个页面的导航属性，静态配置
            title: "This is DrawerNavigator.",
        }
    }
}, {
    navigationOptions: {
        // header: null,// 可以通过将header设为null 来禁用StackNavigator的Navigation Bar
    }
});
