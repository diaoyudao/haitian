<script>
// 全局变量
var $datas = [];  // 临时
var $depart = null; // 部门
var $new_time = '{$year}'+'-'+'{$month}';
var $lia_time = '{$year}'+'-'+'{$month}';
var $year = '{$year}';
var $new_m = '{$month}';
var $lia_m = '{$month}';

var option,option2,option3,option4,option5;
var myAdd,myLiaison,myContract,myChart,myChart2;
var cust_data,classify;

function customer() {
    var url = '/service/statistics/project/customer'
    var param={
        department_id: $depart,
    }
    
    callUrl(param,url,function(data){
        console.log('begin customer222',data)
        var total = 0
        for(var i =0; i<=4; i++) {
            var j = ((0 == i)?3:((4 == i)?4:(i-1)))
            if(data.customer_type && data.customer_type[i.toString()]) {
                cust_data[j].value = data.customer_type[i.toString()]
                total += parseInt(cust_data[j].value);
            } else {
                cust_data[j].value = 0
            }            
        }    

        option.title.text = total;

        for(var i =0; i<=4; i++) {
            option.series[0].data[i].value=cust_data[i].value
        } 
        
        classify[0].value = (data.customer_level && data.customer_level['0'])?data.customer_level['0'] : 0;
        classify[1].value = (data.customer_level && data.customer_level['1'])?data.customer_level['1'] : 0;

        for(var i =0; i<=1; i++) {
            option2.series[0].data[i].value=classify[i].value
        }

        $('#new_yesterday').text(data.new_yesterday)
        $('#new_this_month').text(data.new_this_month)
        $('#new_last_month').text(data.new_last_month)
        
        $('#contract_yesterday').text(data.contract_yesterday)
        $('#contract_this_month').text(data.contract_this_month)
        $('#contract_last_month').text(data.contract_last_month)
        
        option.legend.data = cust_data;
        option2.legend.data = classify;
        myChart.setOption(option);
        myChart2.setOption(option2);
    })   
}

function newCustomer() {
    var url = '/service/statistics/project/newCustomer';
    var param={
        department_id: $depart,
        time: $new_time
    };
    callUrl(param,url,function(data){
        option3.title.text[0] = '新增客户数总计'+data.total;

        option3.xAxis[0].data = []
        for(var i =1; i<= data.max_day; i++) {
            option3.xAxis[0].data.push(i);

            if(data.day && data.day[i.toString()]) {
                var temp = data.day[i.toString()];
                option3.series[0].data[i-1] = (temp['1'])? temp['1'] : 0;
                option3.series[1].data[i-1] = (temp['2'])? temp['2'] : 0;
                option3.series[2].data[i-1] = (temp['3'])? temp['3'] : 0;
                option3.series[3].data[i-1] = (temp['0'])? temp['0'] : 0;
                option3.series[4].data[i-1] = (temp['4'])? temp['4'] : 0;
            } else {
                // '政府单位','旅游景区','企业公司','其他客户','海外客户'
                option3.series[0].data[i-1] = 0; 
                option3.series[1].data[i-1] = 0;
                option3.series[2].data[i-1] = 0;
                option3.series[3].data[i-1] = 0;
                option3.series[4].data[i-1] = 0;
            }            
        }

        myAdd.setOption(option3);
    })
}

function liaison() {
    var url = '/service/statistics/project/liaison'
    var param={
        department_id: $depart,
        time: $lia_time
    }
    callUrl(param,url,function(data){
        option4.title.text[0] = '联络客户数总计'+data.total;

        option4.xAxis[0].data = []
        for(var i =1; i<= data.max_day; i++) {
            option4.xAxis[0].data.push(i);

            if(data.day && data.day[i.toString()]) {
                var temp = data.day[i.toString()];
                option4.series[0].data[i-1] = (temp['1'])? temp['1'] : 0;
                option4.series[1].data[i-1] = (temp['2'])? temp['2'] : 0;
                option4.series[2].data[i-1] = (temp['3'])? temp['3'] : 0;
                option4.series[3].data[i-1] = (temp['0'])? temp['0'] : 0;
                option4.series[4].data[i-1] = (temp['4'])? temp['4'] : 0;
            } else {
                // '政府单位','旅游景区','企业公司','其他客户','海外客户'
                option4.series[0].data[i-1] = 0; 
                option4.series[1].data[i-1] = 0;
                option4.series[2].data[i-1] = 0;
                option4.series[3].data[i-1] = 0;
                option4.series[4].data[i-1] = 0;
            }            
        }

        myLiaison.setOption(option4);
    })
}

function contract() {
    var url = '/service/statistics/project/contract'
    var param={
        department_id: $depart,
        year: $year
    }
    callUrl(param,url,function(data){
        for(var i =1; i<= 12; i++) {
            if(data.month && data.month[i.toString()]) {
                var temp = data.month[i.toString()];
                option5.series[0].data[i-1] = (temp['num'])? temp['num'] : 0;
                option5.series[1].data[i-1] = (temp['fee'])? temp['fee'] : 0;
            } else {
                // '签订合同','合同规模'
                option5.series[0].data[i-1] = 0; 
                option5.series[1].data[i-1] = 0;
            }            
        }

        myContract.setOption(option5);
    })
}

function callAll() {
    customer()
    newCustomer()
    liaison()
    contract()
}

function callUrl(param,url, callback) {
    K.doAjax(param, url, function(res){
        if(res.status && 'success' ==res.status) {
            // 显示数据
            callback(res.data)
        }
    });
}
</script>