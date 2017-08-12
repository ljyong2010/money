function myEChartsMap(container,mapJsonDataUrl, theme) {
    this.mapChart = echarts.init(document.getElementById(container), theme),
    this.mapJsonData = undefined;
    this.Option = undefined;
    this.CreateSeries = undefined;
    this.Series = [];
    this.Events = {
        Click: undefined//单击地图区域块事件
    },
    //地图初始化 
    this.Init = function () {
        $.ajaxSetup({ async: false });
        var _mapJsonData;
        $.get(mapJsonDataUrl, function (jsonData) {
            _mapJsonData = jsonData;
            echarts.registerMap('area', jsonData);
        });

        this.mapJsonData = _mapJsonData;

        this.mapChart.setOption(this.Option);
        var objEvents = this.Events;
        this.mapChart.on("click", function (param) {
            objEvents.Click(param);
        })

        $.ajaxSetup({ async: true });
    }
}


//function myEChartsMap(container,theme) {    
//    this.mapChart = echarts.init(document.getElementById(container), theme),
//    this.DisplayAreaName = true,//是否显示地区名称
//    this.SeriesDataMax = 0.0;//地图加载的数据最大值
//    this.SeriesDataMin = 0.001;//地图加载的数据最小值
//    this.Series = [];
//    this.SeriesData = [];//地图加载的数据
//    this.LegendData = [];
//    this.Events = {
//        Click : undefined//单击地图区域块事件
//    },
//    //地图初始化
//    this.Init = function (mapDataUrl) {
//        var _jsonData = "";
//        $.ajaxSetup({ async: false });
//        $.get(mapDataUrl, function (jsonData) {
//            _jsonData = jsonData;
//        });
//        echarts.registerMap('area', _jsonData);
//        this.mapChart.setOption({
//            visualMap: {
//                min: this.SeriesDataMin,
//                max: this.SeriesDataMax,
//                left: 'left',
//                //splitNumber: 5,//将图例条改为图例块
//                inRange: {
//                    color: ['#FE8463', '#F3DA60', '#26C0C0'].reverse()
//                }
//            },
//            tooltip: {
//            },
//            legend: {
//                orient: 'vertical',
//                selectedMode: "single",
//                left: 'right',
//                data: this.LegendData//['光伏项目', '电商项目']
//            },
//            series: this.Series,
            
//        });
        
//        var length = this.mapChart;
        
//        var objEvents = this.Events;
//        this.mapChart.on("click", function (param) {
//            objEvents.Click(param);
//        })
        
//        //'click', 'dblclick', 'mouseover', 'mouseout', 'mousedown', 'mouseup', 'globalout'

//        this.mapChart.on("dblclick", function (param) {
//            //alert("dblclick");
//        })
//        this.mapChart.on("mouseover", function (param) {
//            //alert("mouseover");
//        })
//        this.mapChart.on("mouseout", function (param) {
//            //alert("mouseout");
//        })
//        this.mapChart.on("mousedown", function (param) {
//            //alert("mousedown");
//        })
//        this.mapChart.on("mouseup", function (param) {
//            //alert("mouseup");
//        })
//        this.mapChart.on("legendselectchanged", function (param) {
//            //alert("legendselectchanged");
//        })
//        $.ajaxSetup({ async: true });
//    }
//}

//myEChartsMap.CreateSeries = function(typename){
//    return {
//        name: typename,
//        type: 'map',
//        map: 'area',
//        label: {
//            normal: {
//                show: true
//            },
//            emphasis: {
//                show: true
//            }
//        }, data: []
//    };
//}


//function myEChartsMapXMZJ(container, theme) {
//    myEChartsMap.apply(this, arguments);
//    this.GeoCoordMap = {};

//    //地图初始化
//    this.Init = function (mapDataUrl) {
//        var colors = this.Colors;
//        var _jsonData = "";
//        $.ajaxSetup({ async: false });
//        $.get(mapDataUrl, function (jsonData) {
//            _jsonData = jsonData;
//        });
//        echarts.registerMap('area', _jsonData);
//        this.mapChart.setOption({
//            visualMap: {
//                min: this.SeriesDataMin,
//                max: this.SeriesDataMax,
//                left: 'left',
//                //splitNumber: 5,//将图例条改为图例块
//                inRange: {
//                    color: ['#FE8463', '#F3DA60', '#26C0C0']
//                }
//            },
//            geo: {
//                map: 'area'
//            },
//            legend: {
//                type: 'effectScatter',
//                selectedMode: "single",
//                orient: 'vertical',
//                left: 'right',
//                data: this.LegendData//['光伏项目', '电商项目']
//            },
//            series: this.Series,

//        });
        
//        var objEvents = this.Events;
//        this.mapChart.on("click", function (param) {
//            objEvents.Click(param);
//        })
//        $.ajaxSetup({ async: true });
//    }
//}

//myEChartsMapXMZJ.ConvertData = function (data) {
//    var res = [];
//    for (var i = 0; i < data.length; i++) {
//        var geoCoord = this.GeoCoordMap[data[i].name];
//        if (geoCoord) {
//            res.push({
//                name: data[i].name,
//                value: geoCoord.concat(data[i].value)
//            });
//        }
//    }
//    return res;
//};

//myEChartsMapXMZJ.CreateSeries = function (typename) {
//    return {
//        name: typename,
//        type: 'effectScatter',
//        map: 'area',
//        symbolSize: 20,
//        blendMode: 'lighter',
//        coordinateSystem: 'geo',
//        toolbox: {
//            show : true,
//            orient : 'vertical',
//            x: 'right',
//            y: 'center',
//            feature : {
//                mark : {show: true},
//                dataView : {show: true, readOnly: false},
//                restore : {show: true},
//                saveAsImage : {show: true}
//            }
//        },
//        showEffectOn: 'render',
//        rippleEffect: {
//            brushType: 'stroke'
//        },
//        itemStyle: {
//            normal: {
//                color: '#F20000',
//                shadowBlur: 10,
//                shadowColor: '#000'
//            }
//        },
//        label: {
//            normal: {
//                show: true
//            },
//            emphasis: {
//                show: true
//            }
//        }, data: []
//    };
//}