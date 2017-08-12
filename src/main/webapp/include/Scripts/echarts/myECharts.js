//var colorList = [
//    '#C1232B', '#B5C334', '#FCCE10', '#E87C25', '#27727B',
//    '#FE8463', '#9BCA63', '#FAD860', '#F3A43B', '#60C0DD',
//    '#FEA463', '#ABCA63', '#F3DA60', '#A3A43B', '#6AC8DD',
//    '#D7504B', '#C6E579', '#F4E001', '#F0805A', '#26C0C0'
//];

var colorList = [
    '#0e95ef', '#53cdd5', '#7bd9f2', '#a6eaff', '#c1f4ff',
    '#c8c8c8', '#ffe3bf', '#ffd48c', '#f6bd55'
];

function EChartsCommonConfig(containerId, title, data,theme) {
    this._containerId = containerId;
    this.title = title;
    this.data = data;
    this._theme = "macarons";
}


function EChartsConfig() {
    EChartsCommonConfig.apply(this, arguments);
    this.showToolbox = true;
    this.showLegend = true;
    this.titleX = "center";
    this.titleY = "top";
    this.chartType = "bar";
    this.xAxisLabels = [];
    this.yAxisName = "";
    this.yAxisSuffix = "";
    this.parameter = [];
    this.onClick = undefined;
    this.onLoaded = undefined;
    this.showChart = function () {
        var _myChart = echarts.init($('#' + this._containerId)[0], this._theme);
        var _option = {};
        if (this._data == undefined) return;
        var legend_data = [];
        if (this._data.length > 1) {
            for (var i = 0; i < this._data.length; i++) {
                legend_data[i] = this._data[i].name;
                this._data[i].type = this.chartType;
            }
        } else {
            this._data[0].itemStyle = {
                normal: {
                    label: {
                        show: true,
                        position: 'top',
                        formatter: '{b}\n{c} {d}%'
                    }
                }
            };
            this._data[0].type = this.chartType;
        }

        if (this._title != "") {
            _option._title = {
                x: this.titleX,
                y: this.titleY,
                text: this._title
            };
        }
        this.calculable = true;

        this.tooltip = {
            trigger: 'axis'
        };
        var showMagicType = (this.magicType != undefined);
        _option.toolbox = {
            show: this.showToolbox,
            feature: {
                dataZoom: { show: true, title: { dataZoom: '区域缩放', dataZoomReset: '区域缩放后退' } },
                magicType: { show: showMagicType, type: this.magicType },
                restore: { show: true },
                saveAsImage: { show: true }
            }
        };

        if (this.showLegend) {
            _option.legend = {
                y: "bottom",
                data: legend_data
            };
        }

        _option.xAxis = [
            {
                'type': 'category',
                'axisLabel': { 'interval': 0 },
                data: this.xAxisLabels
            }
        ];

        _option.yAxis = [
            {
                type: 'value',
                name: this.yAxisName,
                axisLabel: {
                    formatter: '{value}' + this.yAxisSuffix
                }
            }
        ];

        _option.series = this._data;
        _myChart.setOption(_option);
        _myChart.on('click', this.onClick);
    };
}
/*单线图*/
function ChartLine() {
    EChartsConfig.apply(this, arguments);
    this.chartType = "line";
    this.magicType = ['bar', 'line'];
}
/*单柱图*/
function ChartBar() {
    EChartsConfig.apply(this, arguments);
    this.chartType = "bar";
    this.magicType = ['line', 'bar'];
}
/*饼图*/
function ChartPic() {
    EChartsConfig.apply(this, arguments);
    this.showToolbox = false;
    this.showChart = function () {
        var _myChart = echarts.init($('#' + this._containerId)[0], this._theme);
        var seriesdata = [];

        if ((!!this.data) && this.data.length > 0) {
            var _option = {
                title: {
                    text: this.title,
                    x: 'center'
                },
                //color: ['#0e95ef', '#53cdd5', '#a6eaff', '#c1f4ff', '#c8c8c8', '#ffe3bf', '#ffd48c', '#f6bd55'],
                tooltip: {
                    trigger: 'item',
                    formatter: "{a} <br/>{b} : {c} ({d}%)"
                },
                toolbox: {
                    show: this.showToolbox,
                    feature: {
                        magicType: {
                            show: true,
                            type: ['pie', 'funnel'],
                            option: {
                                funnel: {
                                    x: '25%',
                                    width: '50%',
                                    funnelAlign: 'left',
                                    max: 1548
                                }
                            }
                        },
                        restore: { show: true },
                        saveAsImage: { show: true }
                    }
                },
                calculable: true,
                series: [
                    {
                        name: this._title,
                        type: 'pie',
                        radius: ['0%', '50%'],
                        label: {
                            normal: {                                
                                textStyle: {
                                    color: '#000',
                                    fontSize:16
                                }
                            }
                        },
                        labelLine:{
                            normal: {
                                lineStyle: {
                                    color: '#000'
                                }
                            }
                        },
                        center: ['50%', '45%'],
                        itemStyle:{
                            normal: {
                                label:{
                                    show:true,
                                    formatter: "{b} ({d}%)"
                                }
                            }
                        },
                        data: this.data
                    }
                ]
            };

            _myChart.setOption(_option);
            if (!!this.onLoaded) {
                var length = _myChart._chartsViews[0]._data._rawData.length;
                var data = [];
                for (var i = 0; i < length; i++) {
                    var color = _myChart._chartsViews[0]._data._itemVisuals[i].color;
                    var name = _myChart._chartsViews[0]._data._rawData[i].name;
                    var value = _myChart._chartsViews[0]._data._rawData[i].value;
                    data[i] = { color: color, name: name, value: value };
                }

                this.onLoaded(data);
            }
            if (!!this.onClick) {
                _myChart.on("click", this.onClick);
            }
        }
        else {
            //没有数据;
        }
    };
}

function ChartStackLine() {
    EChartsConfig.apply(this, arguments);
    this.showToolbox = true;
    this.showChart = function () {
        var _myChart = echarts.init($('#' + this._containerId)[0]);
        var seriesdata = [];
        if (this._data.length > 0) {
            var area_data = [];
            var series_data = [];
            for (var i = 0; i < this._data.length; i++) {
                area_data[i] = this._data[i].AREA_NAME;
                series_data[i] = { name: this._data[i].AREA_NAME, type: 'line', data: eval("[" + this._data[i].SL + "]") };
            }

            var _option = {
                title: {
                    text: this._title,
                    x: 'center'
                },
                tooltip: {
                    trigger: 'axis'
                },
                legend: {
                    //orient: 'vertical'/\';;,
                    y: 'bottom',
                    data: area_data
                },
                toolbox: {
                    show: true,
                    feature: {
                        magicType: { show: true, type: ['line', 'bar', 'stack', 'tiled'] },
                        restore: { show: true },
                        saveAsImage: { show: true }
                    }
                },
                calculable: true,
                xAxis: [
                    {
                        boundaryGap: false,
                        data: this.xAxisLabels
                    }
                ],
                yAxis: [
                    {
                        type: 'value',
                        axisLabel: {
                            formatter: '{value} ' + this.yAxisSuffix
                        }
                    }
                ],
                series: series_data
            };

            _myChart.setOption(_option);
            //_myChart.on('click', this.onClick);
        }
        else {
            //没有数据;
        }
    };
}

