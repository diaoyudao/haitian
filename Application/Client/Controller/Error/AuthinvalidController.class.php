<?php
namespace Home\Controller\Error;

use Think\Controller;

class AuthinvalidController extends Controller
{
    
    public function index()
    {
        $s_open_id = I('get.s_open_id', '');
        if($s_open_id) {
            cookie('s_open_id', $s_open_id, 24*3600);
        }

        \Think\Log::write(cookie('cur_open_id'));

        echo cookie('cur_open_id');
        
        $this->display();
    }
}