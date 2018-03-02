<extend name="./Application/Admin/View/default/base/context/add.tpl"/>
<block name="body_main">
    <div class="page-container">
        <p class="f-20 text-success">欢迎使用后台管理系统！</p>
        <p> 登录IP：<php> echo $_SERVER['REMOTE_ADDR'];</php>   </p>

        <table class="table table-border table-bordered table-bg mt-20">
            <thead>
            <tr>
                <th colspan="2" scope="col">服务器信息</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <th width="25%">服务器IP地址</th>
                <td><php> echo $_SERVER['SERVER_ADDR']; </php></td>
            </tr>
            <tr>
                <td>服务器域名</td>
                <td><php> echo $_SERVER["HTTP_HOST"]; </php></td>
            </tr>
            <tr>
                <td>服务器端口 </td>
                <td><php> echo $_SERVER['SERVER_PORT']; </php></td>
            </tr>
            <tr>
                <td>服务器版本 </td>
                <td><php> echo $_SERVER['SERVER_SOFTWARE']; </php></td>
            </tr>
            <tr>
                <td>服务器操作系统 </td>
                <td><php> echo php_uname(); </php></td>
            </tr>
            <tr>
                <td>服务器当前时间 </td>
                <td><php> echo date("Y-m-d G:i:s") </php></td>
            </tr>
            <tr>
                <td>最大上传限制：</td>
                <td><php> echo get_cfg_var ("upload_max_filesize")?get_cfg_var ("upload_max_filesize"):"不允许上传附件"; </php></td>
            </tr>
            <tr>
                <td>PHP版本</td>
                <td><php> echo PHP_VERSION; </php></td>
            </tr>
            <tr>
                <td>PHP调用方式 </td>
                <td><php> echo php_sapi_name(); </php></td>
            </tr>
            <tr>
                <td>当前客户端信息 </td>
                <td><php> echo $_SERVER['HTTP_USER_AGENT']; </php></td>
            </tr>
            </tbody>
        </table>
    </div>
</block>