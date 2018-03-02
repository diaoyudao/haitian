<?php
namespace Client\Controller\Test;

use Think\Controller;

class TestController extends Controller
{
    
    public function index()
    {        
        for($i=0; $i <= 100; $i++) {
            echo 'ddddd---';
            sleep(3);
        }        
    }
}