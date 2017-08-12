(function (root, factory) {
    if (typeof define === 'function' && define.amd) {
        // AMD. Register as an anonymous module.
        define(['exports', 'echarts'], factory);
    } else if (typeof exports === 'object' && typeof exports.nodeName !== 'string') {
        // CommonJS
        factory(exports, require('echarts'));
    } else {
        // Browser globals
        factory({}, root.echarts);
    }
}(this, function (exports, echarts) {
    var log = function (msg) {
        if (typeof console !== 'undefined') {
            console && console.error && console.error(msg);
        }
    };
    if (!echarts) {
        log('ECharts is not Loaded');
        return;
    }

    var colorPalette = [
       "#0e95ef", "#69bcfd", "#7bd9f2", "#53cdd5", "#3582c1", "#a894da", "#ff7db4", "#ff894c"
    ];


    var theme = {
        color: colorPalette,

        title: {
            textStyle: {
                fontWeight: 'normal',
                color: '#008acd'
            }
        },

        visualMap: {
            itemWidth: 15,
            color: ['#5ab1ef', '#e0ffff']
        },

        toolbox: {
            iconStyle: {
                normal: {
                    borderColor: colorPalette[0]
                }
            }
        },

        tooltip: {
            backgroundColor: 'rgba(50,50,50,0.5)',
            axisPointer: {
                type: 'line',
                lineStyle: {
                    color: '#008acd'
                },
                crossStyle: {
                    color: '#008acd'
                },
                shadowStyle: {
                    color: 'rgba(200,200,200,0.2)'
                }
            }
        },

        dataZoom: {
            dataBackgroundColor: '#efefff',
            fillerColor: 'rgba(182,162,222,0.2)',
            handleColor: '#008acd'
        },

        grid: {
            borderColor: '#eee',
            //x: 80
            //y:
        },
        bar: {
            barMaxWidth: 60,
            //itemStyle: { normal: { color: '#3582c1' } },  柱图 深蓝
           // color: ["#0e95ef", "#69bcfd", "#7bd9f2", "#53cdd5", "#a894da", "#ff7db4", "#ff894c"],
            markPoint: {
                label: {
                    normal: { textStyle: { fontSize: 18, fontWeight: 'bold', color: '#000' } }
                },
                itemStyle: { normal: { color: '#fac13e'  } },
                
            },
             label: {
                        normal: {
                           // show: true,
                            position: 'top',
                            textStyle: {
                                fontSize: 20, color: '#000'
                            }
                        }
                    }

        },
        pie: {
            label: {
                normal: {
                    textStyle: { fontSize: 16, fontWeight: 'bold', color: '#000' },                    
                }
            },
            labelLine: {
                normal: {
                    show: true,
                    lineStyle: {
                        color: '#000',
                    }
                }
            }

        },
        
        categoryAxis: {
            axisLine: {
                lineStyle: {
                    color: '#008acd'
                }
            },
            splitLine: {
                show: true,
                lineStyle: {
                    color: ['#eee']
                }
            },
            axisLabel: {
                textStyle: { fontSize: 16, fontWeight: 'bold', color: '#000' }
            }
        },

        valueAxis: {
            axisLine: {
                lineStyle: {
                    color: '#008acd'
                }
            },
            //splitArea: {
            //    show: true,
            //    areaStyle: {
            //        color: ['rgba(250,250,250,0.1)', 'rgba(200,200,200,0.1)']
            //    }
            //},
            splitLine: {
                show: true,
                lineStyle: {
                    color: ['#eee']
                }
            },

            nameTextStyle: {
                fontSize: 14, fontWeight: 'bolder', color: '#000'
            },
            axisLabel: {
                textStyle: {
                    fontSize: 14, color: '#000'
                }
            },
            splitNumber: 3, // 数值轴用，分割段数，默认为5
        },
        markPoint: {
            label: {
                normal: { textStyle: { color: '#000' } }
            }
        },


        timeline: {
            lineStyle: {
                color: '#008acd'
            },
            controlStyle: {
                normal: { color: '#008acd' },
                emphasis: { color: '#008acd' }
            },
            symbol: 'emptyCircle',
            symbolSize: 3
        },

        line: {
            smooth: true,
            symbol: 'emptyCircle',
            symbolSize: 3
        },

        candlestick: {
            itemStyle: {
                normal: {
                    color: '#d87a80',
                    color0: '#2ec7c9',
                    lineStyle: {
                        color: '#d87a80',
                        color0: '#2ec7c9'
                    }
                }
            }
        },

        scatter: {
            symbol: 'circle',
            symbolSize: 4
        },

        map: {
            label: {
                normal: {
                    textStyle: {
                        color: '#d87a80'
                    }
                }
            },
           
            itemStyle: {
                normal: {
                    borderColor: '#eee',
                    areaColor: '#ddd'
                },
                emphasis: {
                    areaColor: '#fe994e'
                }
            }
        },

        graph: {
            color: colorPalette
        },

        gauge: {
            axisLine: {
                lineStyle: {
                    color: [[0.2, '#2ec7c9'], [0.8, '#5ab1ef'], [1, '#d87a80']],
                    width: 10
                }
            },
            axisTick: {
                splitNumber: 10,
                length: 15,
                lineStyle: {
                    color: 'auto'
                }
            },
            splitLine: {
                length: 22,
                lineStyle: {
                    color: 'auto'
                }
            },
            pointer: {
                width: 5
            }
        }
    };

    echarts.registerTheme('macarons', theme);
}));