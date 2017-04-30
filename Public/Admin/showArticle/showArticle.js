/**
 * Created by LiangWentao on 1/6/2017.
 */
// 基于准备好的dom，初始化echarts实例
var myChart = echarts.init(document.getElementById('main'));

// 指定图表的配置项和数据
option = {
    title: {
        text: '文章七日访问量'
    },
    tooltip: {
        trigger: 'axis'
    },
    legend: {
        data:['通过PC访问','通过手机web访问']
    },
    grid: {
        left: '3%',
        right: '4%',
        bottom: '3%',
        containLabel: true
    },
    toolbox: {
        feature: {
            saveAsImage: {}
        }
    },
    xAxis: {
        type: 'category',
        boundaryGap: false,
        data: []
    },
    yAxis: {
        type: 'value'
    },
    series: [
        {
            name:'通过PC访问',
            type:'line',
            stack: '总量',
            data:[]
        },
        {
            name:'通过手机web访问',
            type:'line',
            stack: '总量',
            data:[]
        },
    ]
};
//一个简单的加载动画
myChart.showLoading();

// 使用刚指定的配置项和数据显示图表。
$.get(viewDataUrl).done(function (data) {
    myChart.hideLoading();
    data = $.parseJSON(data);
    // 填入数据
    myChart.setOption({
        xAxis: {
            data: data.date
        },
        series: [{
            // 根据名字对应到相应的系列
            name: '通过PC访问',
            data: data.num
        }]
    });
});
myChart.setOption(option);

//访问人员地理位置分布
var locationChart = echarts.init(document.getElementById('location'));

locationOption = {
    title: {
        text: '访问人员分布',
        left: 'center'
    },
    legend: {
        orient: 'vertical',
        left: 'left',
        top:'10%',
        data:['访问数量']
    },
    tooltip: {
        trigger: 'item'
    },
    visualMap: {
        min: 0,
        max: 2500,
        left: 'left',
        top: 'bottom',
        text: ['高','低'],           // 文本，默认为数值文本
        calculable: true
    },
    toolbox: {
        show: true,
        orient: 'vertical',
        left: 'right',
        top: 'center',
        feature: {
            dataView: {readOnly: false},
            restore: {},
            saveAsImage: {}
        }
    },
    series: [
        {
            name: '访问数量',
            type: 'map',
            mapType: 'china',
            roam: false,
            label: {
                normal: {
                    show: true
                },
                emphasis: {
                    show: true
                }
            },
            data:[
            ]
        },
    ]
};
//一个简单的加载动画
locationChart.showLoading();
// 使用刚指定的配置项和数据显示图表。
$.get(locationDataUrl).done(function (data) {
    locationChart.hideLoading();
    data = $.parseJSON(data);
    // 填入数据
    locationChart.setOption({
        series: [
            {
                name: '访问数量',
                type: 'map',
                mapType: 'china',
                roam: false,
                label: {
                    normal: {
                        show: true
                    },
                    emphasis: {
                        show: true
                    }
                },
                data: data
            },
        ]
    });
});
locationChart.setOption(locationOption);



var locationChart2 = echarts.init(document.getElementById('location2'));
locationOption2 = {
    title:{
        text: '文章综合排名'
    },
    tooltip : {
        trigger: 'axis',
        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
        }
    },
    legend: {
        left:'auto',
        data: ['直接访问', '邮件营销','联盟广告','视频广告','搜索引擎']
    },
    grid: {
        left: '3%',
        right: '4%',
        bottom: '3%',
        containLabel: true
    },
    xAxis:  {
        type: 'value'
    },
    yAxis: {
        type: 'category',
        data: ['周一','周二','周三','周四','周五','周六','周日'],
        position:'right'
    },
    series: [
        {
            name: '直接访问',
            type: 'bar',
            stack: '总量',
            label: {
                normal: {
                    show: true,
                    position: 'insideLeft'
                }
            },
            data: [320, 302, 301, 334, 390, 330, 320]
        },
        {
            name: '邮件营销',
            type: 'bar',
            stack: '总量',
            label: {
                normal: {
                    show: true,
                    position: 'insideRight'
                }
            },
            data: [120, 132, 101, 134, 90, 230, 210]
        },
        {
            name: '联盟广告',
            type: 'bar',
            stack: '总量',
            label: {
                normal: {
                    show: true,
                    position: 'insideRight'
                }
            },
            data: [220, 182, 191, 234, 290, 330, 310]
        },
        {
            name: '视频广告',
            type: 'bar',
            stack: '总量',
            label: {
                normal: {
                    show: true,
                    position: 'insideRight'
                }
            },
            data: [150, 212, 201, 154, 190, 330, 410]
        },
        {
            name: '搜索引擎',
            type: 'bar',
            stack: '总量',
            label: {
                normal: {
                    show: true,
                    position: 'insideRight'
                }
            },
            data: [820, 832, 901, 934, 1290, 1330, 1320]
        }
    ]
};
locationChart2.setOption(locationOption2);