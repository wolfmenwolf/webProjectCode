const Swiper = require('react-native-swiper')

import React, {Component} from 'react'
import {
  StyleSheet,
  Text,
  View,
  Image,
  Platform,
  TouchableHighlight,
  Dimensions,
} from 'react-native'

const {width, height} = Dimensions.get('window')

export default class Slider extends React.Component {
  constructor(props) {
    super(props)
  }

  render() {
    const {
      banners,
      sliderLoop,
      enteredSlide
    } = this.props

    const bannersSlider = banners.map((item, i) => {
      let innerButton = null

      if (i + 1 === banners.length) {
        innerButton = (
          <TouchableHighlight style={styles.btn} onPress={enteredSlide}>
            <Text style={styles.btnText}>马上体验</Text>
          </TouchableHighlight>
        )
      }

      return (
        <View style={styles.slide} key={i}>
          <Image style={styles.image} source={banners[i]} />
          {innerButton}
        </View>
      )
    })

    return (
      <Swiper
        dot={<View style={styles.dot} />}
        activeDot={<View style={styles.activeDot} />}
        paginationStyle={styles.pagination}
        loop={sliderLoop}>
        {bannersSlider}
      </Swiper>
    )
  }
}

const styles = StyleSheet.create({
  slide: {
    flex: 1,
    width: width
  },

  image: {
    flex: 1,
    width: width,
    height: height
  },

  dot: {
    width: 14,
    height: 14,
    backgroundColor: 'transparent',
    borderColor: '#ff6600',
    borderRadius: 7,
    borderWidth: 1,
    marginLeft: 12,
    marginRight: 12
  },

  activeDot: {
    width: 14,
    height: 14,
    borderWidth: 1,
    marginLeft: 12,
    marginRight: 12,
    borderRadius: 7,
    borderColor: '#ee735c',
    backgroundColor: '#ee735c',
  },

  pagination: {
    bottom: 30
  },

  btn: {
    position: 'absolute',
    width: width - 20,
    left: 10,
    bottom: 60,
    height: 50,
    padding: 10,
    backgroundColor: '#ee735c',
    borderColor: '#ee735c',
    borderWidth: 1,
    ...Platform.select({
      ios: {
        borderRadius: 3
      },
      android: {
        borderRadius: 0
      }
    })
  },

  btnText: {
    color: '#fff',
    fontSize: 20,
    textAlign: 'center'
  }
})