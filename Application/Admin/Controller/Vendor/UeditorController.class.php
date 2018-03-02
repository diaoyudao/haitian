<?php
namespace Admin\Controller\Vendor;

use Think\Controller;

class UeditorController extends Controller
{
    public function index()
    {
        require('./Application/Admin/Common/Vendor/ueditor/controller.php');
    }
}