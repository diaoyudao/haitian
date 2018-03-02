<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>iview example</title>
    <link rel="stylesheet" type="text/css" href="/public/ivue/iview.css">
    <link rel="stylesheet" type="text/css" href="/public/ivue/ionicons-2.0.1/css/ionicons.min.css">
    <script type="text/javascript" src="/public/ivue/vue.2.4.4.min.js"></script>
    <script type="text/javascript" src="/public/ivue/iview.min.js"></script>
    <style>
body{
    font-family: "Helvetica Neue",Helvetica,"PingFang SC","Hiragino Sans GB","Microsoft YaHei","微软雅黑";
}
</style>
</head>
<body>

<div id="app">
    <i-button @click="show">Click me!</i-button>
    <Modal v-model="visible" title="Welcome">欢迎使用 iView</Modal>
    <div>
    <i-row>
        <i-col span="12">col-12</i-col>
        <i-col span="12">col-12</i-col>
    </i-row>
    <br>
    <i-row>
        <i-col span="8">col-8</i-col>
        <i-col span="8">col-8</i-col>
        <i-col span="8">col-8</i-col>
    </i-row>
    <br>
    <i-row>
        <i-col span="6">col-6</i-col>
        <i-col span="6">col-6</i-col>
        <i-col span="6">col-6</i-col>
        <i-col span="6">col-6</i-col>
    </i-row>
    </div>
</div>

<div>
    <template>
    <Row>
        <Col span="12">col-12</Col>
        <Col span="12">col-12</Col>
    </Row>
    <br>
    <Row>
        <Col span="8">col-8</Col>
        <Col span="8">col-8</Col>
        <Col span="8">col-8</Col>
    </Row>
    <br>
    <Row>
        <Col span="6">col-6</Col>
        <Col span="6">col-6</Col>
        <Col span="6">col-6</Col>
        <Col span="6">col-6</Col>
    </Row>
</template>
</div>
------------------------------------<br>
<div id="dccc">
<i-form ref="formValidate" :model="formValidate" :rules="ruleValidate" :label-width="80">
        <form-item label="姓名" prop="name">
            <i-input v-model="formValidate.name" placeholder="请输入姓名"></i-input>
        </form-item>
        <form-item label="邮箱" prop="mail">
            <i-input v-model="formValidate.mail" placeholder="请输入邮箱"></i-input>
        </form-item>
        <form-item label="城市" prop="city">
            <i-select v-model="formValidate.city" placeholder="请选择所在地">
                <i-option value="beijing">北京市</i-option>
                <i-option value="shanghai">上海市</i-option>
                <i-option value="shenzhen">深圳市</i-option>
            </i-select>
        </form-item>
        <form-item label="选择日期">
            <row>
                <i-col span="11">
                    <form-item prop="date">
                        <date-picker type="date" placeholder="选择日期" v-model="formValidate.date"></date-picker>
                    </form-item>
                </i-col>
                <i-col span="2" style="text-align: center">-</i-col>
                <i-col span="11">
                    <form-item prop="time">
                        <time-picker type="time" placeholder="选择时间" v-model="formValidate.time"></time-picker>
                    </form-item>
                </i-col>
            </row>
        </form-item>
        <form-item label="性别" prop="gender">
            <radio-group v-model="formValidate.gender">
                <radio label="male">男</radio>
                <radio label="female">女</radio>
            </radio-group>
        </form-item>
        <form-item label="爱好" prop="interest">
            <checkbox-group v-model="formValidate.interest">
                <checkbox label="吃饭"></checkbox>
                <checkbox label="睡觉"></checkbox>
                <checkbox label="跑步"></checkbox>
                <checkbox label="看电影"></checkbox>
            </checkbox-group>
        </form-item>
        <form-item label="介绍" prop="desc">
            <i-input v-model="formValidate.desc" type="textarea" :autosize="{minRows: 2,maxRows: 5}" placeholder="请输入..."></i-input>
        </form-item>
        <form-item>
            <i-button type="primary" @click="handleSubmit('formValidate')">提交</i-button>
            <i-button type="ghost" @click="handleReset('formValidate')" style="margin-left: 8px">重置</i-button>
        </form-item>
    </i-form>

    <row>
        <i-col span="12">
            <date-picker type="date" placeholder="选择日期" style="width: 200px"></date-picker>
        </i-col>
        <i-col span="12">
            <date-picker type="daterange" placement="bottom-end" placeholder="选择日期" style="width: 200px"></date-picker>
        </i-col>
    </row>
</div>
<div>
    <style scoped>
    .layout{
        border: 1px solid #d7dde4;
        background: #f5f7f9;
    }
    .layout-logo{
        width: 100px;
        height: 30px;
        background: #5b6270;
        border-radius: 3px;
        float: left;
        position: relative;
        top: 15px;
        left: 20px;
    }
    .layout-nav{
        width: 420px;
        margin: 0 auto;
    }
    .layout-assistant{
        width: 300px;
        margin: 0 auto;
        height: inherit;
    }
    .layout-breadcrumb{
        padding: 10px 15px 0;
    }
    .layout-content{
        min-height: 200px;
        margin: 15px;
        overflow: hidden;
        background: #fff;
        border-radius: 4px;
    }
    .layout-content-main{
        padding: 10px;
    }
    .layout-copy{
        text-align: center;
        padding: 10px 0 20px;
        color: #9ea7b4;
    }
</style>
<template>
    <div class="layout">
        <Menu mode="horizontal" theme="dark" active-name="1">
            <div class="layout-logo"></div>
            <div class="layout-nav">
                <MenuItem name="1">
                    <Icon type="ios-navigate"></Icon>
                    导航一
                </MenuItem>
                <MenuItem name="2">
                    <Icon type="ios-keypad"></Icon>
                    导航二
                </MenuItem>
                <MenuItem name="3">
                    <Icon type="ios-analytics"></Icon>
                    导航三
                </MenuItem>
                <MenuItem name="4">
                    <Icon type="ios-paper"></Icon>
                    导航四
                </MenuItem>
            </div>
        </Menu>
        <Menu mode="horizontal" active-name="1">
            <div class="layout-assistant">
                <MenuItem name="1">二级导航</MenuItem>
                <MenuItem name="2">二级导航</MenuItem>
                <MenuItem name="3">二级导航</MenuItem>
            </div>
        </Menu>
        <div class="layout-content">
            <Row>
                <i-col span="5">
                    <Menu active-name="1-2" width="auto" :open-names="['1']">
                        <Submenu name="1">
                            <template slot="title">
                                <Icon type="ios-navigate"></Icon>
                                导航一
                            </template>
                            <MenuItem name="1-1">选项 1</MenuItem>
                            <MenuItem name="1-2">选项 2</MenuItem>
                            <MenuItem name="1-3">选项 3</MenuItem>
                        </Submenu>
                        <Submenu name="2">
                            <template slot="title">
                                <Icon type="ios-keypad"></Icon>
                                导航二
                            </template>
                            <MenuItem name="2-1">选项 1</MenuItem>
                            <MenuItem name="2-2">选项 2</MenuItem>
                        </Submenu>
                        <Submenu name="3">
                            <template slot="title">
                                <Icon type="ios-analytics"></Icon>
                                导航三
                            </template>
                            <MenuItem name="3-1">选项 1</MenuItem>
                            <MenuItem name="3-2">选项 2</MenuItem>
                        </Submenu>
                    </Menu>
                </i-col>
                <i-col span="19">
                    <div class="layout-content-main">内容区域</div>
                </i-col>
            </Row>
        </div>
        <div class="layout-copy">
            2011-2016 &copy; TalkingData
        </div>
    </div>
</template>


</div>
<script>
    new Vue({
        el: '#app',
        data: {
            visible: false
        },
        methods: {
            show: function () {
                this.visible = true;
            }
        }
    })

    var Main = {
        data () {
            return {
                formValidate: {
                    name: '',
                    mail: '',
                    city: '',
                    gender: '',
                    interest: [],
                    date: '',
                    time: '',
                    desc: ''
                },
                ruleValidate: {
                    name: [
                        { required: true, message: '姓名不能为空', trigger: 'blur' }
                    ],
                    mail: [
                        { required: true, message: '邮箱不能为空', trigger: 'blur' },
                        { type: 'email', message: '邮箱格式不正确', trigger: 'blur' }
                    ],
                    city: [
                        { required: true, message: '请选择城市', trigger: 'change' }
                    ],
                    gender: [
                        { required: true, message: '请选择性别', trigger: 'change' }
                    ],
                    interest: [
                        { required: true, type: 'array', min: 1, message: '至少选择一个爱好', trigger: 'change' },
                        { type: 'array', max: 2, message: '最多选择两个爱好', trigger: 'change' }
                    ],
                    date: [
                        { required: true, type: 'date', message: '请选择日期', trigger: 'change' }
                    ],
                    time: [
                        { required: true, type: 'date', message: '请选择时间', trigger: 'change' }
                    ],
                    desc: [
                        { required: true, message: '请输入个人介绍', trigger: 'blur' },
                        { type: 'string', min: 20, message: '介绍不能少于20字', trigger: 'blur' }
                    ]
                }
            }
        },
        methods: {
            handleSubmit (name) {
                this.$refs[name].validate((valid) => {
                    if (valid) {
                        this.$Message.success('提交成功!');
                    } else {
                        this.$Message.error('表单验证失败!');
                    }
                })
            },
            handleReset (name) {
                this.$refs[name].resetFields();
            }
        }
    }

var Component = Vue.extend(Main)
new Component().$mount('#dccc')

  </script>
</body>
</html>