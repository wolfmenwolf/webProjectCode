import React from 'react';
import {Button, StyleSheet, Text, View} from 'react-native';

export default class Page2 extends React.Component {
    //在这里定义每个页面的导航属性
    // static navigationOptions = {
    //     title: 'Page2',
    // };
    render() {
        const {navigation} = this.props;
        return <View style={{flex: 1, backgroundColor: "gray",}}>
            <Text style={styles.text}>欢迎来到Page2</Text>
            <Button
                title="Go Back"
                onPress={() => {
                    navigation.goBack();
                }}
            />
            <Button
                title="改变主题色"
                onPress={() => {
                    navigation.setParams({
                        theme: {
                            tintColor: 'blue',
                            updateTime: new Date().getTime()
                        }
                    })
                }}
            />
        </View>
    }
}
const styles = StyleSheet.create({
    text: {
        fontSize: 20,
        color: 'white'
    }
});