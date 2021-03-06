<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%request.setAttribute("ctx", request.getContextPath());%>
<html>
<head>
    <title>Title</title>
</head>

<link href="${ctx}/core/css/bootstrap.min.css" rel="stylesheet">
<link href="${ctx}/core/css/table.css" rel="stylesheet">
<link rel="stylesheet" href="${ctx}/core/layui/css/layui.css" media="all">
<style>
    .newTr {
        transition: all 5s ease-in;
    }

    .slideTest {
        background: lightskyblue;
        height: 500px;
        width: 500px;
    }

    .slideTest div {
        float: left;
        display: inline-block;
    }

    .slideTest div {
        background: #00fa2a;
        height: 50px;
        width: 50px;
    }

    .slideTest div:nth-child(even) {
        background: #00fa2a;
        height: 50px;
        width: 50px;
    }

    .slideTest div:nth-child(odd) {
        background: #fa3037;
        height: 50px;
        width: 50px;
    }
</style>
<body>
<button id="demo-button">点击测试</button>

<div class="container">
    <div class="row clearfix">
        <div class="col-md-12 column">
            <form id="form" action="${ctx}/role/add.do">
                <div class="form-group">
                    <label>主键222111</label><input type="number" class="form-control" name="id" value="111"/>
                </div>
                <div class="form-group">
                    <label>主要信息</label><input class="form-control" type="email" name="rolename" value="baichoulishang@163.com"/>
                </div>
                <div class="form-group">
                    <label>备注</label><input class="form-control" name="note" value="shit"/>
                </div>
                <button type="submit" class="btn btn-default" id="submit">提交</button>
                <button type="reset" class="btn btn-block">重置</button>
            </form>
        </div>
    </div>
</div>

<div class="slideTest">
</div>

<table class="gridtable">
    <tr id="firstTr">
        <th>Info Header 1</th>
        <th>Info Header 2</th>
        <th>Info Header 3</th>
    </tr>
    <tr>
        <td id="testClick">点击我有惊喜哦！！</td>
        <td id="testChange">监听div内容变化</td>
        <td>Text 1C</td>
    </tr>
    <tr>
        <td>Text 2A</td>
        <td>Text 2B</td>
        <td>Text 2C</td>
    </tr>
</table>

<table class="layui-hide" id="test"></table>

<div class="layui-row layui-col-space15">
    <div class="layui-col-xs12 beforeLoading">
        <div id="container" style="min-width:400px;height:400px"></div>
    </div>

</div>
<script src="https://cdn.bootcss.com/push.js/1.0.5/push.js"></script>

</body>

<script src="${ctx}/core/js/jquery-3.3.1.min.js"></script>
<script src="${ctx}/core/js/bootstrap.js"></script>
<script src="${ctx}/core/layui/layui.all.js" charset="utf-8"></script>


<script>

    $(function () {
        var button = document.getElementById("demo-button");
        Push.Permission.request();
        button.onclick = function () {
            Push.create("您有新的消息", {
                body: "<span>哦~~~~</span>",
                icon: 'https://huyaimg.msstatic.com/avatar/1018/fe/02c963ecb4905b0a7e096e98253f7b_180_135.jpg?435514',
                timeout: 1000
            });
        };


        $('.slideTest div:first-child').empty().html('<div></div>');
        var ele = '<div></div>';
        $(ele).css('width', 0).insertBefore().animate({width: 50}, 1000);


        $('#testClick').on('click', function () {
            var str = $('#form').serialize();
            $.ajax({
                type: "GET",
                url: "${ctx}/role/getList.do",
                data: str,
                dataType: "text",
                success: function (data) {
                    // 把后台传过来的json字符串进行解析
                    data = JSON.parse(data);
                    var tableData = data.data.list;
                    layui.use('table', function () {
                        var table = layui.table;
                        table.render({
                            elem: '#test'
                            , data: tableData
                            , cellMinWidth: 80 //全局定义常规单元格的最小宽度，layui 2.2.1 新增
                            , cols: [[
                                {field: 'id', width: '20%', title: 'ID', sort: true}
                                , {field: 'rolename', width: '50%', title: '用户名'}
                                , {field: 'note', width: '30%', title: '性别', sort: true}
                            ]]
                            , page: { //支持传入 laypage 组件的所有参数（某些参数除外，如：jump/elem） - 详见文档
                                layout: ['limit', 'count', 'prev', 'page', 'next', 'skip'] //自定义分页布局
                                //,curr: 5 //设定初始在第 5 页
                                , groups: 5 //只显示 1 个连续页码
                                , first: true //不显示首页
                                , last: true //不显示尾页

                            }
                        });
                    });
                },
                error: function (res) {
                    console.log("难道是出错了？？？");
                }
            });
        });

        <%--$(".btn-default").on('click', function () {--%>
        <%--    var str = $('#form').serialize();--%>
        <%--    $.ajax({--%>
        <%--        type: "GET",--%>
        <%--        url: "${ctx}/role/add.do",--%>
        <%--        data: str,--%>
        <%--        dataType: "text",--%>
        <%--        success: function (data) {--%>
        <%--            layer.msg("添加成功啦");--%>
        <%--        },--%>
        <%--        error: function (res) {--%>
        <%--            console.log("难道是出错了？？？");--%>
        <%--        }--%>
        <%--    });--%>
        <%--});--%>
        console.log("由$定义的");

        $('.gridtable').on('click', function (e) {
            debugger;
        });

    });

    window.onscroll = function (ev) {
        console.log("检测到了滚动");
    };


    window.onunload = function (ev) {
        alert("触发了onunload");
        console.log("触发了onunload");
    };

    window.onresize = function (ev) {
        console.log("大小发生了变化");
    };


    const data = [
        {
            name: "Kris",
            age: "24"
        },
        {
            name: "Andy",
            age: "25"
        },
        {
            name: "Andy",
            age: "25"
        }
    ];
    // 设置reduce的内置函数
    const dataReducer = (prev, cur, idx) => {
        let obj = {};
        // 这个写法很骚气,可以直接将name的值赋为cur[name]
        const {name} = cur;
        obj[name] = cur;
        return {...prev, ...obj};
    };
    // 对data调用reduce函数,返回值是一个对象
    const reducedData = data.reduce(dataReducer, {});
    // 得到value集合
    let newData = Object.values(reducedData);


    var createList = (item, idx) => {
        let obj = {};
        obj[`a${idx}`] = "data";
        return obj;
    };
    var listReducer = (acc, cur) => (!acc ? {...cur} : {...cur, ...acc});
    var obj = Array.from(new Array(20), createList).reduce(listReducer);
    console.log(obj);


    let key = "ok";
    let shit = {
        key: "fine"
    };
    let data = shit;

</script>
<script src="${ctx}/core/js/test.js?ver=<%=System.currentTimeMillis()%>"></script>
</html>
