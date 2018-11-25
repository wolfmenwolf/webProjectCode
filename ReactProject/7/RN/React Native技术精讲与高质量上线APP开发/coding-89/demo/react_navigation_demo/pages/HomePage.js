import React from 'react';
import {Button, StyleSheet, Text, View} from 'react-native';

export default class HomePage extends React.Component {
    //在这里定义每个页面的导航属性
    static navigationOptions = {
        title: 'Home',
        headerBackTitle: '返回哈哈',//设置返回此页面的返回按钮文案，有长度限制
    }

    render() {
        const {navigation} = this.props;
        return <View style={{flex: 1, backgroundColor: "orange",}}>
            <Text style={styles.text}>欢迎来到HomePage</Text>
            <Button
                title="Go To Page1"
                onPress={() => {
                    navigation.navigate('Page1', {name: '动态的'});
                }}
            />
            <Button
                title="Go To Page2"
                onPress={() => {
                    navigation.navigate('Page2');
                }}
            />
            <Button
                title="Go To Page3"
                onPress={() => {
                    navigation.navigate('Page3', {name: 'Devio'});
                }}
            />
            <Button
                title="Go To TabNavigator"
                onPress={() => {
                    navigation.navigate('TabNav', {name: 'Devio'});
                }}
            />
            <Button
                title="Go To DrawerNavigator"
                onPress={() => {
                    navigation.navigate('DrawerNav', {name: 'Devio'});
                }}
            />
        </View
        >
    }
}
const styles = StyleSheet.create({
    text: {
        fontSize: 20,
        color: 'white'
    }
});